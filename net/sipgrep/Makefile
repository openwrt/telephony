#
# Copyright (C) 2016 - 2018 Daniel Engberg <daniel.engberg.lists@pyret.net>
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sipgrep
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/sipcapture/sipgrep.git
PKG_SOURCE_VERSION:=1cc00079cd80310f7e8b1a696e9a02b8a2b25e04
PKG_SOURCE_DATE=2019-06-27
PKG_RELEASE:=2
PKG_MIRROR_HASH:=3480f83a4af2a2972f3aa981343b067fa35ddc74f42c3e459630f31aba8f2d91

PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

PKG_CONFIG_DEPENDS:=CONFIG_IPV6

include $(INCLUDE_DIR)/package.mk

define Package/sipgrep
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Telephony
  DEPENDS:=+libpcap +libpcre
  TITLE:=Command line tool to sniff, capture, display SIP messages
  URL:=https://github.com/sipcapture/sipgrep
endef

define Package/sipgrep/description
Powerful pcap-aware command line tool to sniff, capture, display and
troubleshoot SIP signaling over IP networks, allowing the user to
specify extended regular expressions matching against SIP headers.
endef

CONFIGURE_ARGS+=$(if $(CONFIG_IPV6),--enable-ipv6)

define Package/sipgrep/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/sipgrep $(1)/usr/bin
endef

$(eval $(call BuildPackage,sipgrep))
