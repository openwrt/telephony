#!/usr/bin/perl

# This yate script will monitor failed authentications and temporarily
# blacklist IP addresses of users who fail to authenticate several times
# in a row.
#
# Blacklisted IP addresses are added to an IP set (you need to have openwrt
# package ipset installed) and you have to manually reference this IP set in
# your firewall configuration. For most people it's probably enough to add
# these custom firewall rules (in /etc/firewall.user):
#
# ipset create yate_blacklist hash:ip timeout 0
# iptables -I INPUT -m set --match-set yate_blacklist src -j DROP
#
# To enable this script in yate, add this script to the [scripts] section
# in /etc/yate/extmodule.conf.
#
# You can tweak how tolerant this script should be by modifying the constants
# below.

# How many failed authentications before blacklisting an IP.
my $MAX_AUTH_FAILURES = 10;

# Blacklist an IP if MAX_AUTH_FAILURES failed authentications happen within
# this time period.
my $MAX_AUTH_FAILURES_TIME_PERIOD = 60;  # seconds

# For how long should a blacklisted IP remain blocked.
my $BLACKLIST_TIMEOUT = 60 * 60;  # seconds (zero means no timeout)

# The name of the IP set to add blacklisted IP addresses to. The IP set needs
# to exist (type hash:ip) and must have timeout support.
my $IPSET_NAME = 'yate_blacklist';


use strict;
use warnings;
use lib '/usr/share/yate/scripts';
use Yate;

my %ip_auth_failures = ();

sub OnAuthenticationRequest($) {
  my $yate = shift;
  my $remote_ip = $yate->param('ip_host');
  my $remote_device = $yate->param('device');

  if ($yate->header('processed') eq 'true') {
    # Successful authentication, forget previous failures
    delete $ip_auth_failures{$remote_ip};
    return;
  }

  push(@{$ip_auth_failures{$remote_ip}}, time);
  if (scalar(@{$ip_auth_failures{$remote_ip}}) > $MAX_AUTH_FAILURES) {
    $yate->output("Blacklisting $remote_ip (remote device: $remote_device)");
    `ipset add $IPSET_NAME $remote_ip timeout $BLACKLIST_TIMEOUT`;
    delete $ip_auth_failures{$remote_ip};
  }
}

sub OnTimerEvent($) {
  my $yate = shift;

  # Forget failed authentications outside of MAX_AUTH_FAILURES_TIME_PERIOD
  foreach my $ip (keys(%ip_auth_failures)) {
    my $failures = \@{$ip_auth_failures{$ip}};
    while (@$failures &&
           time - @$failures[0] > $MAX_AUTH_FAILURES_TIME_PERIOD) {
        shift(@$failures);
    }

    if (!@$failures) {
      delete $ip_auth_failures{$ip};
    }
  }
}

my $yate = new Yate();
$yate->install_watcher("user.auth", \&OnAuthenticationRequest);
$yate->install_watcher("engine.timer", \&OnTimerEvent);
$yate->listen();
