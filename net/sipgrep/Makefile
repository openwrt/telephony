#
# Copyright (C) 2016 - 2018 Daniel Engberg <daniel.engberg.lists@pyret.net>
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sipgrep
PKG_VERSION:=2.2.1-20160621
PKG_RELEASE:=1
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/sipcapture/sipgrep.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=df8a95b066569be92aa38cad01086ea595b36863
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_MIRROR_HASH:=9b40ecd7822c84740fcf0032ab5c54195df545162c623699232b78da6ae225d2

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

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

CONFIGURE_ARGS += \
	--enable-ipv6

define Package/sipgrep/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/sipgrep $(1)/usr/bin
endef

$(eval $(call BuildPackage,sipgrep))
