#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gsmlib
PKG_VERSION:=1.10-20140304
PKG_RELEASE:=5

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/vbouchaud/gsmlib.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=cd5442de07cfe052316ede58640ef81b20627276
PKG_MIRROR_HASH:=bc24d7ddcb5f4b5f9160351d9f38cf6f35f3feef969f675f883b32d04c8c80fa

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

# Need Makefile.in.in from gettext-full/host and po.m4 from gettext-full
PKG_BUILD_DEPENDS:=gettext-full/host gettext-full

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

PKG_LICENSE:=LGPL-2.1+
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)/Default
  SUBMENU:=Telephony
  URL:=https://github.com/vbouchaud/gsmlib
endef

define Package/$(PKG_NAME)
$(call Package/$(PKG_NAME)/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=GSM mobile phone access lib
  DEPENDS:=+libstdcpp
endef

define Package/gsm-utils
$(call Package/$(PKG_NAME)/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=GSM mobile phone access apps
  DEPENDS:=+$(PKG_NAME)
endef

define Package/$(PKG_NAME)/description
A library to access GSM mobile phones via GSM modems.
endef

define Package/gsm-utils/description
Some simple command line programs to access GSM mobile phones via GSM modems.
endef

CONFIGURE_ARGS += --disable-nls

TARGET_CXXFLAGS += -std=c++11

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/$(PKG_NAME)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/include/$(PKG_NAME)/*.h \
		$(1)/usr/include/$(PKG_NAME)
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgsmme.so* $(1)/usr/lib
endef

define Build/Prepare
$(call Build/Prepare/Default)
	$(INSTALL_DATA) \
		$(STAGING_DIR_HOSTPKG)/share/gettext/po/Makefile.in.in \
		$(PKG_BUILD_DIR)/po
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgsmme.so* $(1)/usr/lib
endef

define Package/gsm-utils/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,gsm-utils))
