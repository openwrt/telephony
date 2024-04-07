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
PKG_SOURCE_VERSION:=503dba87d726854b74b49e70679e64e6e86d5812
PKG_SOURCE_DATE=2022-11-04
PKG_RELEASE:=1
PKG_MIRROR_HASH:=3cd8ea6e641a7623ba06000832ec5079e08f6f5eb234a3270710856fa0a37609

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
	--with-astversion=18

ifeq ($(CONFIG_BUILD_NLS),y)
CONFIGURE_ARGS+=--with-iconv=$(ICONV_PREFIX)/include
else
CONFIGURE_ARGS+=--with-iconv=$(TOOLCHAIN_DIR)/include
endif

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

define Package/asterisk-chan-dongle/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  echo
  echo "o-------------------------------------------------------------------o"
  echo "| asterisk-chan-dongle note                                         |"
  echo "o-------------------------------------------------------------------o"
  echo "| Adding the \"asterisk\" user to the \"dialout\" group might be        |"
  echo "| required for asterisk to be able to access the dongle.            |"
  echo "o-------------------------------------------------------------=^_^=-o"
  echo
fi
exit 0
endef

define Build/Prepare
	$(call Build/Prepare/Default)
ifeq ($(QUILT),)
ifeq ($(CONFIG_BUILD_NLS),y)
	$(SED) 's/\[iconv\], \[c iconv\]/[libiconv], [iconv]/' \
		"$(PKG_BUILD_DIR)/configure.ac"
endif
endif
endef

$(eval $(call BuildPackage,asterisk-chan-dongle))
