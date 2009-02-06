# 
# Copyright (C) 2006-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id$

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=zaptel
PKG_VERSION:=1.4.9.2
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ftp.digium.com/pub/zaptel/releases/
PKG_MD5SUM:=f6af404cc0244b93a2fc88b237f374bd

include $(INCLUDE_DIR)/package.mk

define Package/zaptel14/Default
  TITLE:=Zaptel
  URL:=http://ftp.digium.com/pub/zaptel/releases
endef

define KernelPackage/zaptel14
  $(call Package/zaptel14/Default)
  SUBMENU:=Other modules
  TITLE+= (kernel module)
  FILES:=$(PKG_BUILD_DIR)/kernel/zaptel.$(LINUX_KMOD_SUFFIX) \
  	$(PKG_BUILD_DIR)/kernel/ztdummy.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,70,zaptel ztdummy)
endef

define KernelPackage/zaptel14/description
 This package contains the Zaptel core module and ztdummy driver.
endef

define Package/zaptel14-util
  $(call Package/zaptel14/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE+= utils
  DEPENDS += +kmod-zaptel14
endef

define Package/zaptel14-util/description
 This package contains the zttest program
endef

define Package/zaptel14-libtonezone
  $(call Package/zaptel14/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE+= libtonezone (library)
  DEPENDS += +kmod-zaptel14
endef

define Package/zaptel14-libtonezone/description
 This package contains the libraries for accessing zaptel/dummy drivers.
endef

MAKE_FLAGS:= \
	ARCH="$(LINUX_KARCH)" \
	CC="$(TARGET_CC) $(TARGET_CFLAGS)" \
	LD="$(TARGET_CROSS)ld" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	KVERS="$(LINUX_VERSION)" \
	KSRC="$(LINUX_DIR)" \
	TOPDIR_MODULES="zaptel ztdummy" \
	SUBDIR_MODULES=""

define Build/Compile/kmod
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(MAKE_FLAGS) \
		modules
endef

define Build/Compile/user
	$(MAKE) -C $(PKG_BUILD_DIR) \
	        ARCH="$(LINUX_KARCH)" \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		install-libs install-include zttest
endef

define Build/Compile
	$(call Build/Compile/kmod)
	$(call Build/Compile/user)
endef

define Build/InstallDev
	$(INSTALL_DIR)  $(STAGING_DIR)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/zaptel $(STAGING_DIR)/usr/include/
	$(INSTALL_DIR)  $(STAGING_DIR)/usr/lib
	$(CP)  $(PKG_INSTALL_DIR)/usr/lib/libtonezone.* $(STAGING_DIR)/usr/lib/
endef

define Package/zaptel14-util/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/zttest $(1)/usr/bin/
endef

define Package/zaptel14-libtonezone/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libtonezone.so.* $(1)/usr/lib/
endef

$(eval $(call KernelPackage,zaptel14))
$(eval $(call BuildPackage,zaptel14-util))
$(eval $(call BuildPackage,zaptel14-libtonezone))
