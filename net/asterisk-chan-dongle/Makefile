#
# Copyright (C) 2017 - 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk-chan-dongle
PKG_VERSION:=1.1-20180312
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/wdoekes/asterisk-chan-dongle.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=3e2b3ca6fd4d0a996404dfdc724973e92f2683eb
PKG_MIRROR_HASH:=655d1b6a78fb92f5a41410747d2ad633493e5eb2c5a2a0fdf8057dde4011213e
PKG_SOURCE_PROTO:=git

PKG_FIXUP:=autoreconf

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYRIGHT.txt LICENSE.txt
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

MODULES_DIR:=/usr/lib/asterisk/modules

include $(INCLUDE_DIR)/package.mk

define Package/asterisk-chan-dongle/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=https://github.com/wdoekes/asterisk-chan-dongle
  DEPENDS:=+USE_UCLIBC:libiconv-full +kmod-usb-acm +kmod-usb-serial +kmod-usb-serial-option +libusb-1.0 +usb-modeswitch
  TITLE:=Huawei UMTS 3G dongle support
endef

define Package/asterisk13-chan-dongle
$(call Package/asterisk-chan-dongle/Default)
  DEPENDS+=asterisk13
  VARIANT:=asterisk13
endef

define Package/asterisk15-chan-dongle
$(call Package/asterisk-chan-dongle/Default)
  DEPENDS+=asterisk15
  VARIANT:=asterisk15
endef

define Package/description/Default
 Asterisk channel driver for Huawei UMTS 3G dongle.
endef

Package/asterisk13-chan-dongle/description = $(Package/description/Default)
Package/asterisk15-chan-dongle/description = $(Package/description/Default)

ifeq ($(BUILD_VARIANT),asterisk13)
  CHAN_DONGLE_AST_HEADERS:=$(STAGING_DIR)/usr/include/asterisk-13/include
  CONFIGURE_ARGS+= \
	  --with-astversion=13
endif

ifeq ($(BUILD_VARIANT),asterisk15)
  CHAN_DONGLE_AST_HEADERS:=$(STAGING_DIR)/usr/include/asterisk-15/include
  CONFIGURE_ARGS+= \
	  --with-astversion=15
endif

CONFIGURE_ARGS+= \
	--with-asterisk=$(CHAN_DONGLE_AST_HEADERS)

TARGET_CFLAGS+= \
	-I$(CHAN_DONGLE_AST_HEADERS)

MAKE_FLAGS+=LD="$(TARGET_CC)"

# musl and glibc include their own iconv, but uclibc does not
TARGET_CPPFLAGS+=$(if $(CONFIG_USE_UCLIBC),-I$(STAGING_DIR)/usr/lib/libiconv-full/include)
TARGET_LDFLAGS+=$(if $(CONFIG_USE_UCLIBC),-L$(STAGING_DIR)/usr/lib/libiconv-full/lib -liconv)

# $CHAN_DONGLE_ICONV_INC used by 200-fix-iconv-detection.patch
CONFIGURE_VARS += \
	CHAN_DONGLE_ICONV_INC="$(TOOLCHAIN_DIR)/include $(STAGING_DIR)/usr/lib/libiconv-full/include" \
	DESTDIR="$(MODULES_DIR)" \
	ac_cv_type_size_t=yes \
	ac_cv_type_ssize_t=yes

define Package/conffiles/Default
/etc/asterisk/dongle.conf
endef

Package/asterisk13-chan-dongle/conffiles = $(Package/conffiles/Default)
Package/asterisk15-chan-dongle/conffiles = $(Package/conffiles/Default)

define Package/Install/Default
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/dongle.conf $(1)/etc/asterisk
	$(INSTALL_DIR) $(1)$(MODULES_DIR)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/chan_dongle.so $(1)$(MODULES_DIR)
endef

Package/asterisk13-chan-dongle/install = $(Package/Install/Default)
Package/asterisk15-chan-dongle/install = $(Package/Install/Default)

$(eval $(call BuildPackage,asterisk13-chan-dongle))
$(eval $(call BuildPackage,asterisk15-chan-dongle))
