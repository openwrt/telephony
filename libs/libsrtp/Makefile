#
# Copyright (C) 2017 OpenWrt.org
# Copyright (C) 2017 Jiri Slachta <jiri@slachta.eu>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libsrtp
PKG_VERSION:=2.6.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/cisco/libsrtp
PKG_MIRROR_HASH:=7ee6ba7138e7e3c4b16dbb6aa1cd639dcca517f2aa3f7dafb2cf245d932e8448

PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS+=--enable-openssl

define Package/libsrtp2
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Secure RTP (SRTP) library, v$(PKG_VERSION)
  URL:=https://github.com/cisco/libsrtp
  DEPENDS:=+libopenssl
  ABI_VERSION:=1
endef

define Package/libsrtp2/description
Open-source implementation of the Secure Real-time Transport
Protocol (SRTP) originally authored by Cisco Systems, Inc.
It is available under a BSD-style license.
endef

define Build/Install
	$(call Build/Install/Default,all shared_library install)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/srtp2 $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsrtp2.{a,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libsrtp2.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libsrtp2/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libsrtp2.so.$(ABI_VERSION)* \
		$(1)/usr/lib/
endef

$(eval $(call BuildPackage,libsrtp2))
