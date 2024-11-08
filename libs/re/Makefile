#
# Copyright (C) 2010-2017 OpenWrt.org
# Copyright (C) 2010 Alfred E. Heggestad
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=re
PKG_VERSION:=3.16.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/baresip/re/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=11b3215064b6ef5a11b0f4645d6d4834f8ba899d5b65c66477f9c4afbd32e1ed

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=docs/COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libre
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libopenssl +zlib
  TITLE:=Generic library for real-time communications with async IO support
  URL:=https://github.com/baresip/re
  ABI_VERSION:=2
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr
	$(CP) $(PKG_INSTALL_DIR)/usr/* $(1)/usr
endef

define Package/libre/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libre.so.* $(1)/usr/lib
endef

$(eval $(call BuildPackage,libre))
