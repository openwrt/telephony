# 
# Copyright (C) 2019 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libks

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/signalwire/$(PKG_NAME).git
PKG_SOURCE_DATE=2019-09-18
PKG_SOURCE_VERSION:=df72c4c61a2deed414541735086d03259aec9679
PKG_RELEASE:=1
PKG_MIRROR_HASH:=3005101d3c80ec7d03d2097e538506a5090ded65b71169c279194ab950fd7cb5

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
