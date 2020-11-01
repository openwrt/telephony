#
# Copyright (C) 2017 - 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk-chan-dongle

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/wdoekes/asterisk-chan-dongle.git
PKG_SOURCE_VERSION:=328b2b7ded3b3c59c2e6c7e7afca6b0ac6f146ce
PKG_SOURCE_DATE=2020-05-28
PKG_RELEASE:=1
PKG_MIRROR_HASH:=b0af444840340722ecee111a7b1f819de441acf290799ae11bc18e16569c6388

PKG_FIXUP:=autoreconf

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYRIGHT.txt LICENSE.txt
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

MODULES_DIR:=/usr/lib/asterisk/modules

include $(INCLUDE_DIR)/package.mk
# asterisk-chan-dongle needs iconv
include $(INCLUDE_DIR)/nls.mk

define Package/asterisk-chan-dongle
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=https://github.com/wdoekes/asterisk-chan-dongle
  DEPENDS:=asterisk $(ICONV_DEPENDS) +libsqlite3
  TITLE:=Huawei UMTS 3G dongle support
endef

define Package/asterisk-chan-dongle/description
 Asterisk channel driver for Huawei UMTS 3G dongle.
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

define Package/asterisk-chan-dongle/conffiles
/etc/asterisk/dongle.conf
endef

define Package/asterisk-chan-dongle/install
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/dongle.conf $(1)/etc/asterisk
	$(INSTALL_DIR) $(1)$(MODULES_DIR)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/chan_dongle.so $(1)$(MODULES_DIR)
endef

$(eval $(call BuildPackage,asterisk-chan-dongle))
