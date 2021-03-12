# 
# Copyright (C) 2019 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libks

PKG_VERSION:=1.7.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/signalwire/libks/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=73c5751eadad4d3390d61b9765e9b860e0aba7336044ecf8b007dfc1818baa69

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

define Package/$(PKG_NAME)
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Foundational support for SignalWire C products
  URL:=https://github.com/signalwire/libks
  ABI_VERSION:=1
  DEPENDS:=+libatomic +libopenssl +libuuid
endef

# Otherwise OpenWrt's CPPFLAGS are ignored
TARGET_CFLAGS += $(TARGET_CPPFLAGS)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/$(PKG_NAME)
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/$(PKG_NAME)/*.h \
		$(1)/usr/include/$(PKG_NAME)
	$(INSTALL_DIR) $(1)/usr/lib/{cmake/$(PKG_NAME),pkgconfig}
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/$(PKG_NAME)/cmake/* \
		$(1)/usr/lib/cmake/$(PKG_NAME)
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(PKG_NAME).so* $(1)/usr/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/$(PKG_NAME).pc \
		$(1)/usr/lib/pkgconfig
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(PKG_NAME).so.$(ABI_VERSION)* $(1)/usr/lib
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
