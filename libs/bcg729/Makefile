# 
# Copyright (C) 2006-2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bcg729
PKG_VERSION:=1.0.4
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.linphone.org/releases/sources/bcg729
PKG_HASH:=1a0fbf1ff91470037e83fa67976f940ebb601e4cc525859c754f4e7ffc24c307

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
CMAKE_INSTALL:=1

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=COPYING
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
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/bcg729/*.h $(1)/usr/include/bcg729
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libbcg729.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/cmake/Bcg729
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/Bcg729/cmake/*.cmake $(1)/usr/lib/cmake/Bcg729
endef

define Package/bcg729/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libbcg729.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,bcg729))
