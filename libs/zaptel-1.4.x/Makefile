# 
# Copyright (C) 2006 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id: Makefile 5624 2006-11-23 00:29:07Z nbd $

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=zaptel
PKG_VERSION:=1.4.9.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ftp.digium.com/pub/zaptel/releases/
PKG_MD5SUM:=f6af404cc0244b93a2fc88b237f374bd

include $(INCLUDE_DIR)/package.mk

define Package/zaptel14/Default
  TITLE:=Zaptel
  URL:=http://ftp.digium.com/pub/zaptel/releases
endef

define KernelPackage/zaptel14
  SUBMENU:=Other modules
  $(call Package/zaptel14/Default)
  DEPENDS:=@!LINUX_2_6_27
  TITLE+= (kernel module)
  VERSION:=$(LINUX_VERSION)-$(PKG_VERSION)-$(BOARD)-$(PKG_RELEASE)
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

define Build/Compile/zaptel14-template
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		ARCH="$(LINUX_KARCH)" \
		LD="$(TARGET_CROSS)ld" \
		AR="$(TARGET_CROSS)ar" \
		HOSTCC="$(HOSTCC)" \
		DEB_HOST_GNU_TYPE="$(ARCH)" \
		KVERS="$(LINUX_VERSION)" \
		KSRC="$(LINUX_DIR)" \
		$(1)
endef

define Build/Compile/zaptel14
	$(call Build/Compile/zaptel14-template, \
		CC="$(KERNEL_CC)" \
		KFLAGS_PPC="-G 0 -mno-abicalls -fno-pic -pipe -finline-limit=100000 -mabi=32 $(TARGET_CFLAGS) -mlong-calls -fno-common -nostdinc -iwithprefix include" \
		TOPDIR_MODULES="zaptel ztdummy" \
		SUBDIR_MODULES="" \
		modules zttest \
	)
endef

define Build/Compile/zaptel14-libtonezone
	$(call Build/Compile/zaptel14-template, \
		CC="$(TARGET_CC)" \
		install-libs install-include \
	)
endef

define Build/Compile
	$(call Build/Compile/zaptel14)
	$(call Build/Compile/zaptel14-libtonezone)
endef

define Build/InstallDev
	$(INSTALL_DIR)  $(STAGING_DIR)/usr/include/zaptel/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/zaptel/zaptel.h $(STAGING_DIR)/usr/include/zaptel/
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/zaptel/tonezone.h $(STAGING_DIR)/usr/include/zaptel/
	$(INSTALL_DIR)  $(STAGING_DIR)/usr/lib/
	$(INSTALL_DATA)  $(PKG_INSTALL_DIR)/usr/lib/libtonezone* $(STAGING_DIR)/usr/lib/
endef

define Package/zaptel14-util/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/zttest $(1)/usr/bin/
endef

define Package/zaptel14-libtonezone/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/libtonezone.so.* $(1)/usr/lib/
endef

$(eval $(call KernelPackage,zaptel14))
$(eval $(call BuildPackage,zaptel14-util))
$(eval $(call BuildPackage,zaptel14-libtonezone))
