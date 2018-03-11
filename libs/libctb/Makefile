#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libctb
PKG_VERSION:=0.16
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://iftools.com/download/ctb/$(PKG_VERSION)
PKG_HASH:=1cb0026a66cfbf8e26988f76cb861f1fbfd04f272f9b9adaf0d463d01282fc08

MAKE_PATH:=build

PKG_INSTALL:=1

PKG_LICENSE:=LGPL
PKG_LICENSE_FILES:=build/COPYING
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Communications toolbox - ctb
  URL:=https://iftools.com/opensource/ctb.en.php
  DEPENDS:=$(CXX_DEPENDS)
endef

define Package/$(PKG_NAME)/description
Multiplatform library for different interfaces.
endef

MAKE_FLAGS += \
	DEBUG=0 \
	GPIB=0 \
	prefix=/usr

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/ctb-$(PKG_VERSION)/linux
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/include/ctb-$(PKG_VERSION)/*.h \
		$(PKG_BUILD_DIR)/include/ctb-$(PKG_VERSION)/kbhit.h \
		$(1)/usr/include/ctb-$(PKG_VERSION)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/include/ctb-$(PKG_VERSION)/linux/*.h \
		$(1)/usr/include/ctb-$(PKG_VERSION)/linux
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/lib/$(PKG_NAME)-$(PKG_VERSION).so \
		$(1)/usr/lib
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/lib/$(PKG_NAME)-$(PKG_VERSION).so \
		$(1)/usr/lib
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
