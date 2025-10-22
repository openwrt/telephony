# 
# Copyright (C) 2014 - 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=dahdi-linux
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/asterisk/dahdi-linux.git
PKG_SOURCE_DATE=2024-04-12
PKG_SOURCE_VERSION:=83d89b64d9151dbe4eb53b9ebc8640a08fcf4d63
PKG_MIRROR_HASH:=67acfb62213270050d941643cb763c315cc6a2682a94fc517975707918e42ecb

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Vittorio Gambaletta <openwrt@vittgam.net>

# With below variable set, $(PKG_SYMVERS_DIR)/dahdi-linux.symvers gets
# generated from drivers/dahdi/Module.symvers.
PKG_EXTMOD_SUBDIRS:=drivers/dahdi

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
  DEPENDS:=kmod-dahdi +kmod-echo
  URL:=http://www.asterisk.org/
  FILES:=$(PKG_BUILD_DIR)/drivers/dahdi/dahdi_echocan_oslec.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoProbe,dahdi_echocan_oslec)
endef

define KernelPackage/dahdi-echocan-oslec/description
  This package contains DAHDI OSLEC echo canceller support.
endef

define KernelPackage/dahdi-hfcs
  SUBMENU:=Voice over IP
  TITLE:=DAHDI driver for HFC-S PCI
  DEPENDS:=@PCI_SUPPORT kmod-dahdi
  URL:=http://sourceforge.net/projects/dahdi-hfcs/
  FILES:= $(PKG_BUILD_DIR)/drivers/dahdi/hfcs/dahdi_hfcs.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoProbe,dahdi_hfcs)
endef

define KernelPackage/dahdi-hfcs/description
  This package contains DAHDI driver for HFC-S based PCI BRI adapters.
endef

define KernelPackage/dahdi-dummy
  SUBMENU:=Voice over IP
  TITLE:=dummy DAHDI driver
  DEPENDS:=kmod-dahdi
  URL:=http://www.asterisk.org/
  FILES:= $(PKG_BUILD_DIR)/drivers/dahdi/dahdi_dummy.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoProbe,dahdi_dummy)
endef

define KernelPackage/dahdi-dummy/description
  This package contains the dummy DAHDI driver providing only DAHDI timing
  without any real telephony hardware.
endef


define Build/Configure
endef

define Build/Prepare
	$(Build/Prepare/Default)
	mkdir -p $(PKG_BUILD_DIR)/drivers/staging/echo/
	$(CP) ./files/oslec.h $(PKG_BUILD_DIR)/drivers/staging/echo/
endef

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
		$(KERNEL_MAKE_FLAGS) \
		KSRC="$(LINUX_DIR)"
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
$(eval $(call KernelPackage,dahdi-dummy))
$(eval $(call KernelPackage,dahdi-hfcs))
