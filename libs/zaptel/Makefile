# 
# Copyright (C) 2006 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id$

include $(TOPDIR)/rules.mk

PKG_NAME:=zaptel
PKG_VERSION:=1.2.12
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ftp.digium.com/pub/zaptel/releases/ ftp://ftp.digium.com/pub/zaptel/releases/
PKG_MD5SUM:=99b9f86556b903a32607b2751f920513

include $(INCLUDE_DIR)/package.mk

define Package/zaptel/Default
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=http://ftp.digium.com/pub/zaptel/releases
endef

define Package/zaptel-libtonezone
  $(call Package/zaptel/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Zaptel tonezone library.
endef

define Build/Configure
endef

TARGET_CFLAGS += $(FPIC)

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
                HOSTCC="$(HOSTCC)" \
		CFLAGS="$(TARGET_CFLAGS) -I. -DBUILDING_TONEZONE" \
		KSRC="$(LINUX_DIR)" \
		DESTDIR="$(PKG_INSTALL_DIR)" \
                install-tonezone
endef

define Build/InstallDev
	mkdir -p $(1)/usr/include/linux
	$(CP) $(PKG_INSTALL_DIR)/usr/include/linux/zaptel.h $(1)/usr/include/linux/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/tonezone.h $(1)/usr/include/
	mkdir -p $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libtonezone.so* $(1)/usr/lib/
endef

define Package/zaptel-libtonezone/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libtonezone.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,zaptel-libtonezone))
