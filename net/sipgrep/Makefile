#
# Copyright (C) 2016 - 2018 Daniel Engberg <daniel.engberg.lists@pyret.net>
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sipgrep
PKG_VERSION:=2.2.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/sipcapture/sipgrep
PKG_MIRROR_HASH:=4fe322d672d5c78160ddf0f0bf599a14b2fc504437262ad08a4003fe66f3e4b5

PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

PKG_CONFIG_DEPENDS:=CONFIG_IPV6

include $(INCLUDE_DIR)/package.mk

define Package/sipgrep
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Telephony
  DEPENDS:=+libpcap +libpcre2
  TITLE:=Command line tool to sniff, capture, display SIP messages
  URL:=https://github.com/sipcapture/sipgrep
endef

define Package/sipgrep/description
Powerful pcap-aware command line tool to sniff, capture, display and
troubleshoot SIP signaling over IP networks, allowing the user to
specify extended regular expressions matching against SIP headers.
endef

CONFIGURE_ARGS+=$(if $(CONFIG_IPV6),en,dis)able-ipv6

define Package/sipgrep/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/sipgrep $(1)/usr/bin
endef

$(eval $(call BuildPackage,sipgrep))
