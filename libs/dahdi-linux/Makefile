# 
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=dahdi-linux
PKG_VERSION:=2.10.0.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://downloads.asterisk.org/pub/telephony/dahdi-linux/releases/
PKG_MD5SUM:=a23e91cc474f241616a5a038ae2b1e72

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Vittorio Gambaletta <openwrt@vittgam.net>

DAHDI_MODULES_EXTRA:=

include $(INCLUDE_DIR)/package.mk

define KernelPackage/dahdi
  SUBMENU:=Voice over IP
  TITLE:=DAHDI basic infrastructure
  DEPENDS:=@USB_SUPPORT +kmod-lib-crc-ccitt
  URL:=http://www.asterisk.org/
  FILES:= $(PKG_BUILD_DIR)/drivers/dahdi/dahdi.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoProbe,dahdi)
endef

define KernelPackage/dahdi/description
  This package contains DAHDI basic infrastructure.
endef

define KernelPackage/dahdi-echocan-oslec
  SUBMENU:=Voice over IP
  TITLE:=DAHDI OSLEC echo canceller support
  DEPENDS:=kmod-dahdi
  URL:=http://www.asterisk.org/
  FILES:= $(PKG_BUILD_DIR)/drivers/staging/echo/echo.$(LINUX_KMOD_SUFFIX) \
          $(PKG_BUILD_DIR)/drivers/dahdi/dahdi_echocan_oslec.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoProbe,echo dahdi_echocan_oslec)
endef

define KernelPackage/dahdi-echocan-oslec/description
  This package contains DAHDI OSLEC echo canceller support.
endef

define Build/Configure
endef

TARGET_CFLAGS += $(FPIC)

define Build/Prepare
	$(Build/Prepare/Default)
	mkdir -p $(PKG_BUILD_DIR)/drivers/staging/echo/
	$(CP) $(PKG_BUILD_DIR)/../linux-$(LINUX_VERSION)/drivers/misc/echo/* $(PKG_BUILD_DIR)/drivers/staging/echo/ || $(CP) $(PKG_BUILD_DIR)/../linux-$(LINUX_VERSION)/drivers/staging/echo/* $(PKG_BUILD_DIR)/drivers/staging/echo/
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		ARCH="$(LINUX_KARCH)" \
		$(TARGET_CONFIGURE_OPTS) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		KERNELVERSION="$(KERNEL)" \
		KERNEL_VERSION="$(LINUX_VERSION)" \
		KERNELDIR="$(LINUX_DIR)" \
		KSRC:="$(LINUX_DIR)" \
		KVERS:="$(LINUX_VERSION)" \
		TOPDIR:="$(TOPDIR)" \
		INCLUDE_DIR:="$(INCLUDE_DIR)" \
		PWD:="$(PKG_BUILD_DIR)" \
		MODULES_EXTRA:="$(DAHDI_MODULES_EXTRA)"
endef

define Build/InstallDev
	mkdir -p $(1)/usr/include/dahdi
	$(CP) $(PKG_BUILD_DIR)/include/dahdi/dahdi_config.h $(1)/usr/include/dahdi/
	$(CP) $(PKG_BUILD_DIR)/include/dahdi/fasthdlc.h     $(1)/usr/include/dahdi/
	$(CP) $(PKG_BUILD_DIR)/include/dahdi/kernel.h       $(1)/usr/include/dahdi/
	$(CP) $(PKG_BUILD_DIR)/include/dahdi/user.h         $(1)/usr/include/dahdi/
	$(CP) $(PKG_BUILD_DIR)/include/dahdi/wctdm_user.h   $(1)/usr/include/dahdi/
endef

$(eval $(call KernelPackage,dahdi))
$(eval $(call KernelPackage,dahdi-echocan-oslec))
