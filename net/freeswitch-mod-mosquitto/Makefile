#
# Copyright (C) 2021 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=freeswitch-mod-mosquitto

PKG_RELEASE:=1
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

PKG_LICENSE:=MPL-1.1
PKG_LICENSE_FILES:=LICENSE

PKG_SOURCE_URL:=https://github.com/freeswitch/mod_mosquitto.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=b7b859a929cdac16e6387ccb2e252590ae0adf61
PKG_SOURCE_DATE:=2021-01-15
PKG_MIRROR_HASH:=6ff61693346a7044ab918b99c7f64f763f5765cf1657335e208275d8fb30a860

PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

FS_MOD_DIR:=/usr/lib/freeswitch/mod

include $(INCLUDE_DIR)/package.mk

define Package/freeswitch-mod-mosquitto
  TITLE:=mosquitto module
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=https://github.com/freeswitch/mod_mosquitto
  DEPENDS:=freeswitch +libmosquitto-ssl +libopenssl
endef

define Package/freeswitch-mod-mosquitto/description
mod_mosquitto is a FreeSWITCH interface to an MQTT broker.
endef

define Package/freeswitch-mod-mosquitto/install
	$(INSTALL_DIR) $(1)$(FS_MOD_DIR)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)$(FS_MOD_DIR)/mod_mosquitto.so \
							$(1)$(FS_MOD_DIR)
endef

$(eval $(call BuildPackage,freeswitch-mod-mosquitto))
