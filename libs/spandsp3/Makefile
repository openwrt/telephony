#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=spandsp3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/freeswitch/spandsp.git
PKG_SOURCE_DATE=2025-07-07
PKG_SOURCE_VERSION:=797760168945c96e91af55bde9d4edaea2e654f9
PKG_RELEASE:=1
PKG_MIRROR_HASH:=5e3a084b96dfe586d61170b7e87c92b3824d734c69efae518e0bf642843d8893

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_FIXUP:=autoreconf

PKG_LICENSE:=LGPL-2.1-or-later GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_BUILD_DEPENDS:=tiff/host

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

CONFIGURE_VARS += \
	CC_FOR_BUILD="$(HOSTCC)" \
	CPPFLAGS_FOR_BUILD="$(HOST_CPPFLAGS)"

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
