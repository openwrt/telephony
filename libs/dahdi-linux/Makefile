# 
# Copyright (C) 2014 - 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=dahdi-linux
PKG_VERSION:=2.11.1-20180111
PKG_RELEASE:=2

#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=https://downloads.asterisk.org/pub/telephony/dahdi-linux/releases
#PKG_HASH:=f59f382365118205e77d2874f1c0e1546e936247bcc45f07a43bc21778bee9df

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/asterisk/dahdi-linux.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=26597a5cac2930c191ae540c03c7406745c03e36
PKG_MIRROR_HASH:=0eaad3c3ed63efa61e6b807bd70e9b5287271f5dd63af9f41c026a5f979b81d3

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
	$(MAKE) -C $(PKG_BUILD_DIR) \
		ARCH="$(LINUX_KARCH)" \
		$(TARGET_CONFIGURE_OPTS) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		KSRC="$(LINUX_DIR)" \
		MODULES_EXTRA="$(DAHDI_MODULES_EXTRA)"
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
