#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk-g72x
PKG_VERSION:=1.4.3
PKG_RELEASE:=1

PKG_SOURCE:=asterisk-g72x-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://asterisk.hosting.lv/src/
PKG_HASH:=ffea55374c2134415569b876a68d9a12ce376146a22fad3963c8edc281052adf

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=README.md
PKG_MAINTAINER:=Alex Samorukov <samm@os2.kiev.ua>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/asterisk-codec-g729
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=G.729 codec support
  URL:=http://asterisk.hosting.lv
  DEPENDS:=asterisk +bcg729
endef

define Package/asterisk-codec-g729/description
 Asterisk G.729 codec based on bcg729 implementation.
endef

CONFIGURE_ARGS+= \
	--with-bcg729 \
	--enable-shared \
	--with-asterisk-includes=$(STAGING_DIR)/usr/include

define Package/asterisk-codec-g729/install
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/asterisk/modules/codec_g729.so \
		$(1)/usr/lib/asterisk/modules/
endef

$(eval $(call BuildPackage,asterisk-codec-g729))
