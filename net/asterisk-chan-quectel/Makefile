#
# Copyright (C) 2017 - 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk-chan-quectel
PKG_VERSION:=1.2-20210918
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/etnperlong/asterisk-chan-quectel.git
PKG_SOURCE_VERSION:=ddcc56cb7d1115edf5d735a9a9b8fd42e6229303
PKG_SOURCE_DATE=2021-09-18
PKG_MIRROR_HASH:=ee0734e9bcf0ec7ae1b4ccb6ee08ecb0924231869c2ff6e306afb4a74343fcdf

PKG_FIXUP:=autoreconf

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYRIGHT.txt LICENSE.txt
PKG_MAINTAINER:=spacedream <spacedream@tutamail.com>

MODULES_DIR:=/usr/lib/asterisk/modules

include $(INCLUDE_DIR)/package.mk
# asterisk-chan-quectel needs iconv
include $(INCLUDE_DIR)/nls.mk

define Package/asterisk-chan-quectel
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=https://github.com/t4rd15/asterisk-chan-quectel
  DEPENDS:=asterisk $(ICONV_DEPENDS) +libsqlite3
  TITLE:=Quectel EC25 modem support
endef

define Package/asterisk-chan-quectel/description
 Asterisk channel driver for Quectel EC25 modem.
endef

CONFIGURE_ARGS+= \
	--with-asterisk=$(STAGING_DIR)/usr/include \
	--with-astversion=18 \
	--with-iconv=$(ICONV_PREFIX)/include

MAKE_FLAGS+=LD="$(TARGET_CC)"

CONFIGURE_VARS += \
	DESTDIR="$(MODULES_DIR)" \
	ac_cv_type_size_t=yes \
	ac_cv_type_ssize_t=yes

define Package/asterisk-chan-quectel/conffiles
/etc/asterisk/quectel.conf
endef

define Package/asterisk-chan-quectel/install
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/quectel.conf $(1)/etc/asterisk
	$(INSTALL_DIR) $(1)$(MODULES_DIR)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/chan_quectel.so $(1)$(MODULES_DIR)
endef

$(eval $(call BuildPackage,asterisk-chan-quectel))
