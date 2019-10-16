#
# Copyright (C) 2010-2017 OpenWrt.org
# Copyright (C) 2010 Alfred E. Heggestad
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rem
PKG_VERSION:=0.6.0
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.creytiv.com/pub
PKG_HASH:=417620da3986461598aef327c782db87ec3dd02c534701e68f4c255e54e5272c

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=docs/COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/librem
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libre
  TITLE:=Audio and video processing media library
  URL:=http://www.creytiv.com
endef

MAKE_FLAGS+= \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	EXTRA_LFLAGS="$(TARGET_LDFLAGS)" \
	LD="$(TARGET_CC)" \
	LIBRE_MK="$(STAGING_DIR)/usr/share/re/re.mk" \
	LIBRE_INC="$(STAGING_DIR)/usr/include/re" \
	LIBRE_SO="$(STAGING_DIR)/usr/lib" \
	OS=linux \
	RELEASE=1 \
	SYSROOT="$(shell $(FIND) $(TOOLCHAIN_DIR) -path '*/include/pthread.h' | sed -ne '1s|/include/pthread.h||p')" \
	SYSROOT_ALT="$(STAGING_DIR)/usr"

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/rem $(1)/usr/include
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/librem.{a,so} $(1)/usr/lib
endef

define Package/librem/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/librem.so $(1)/usr/lib
endef

$(eval $(call BuildPackage,librem))
