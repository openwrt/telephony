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

PKG_BUILD_DIR=$(BUILD_DIR)/asterisk-g72x-$(PKG_VERSION)
PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=README.md
PKG_MAINTAINER:=Alex Samorukov <samm@os2.kiev.ua>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/asterisk-g72x/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=G.729 codec support
  URL:=http://asterisk.hosting.lv
  DEPENDS:=+bcg729
endef

define Package/asterisk16-codec-g729
$(call Package/asterisk-g72x/Default)
  DEPENDS+=asterisk16
  VARIANT:=asterisk16
endef

define Package/description/Default
 Asterisk G.729 codec based on bcg729 implementation.
endef

Package/asterisk16-codec-g729/description = $(Package/description/Default)

CONFIGURE_ARGS+= \
	--with-bcg729 \
	--enable-shared

ifeq ($(BUILD_VARIANT),asterisk16)
CONFIGURE_ARGS+= \
	--with-asterisk-includes=$(STAGING_DIR)/usr/include/asterisk-16/include \
	--with-asterisk160
endif

define Package/Install/Default
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/asterisk/modules/codec_g729.so \
		$(1)/usr/lib/asterisk/modules/
endef

Package/asterisk16-codec-g729/install = $(Package/Install/Default)

$(eval $(call BuildPackage,asterisk16-codec-g729))
