#
# Copyright (C) 2016 OpenWrt.org
# Copyright (C) 2016 Cesnet, z.s.p.o.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=chan-sccp
PKG_VERSION:=v4.3.2-20190411
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/chan-sccp/chan-sccp.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=da59f2f073502645b34b458392a1fb11465f48cc
PKG_MIRROR_HASH:=a449c3384b92ff79b2db4d6b4e8dc7a3fb668f4c0f1a65baa198578b0b953ab8
PKG_SOURCE_PROTO:=git

PKG_FIXUP:=autoreconf

PKG_LICENSE:=GPL-1.0
PKG_LICENSE_FILES:=COPYING LICENSE
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_INSTALL:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
# chan-sccp needs iconv
include $(INCLUDE_DIR)/nls.mk

define Package/chan-sccp/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=SCCP channel support
  URL:=https://github.com/chan-sccp/chan-sccp
  DEPENDS:=$(ICONV_DEPENDS) +libltdl
endef

define Package/asterisk16-chan-sccp
$(call Package/chan-sccp/Default)
  DEPENDS += asterisk16 \
	  +asterisk16-bridge-holding \
	  +asterisk16-bridge-native-rtp \
	  +asterisk16-bridge-simple \
	  +asterisk16-bridge-softmix \
	  +asterisk16-res-stasis-device-state \
	  +asterisk16-voicemail
  VARIANT:=asterisk16
  CONFLICTS:=asterisk16-chan-skinny
endef

define Package/description/Default
Replacement for the SCCP channel driver (chan_skinny) in Asterisk.
Extended features include shared lines, presence / BLF, customizable
feature buttons and custom device state.
endef

Package/asterisk16-chan-sccp/description = $(Package/description/Default)

CONFIGURE_ARGS += \
	--disable-debug \
	--enable-advanced-functions \
	--enable-conference \
	--enable-video

ifeq ($(BUILD_VARIANT),asterisk16)
  CONFIGURE_ARGS += --with-asterisk=$(STAGING_DIR)/usr/include/asterisk-16
endif

define Package/conffiles/Default
/etc/asterisk/sccp.conf
endef

Package/asterisk16-chan-sccp/conffiles = $(Package/conffiles/Default)

define Package/Install/Default
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/asterisk/sccp.conf $(1)/etc/asterisk
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/asterisk/modules/chan_sccp.so $(1)/usr/lib/asterisk/modules/
endef

Package/asterisk16-chan-sccp/install = $(Package/Install/Default)

$(eval $(call BuildPackage,asterisk16-chan-sccp))
