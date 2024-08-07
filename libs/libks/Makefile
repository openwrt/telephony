# 
# Copyright (C) 2019 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libks

PKG_VERSION:=2.0.6
PKG_RELEASE:=1

PKG_SOURCE:=libks-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/signalwire/libks/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=0b78d07d7a4ebf6c58d898bde2873bc40941ed29ca237a3c9939860de4a0ba25

PKG_BUILD_PARALLEL:=1
CMAKE_INSTALL:=1

PKG_LICENSE:= \
	BSD-1-Clause \
	BSD-3-Clause \
	ISC \
	MIT \
	PUBLICDOMAIN \
	twofish
PKG_LICENSE_FILES:=copyright

PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libks
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Foundational support for SignalWire C products
  URL:=https://github.com/signalwire/libks
  ABI_VERSION:=2
  DEPENDS:=+libatomic +libopenssl +libuuid
endef

# Otherwise OpenWrt's CPPFLAGS are ignored
TARGET_CFLAGS += $(TARGET_CPPFLAGS)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/libks2/libks/cmake
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/libks2/libks/*.h \
		$(1)/usr/include/libks2/libks
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/libks2/libks/cmake/* \
		$(1)/usr/include/libks2/libks/cmake
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libks2.so* $(1)/usr/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libks2.pc \
		$(1)/usr/lib/pkgconfig
endef

define Package/libks/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libks2.so.$(ABI_VERSION)* $(1)/usr/lib
endef

$(eval $(call BuildPackage,libks))
