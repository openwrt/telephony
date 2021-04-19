# 
# Copyright (C) 2006-2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bcg729
PKG_VERSION:=1.1.1
PKG_RELEASE:=1

PKG_SOURCE_URL_FILE:=$(PKG_VERSION).tar.gz
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_URL_FILE)
PKG_SOURCE_URL:=https://github.com/BelledonneCommunications/$(PKG_NAME)/archive
PKG_HASH:=68599a850535d1b182932b3f86558ac8a76d4b899a548183b062956c5fdc916d

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
CMAKE_INSTALL:=1

PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE.txt
PKG_MAINTAINER:=Alex Samorukov <samm@os2.kiev.ua>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/bcg729
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Software G729A encoder and decoder library written in C
  URL:=http://www.linphone.org/technical-corner/bcg729.html
endef

define Package/bcg729/description
 Bcg729 is a software G729A encoder and decoder library written in C, developed
 by Belledonne Communications, the company supporting the Linphone project.
 It was written from scratch and is NOT a derivative work of ITU reference
 source code in any kind.
endef

# Otherwise OpenWrt's CPPFLAGS are ignored
TARGET_CFLAGS += $(TARGET_CPPFLAGS)

CMAKE_OPTIONS += \
	-DCMAKE_VERBOSE_MAKEFILE=TRUE \
	-DENABLE_SHARED=YES \
	-DENABLE_STATIC=NO \
	-DENABLE_TESTS=NO

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/bcg729
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/bcg729/*.h \
		$(1)/usr/include/bcg729
	$(INSTALL_DIR) $(1)/usr/lib/{cmake/Bcg729,pkgconfig}
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libbcg729.so* $(1)/usr/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/lib$(PKG_NAME).pc \
		$(1)/usr/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/Bcg729/cmake/*.cmake \
		$(1)/usr/lib/cmake/Bcg729
endef

define Package/bcg729/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libbcg729.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,bcg729))
