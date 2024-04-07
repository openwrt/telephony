#!/usr/bin/perl

# This yate script will monitor authentication requests and update an
# nftables set with IP addresses of users who consistently fail to
# authenticate. The nftables set can then be used in OpenWrt's
# firewall configuration to block these IP addresses.
#
# The nftables set has to exist before launching yate.
#
# Here's an example configuration that creates an nftables set, where
# entries expire after 12 hours, and configures the OpenWrt firewall
# to drop packets where the source IP address is in the set. Put this
# in /etc/nftables.d/99-yate.nft:
#
#  set yate_denylist {
#      type ipv4_addr
#      timeout 12h
#  }
#
#  chain yate_filter {
#      type filter hook input priority -1; policy accept;
#      ip saddr @yate_denylist counter drop comment "Drop packets from bad SIP clients"
#  }
#
#
# To enable this script in yate, add it to the [scripts] section in
# /etc/yate/extmodule.conf.
#
# You can tweak how tolerant this script should be by modifying the
# constants below.

# A user's IP address will be added to the nftables set if there are
# more than MAX_AUTH_FAILURES consecutive authentication failures in
# MAX_AUTH_FAILURES_TIME_PERIOD seconds.
my $MAX_AUTH_FAILURES = 5;
my $MAX_AUTH_FAILURES_TIME_PERIOD = 3600;  # seconds

# The name of the nftables table and set where IP addresses are added.
my $NFTABLES_TABLE = 'inet fw4';
my $NFTABLES_SET = 'yate_denylist';


use strict;
use warnings;
use lib '/usr/share/yate/scripts';
use Yate;

my %ip_auth_failures = ();

sub OnAuthenticationRequest($) {
  my $yate = shift;

  # Forget any expired failed authentications
  foreach my $ip (keys(%ip_auth_failures)) {
    my $failures = \@{$ip_auth_failures{$ip}};
    while (@$failures &&
           time() - @$failures[0] > $MAX_AUTH_FAILURES_TIME_PERIOD) {
        shift(@$failures);
    }

    if (!@$failures) {
      delete $ip_auth_failures{$ip};
    }
  }

  my $remote_ip = $yate->param('ip_host');
  my $remote_device = $yate->param('device') || '<unknown>';

  if ($yate->header('processed') eq 'true') {
    $yate->output("banbrutes: Successful authentication from $remote_ip");
    delete $ip_auth_failures{$remote_ip};
    return;
  }

  $yate->output("banbrutes: Failed authentication from $remote_ip");
  push(@{$ip_auth_failures{$remote_ip}}, time());
  if (scalar(@{$ip_auth_failures{$remote_ip}}) > $MAX_AUTH_FAILURES) {
    $yate->output("banbrutes: Adding $remote_ip to nftables set $NFTABLES_SET (remote device: $remote_device)");
    `nft add element $NFTABLES_TABLE $NFTABLES_SET { $remote_ip }`;
    delete $ip_auth_failures{$remote_ip};
  }
}

my $yate = new Yate();
$yate->install_watcher("user.auth", \&OnAuthenticationRequest);
$yate->listen();
