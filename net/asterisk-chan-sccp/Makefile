#
# Copyright (C) 2016 OpenWrt.org
# Copyright (C) 2016 Cesnet, z.s.p.o.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk-chan-sccp
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/chan-sccp/chan-sccp.git
PKG_SOURCE_VERSION:=a61c6d2cecdd149db767307cd71b736e77913251
PKG_SOURCE_DATE:=2020-10-26
PKG_MIRROR_HASH:=b879a44b855c5a891558781967abff0cb9350d8765c1b4f7774a4fae4cfeda4c
PKG_SOURCE_PROTO:=git

PKG_FIXUP:=autoreconf

PKG_LICENSE:=GPL-1.0
PKG_LICENSE_FILES:=COPYING LICENSE
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
# chan-sccp needs iconv
include $(INCLUDE_DIR)/nls.mk

define Package/asterisk-chan-sccp
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=SCCP channel support
  URL:=https://github.com/chan-sccp/chan-sccp
  DEPENDS:=asterisk $(ICONV_DEPENDS) +libltdl \
	  +asterisk-bridge-holding \
	  +asterisk-bridge-native-rtp \
	  +asterisk-bridge-simple \
	  +asterisk-bridge-softmix \
	  +asterisk-res-stasis-device-state
  CONFLICTS:=asterisk-chan-skinny
endef

define Package/asterisk-chan-sccp/description
Replacement for the SCCP channel driver (chan_skinny) in Asterisk.
Extended features include shared lines, presence / BLF, customizable
feature buttons and custom device state.
endef

CONFIGURE_ARGS += \
	--disable-debug \
	--enable-advanced-functions \
	--enable-conference \
	--enable-video \
	--with-asterisk=$(STAGING_DIR)/usr

define Package/asterisk-chan-sccp/conffiles
/etc/asterisk/sccp.conf
endef

define Package/asterisk-chan-sccp/install
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/asterisk/sccp.conf $(1)/etc/asterisk
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/asterisk/modules/chan_sccp.so $(1)/usr/lib/asterisk/modules/
endef

$(eval $(call BuildPackage,asterisk-chan-sccp))
