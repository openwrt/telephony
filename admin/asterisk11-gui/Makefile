#
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk11-gui
PKG_VERSION:=2.1.0-rc1
PKG_RELEASE:=4

PKG_SOURCE_URL:=http://downloads.asterisk.org/pub/telephony/asterisk-gui/releases/
PKG_SOURCE:=asterisk-gui-$(PKG_VERSION).tar.gz
PKG_MD5SUM:=055bf2aaba365e696198925d039ac3cb
PKG_BUILD_DIR:=$(BUILD_DIR)/asterisk11-gui-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/asterisk11-gui
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=Asterisk GUI for Asterisk 11.x
  DEPENDS:=+@PACKAGE_asterisk11 +asterisk11-app-exec +asterisk11-app-system
  VERSION:=$(PKG_VERSION)
endef

define Package/asterisk11-gui/description
 Asterisk11 GUI is a framework for the creation of graphical interfaces 
 for configuring Asterisk-11.x package.
endef

EXTRA_CFLAGS:=$(TARGET_CPPFLAGS)
EXTRA_LDFLAGS:=$(TARGET_LDFLAGS)

define Build/Prepare
	rm -rf $(PKG_BUILD_DIR)/
	mkdir -p $(PKG_BUILD_DIR)/
	$(TAR) -xzf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR) --strip 1
	$(Build/Patch)
endef

define Build/Configure
	( cd $(PKG_BUILD_DIR); ./bootstrap.sh )
	$(call Build/Configure/Default, \
			--build=$(GNU_HOST_NAME) \
			--host=$(GNU_TARGET_NAME) \
			--target=$(GNU_TARGET_NAME) \
			--prefix=/usr \
			--disable-nls \
			--disable-static \
			--localstatedir="/usr" \
			--sysconfdir="/etc" \
		)
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$(PKG_INSTALL_DIR)"
	$(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$(PKG_INSTALL_DIR)" install
endef

define Package/asterisk11-gui/install
	$(INSTALL_DIR) $(1)/etc/asterisk/
	$(CP) ./files/gui_* $(1)/etc/asterisk/
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/static-http
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/asterisk/static-http/* $(1)/usr/lib/asterisk/static-http
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/scripts
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/asterisk/scripts/* $(1)/usr/lib/asterisk/scripts
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/gui_backups
endef

$(eval $(call BuildPackage,asterisk11-gui))
