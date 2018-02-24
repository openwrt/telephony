#
# Copyright (C) 2006-2018 OpenWrt.org
# Copyright (C) 2011 Victor Seva <linuxmaniac@torreviejawireless.org>
# Copyright (C) 2017 - 2018 Jiri Slachta <jiri@slachta.eu>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libsrtp
PKG_VERSION:=1.6.0
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/cisco/libsrtp.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=2b091a4fb21c9b06fc5d4b5763bdaec97542fcd7
PKG_MIRROR_HASH:=7ac6c3113fd7a966c9a9108c185d9425e75a8fdc600e4ccef158e68ee1988c89
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS += \
	--disable-stdout \
	--enable-syslog

define Package/libsrtp
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Secure Real-time Transport Protocol (SRTP) library
  DEPENDS:=+libpcap
  URL:=http://sourceforge.net/projects/srtp
endef

define Package/libsrtp/description
 Open-source implementation of the Secure Real-time Transport
 Protocol (SRTP) originally authored by Cisco Systems, Inc.
 It is available under a BSD-style license.
endef

define Build/Install
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR=$(PKG_INSTALL_DIR) uninstall
	$(call Build/Install/Default)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/srtp $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsrtp.{a,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libsrtp.pc $(1)/usr/lib/pkgconfig/
endef


define Package/libsrtp/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libsrtp.so* \
		$(1)/usr/lib/
endef

$(eval $(call BuildPackage,libsrtp))
