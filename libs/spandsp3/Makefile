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
PKG_SOURCE_DATE=2020-08-14
PKG_SOURCE_VERSION:=6ec23e5a7e411a22d59e5678d12c4d2942c4a4b6
PKG_RELEASE:=2
PKG_MIRROR_HASH:=fcfa13576a25ff27e3746c3db30de89d2afceb963072b352a34e7a4a9f492ae5

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
  DEPENDS:=+libjpeg +libtiff
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
