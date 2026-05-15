#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=oslec
PKG_VERSION:=0.3.0
PKG_RELEASE:=1

PKG_LICENSE:=GPL-2.0-only
PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>

include $(INCLUDE_DIR)/package.mk

define KernelPackage/oslec
  SUBMENU:=Voice over IP
  TITLE:=Open Source Line Echo Canceller
  DEPENDS:=@!LINUX_6_12
  URL:=https://www.rowetel.com/ucasterisk/oslec.html
  FILES:=$(PKG_BUILD_DIR)/echo.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,50,echo)
endef

define KernelPackage/oslec/description
 OSLEC is an open source line echo canceller, formerly available in the
 Linux kernel as drivers/misc/echo. It implements a G.168 compliant echo
 canceller used by DAHDI (dahdi_echocan_oslec) and mISDN.
endef

define Build/Compile
	$(KERNEL_MAKE) M="$(PKG_BUILD_DIR)" modules
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/oslec
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/oslec.h $(1)/usr/include/oslec/
endef

$(eval $(call KernelPackage,oslec))
