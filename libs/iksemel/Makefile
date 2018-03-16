#
# Copyright (C) 2014 - 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=iksemel
PKG_VERSION:=1.4
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/iksemel
PKG_HASH:=458c1b8fb3349076a6cecf26c29db1d561315d84e16bfcfba419f327f502e244

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

PKG_LICENSE:=LGPL-2.1
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

include $(INCLUDE_DIR)/package.mk

define Package/libiksemel
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Iksemel Jabber Library
  URL:=https://github.com/meduketto/iksemel
  DEPENDS:=+libgnutls
endef

define Package/libiksemel/description
Iksemel is an XML parser library mainly designed for Jabber applications.
It provides SAX, DOM, and special Jabber stream APIs. Library is coded
in ANSI C except the network code (which is POSIX compatible), thus
highly portable.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/iksemel.h $(1)/usr/include/
	
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libiksemel.{a,so*} $(1)/usr/lib/
	
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/iksemel.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libiksemel/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libiksemel.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libiksemel))
