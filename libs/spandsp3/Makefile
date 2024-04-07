#
# Copyright (C) 2020 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=spandsp3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/freeswitch/spandsp.git
PKG_SOURCE_DATE=2023-06-16
PKG_SOURCE_VERSION:=0d2e6ac65e0e8f53d652665a743015a88bf048d4
PKG_RELEASE:=1
PKG_MIRROR_HASH:=4b380960934ca4feda6d615ae8e7bb3245d87276f04d86e12c2f5939aa36608e

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf

PKG_LICENSE:=LGPL-2.1-or-later GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:= \
	Jiri Slachta <jiri@slachta.eu> \
	Sebastian Kemper <sebastian_ml@gmx.net>

include $(INCLUDE_DIR)/package.mk

define Package/libspandsp3
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=spandsp3 library
  DEPENDS:=+libjpeg-turbo +libtiff
  URL:=https://github.com/freeswitch/spandsp
  ABI_VERSION:=3
endef

# Use fixed point math when soft float support is enabled for target devices.
ifeq ($(CONFIG_SOFT_FLOAT),y)
CONFIGURE_ARGS+= \
	--enable-fixed-point
endif

define Build/InstallDev
	$(INSTALL_DIR) \
		$(1)/usr/lib/spandsp3/{include/spandsp/private,lib}

	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libspandsp* \
		$(1)/usr/lib/spandsp3/lib

	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/spandsp.h \
		$(1)/usr/lib/spandsp3/include

	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/spandsp/*.h \
		$(1)/usr/lib/spandsp3/include/spandsp

	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/spandsp/private/*.h \
		$(1)/usr/lib/spandsp3/include/spandsp/private

	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/spandsp.pc \
		$(1)/usr/lib/pkgconfig/spandsp3.pc
endef

define Package/libspandsp3/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libspandsp.so.$(ABI_VERSION)* \
		$(1)/usr/lib
endef

$(eval $(call BuildPackage,libspandsp3))
