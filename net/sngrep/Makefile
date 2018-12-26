#
# Copyright (C) 2016 Daniel Engberg <daniel.engberg.lists@pyret.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sngrep
PKG_VERSION=1.4.6
PKG_RELEASE:=1
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>
PKG_LICENSE:=GPL-3.0+
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/irontec/$(PKG_NAME)/releases/download/v$(PKG_VERSION)
PKG_HASH:=638d6557dc68db401b07d73b2e7f8276800281f021fe0c942992566d6b59a48a

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/sngrep
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Telephony
  DEPENDS:=+libncursesw +libopenssl +libpcap +libpcre
  TITLE:=Ncurses SIP messages flow viewer
  URL:=https://github.com/irontec/sngrep
endef

define Package/sngrep/description
sngrep displays SIP messages grouped by Call-Id into flow diagrams. It
can be used as an offline pcap viewer or for online capture using
libpcap functions.

It supports SIP UDP and TCP transports (when each message is delivered
in one packet).
endef

define Package/sngrep/conffiles
/etc/sngreprc
endef

CONFIGURE_ARGS += \
	--enable-eep \
	--enable-ipv6 \
	--enable-unicode \
	--with-openssl \
	--with-pcre

define Package/sngrep/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/sngreprc $(1)/etc
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/sngrep $(1)/usr/bin
endef

$(eval $(call BuildPackage,sngrep))
