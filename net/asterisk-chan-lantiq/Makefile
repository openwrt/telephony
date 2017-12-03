#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=chan-lantiq
PKG_VERSION:=20171128
PKG_RELEASE:=1

LANTIQ_AST13_VERSION:=5adf3d7774a75c88835f2f3daf824e2cda2c6e67
LANTIQ_AST15_VERSION:=2eb991b66d135e6f22da30a2827918aed2d7b328

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Download/github
define Download/$(PKG_NAME)
  VERSION:=$(1)
  SUBDIR:=$(PKG_NAME)
  FILE:=$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)-$(1).tar.xz
  URL:=https://github.com/kochstefan/asterisk_channel_lantiq.git
  PROTO:=git
endef
$$(eval $$(call Download,chan-lantiq))
endef

define Package/$(PKG_NAME)/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Lantiq channel driver
  URL:=https://github.com/kochstefan/asterisk_channel_lantiq
  DEPENDS:=kmod-ltq-vmmc
endef

define Package/asterisk13-$(PKG_NAME)
$(call Package/$(PKG_NAME)/Default)
  DEPENDS+=asterisk13
  VARIANT:=asterisk13
endef

define Package/asterisk15-$(PKG_NAME)
$(call Package/$(PKG_NAME)/Default)
  DEPENDS+=asterisk15
  VARIANT:=asterisk15
endef

define Package/description/Default
An implementation of a Lantiq TAPI channel driver for Asterisk.
endef

Package/asterisk13-$(PKG_NAME)/description = $(Package/description/Default)
Package/asterisk15-$(PKG_NAME)/description = $(Package/description/Default)

define Package/conffiles/Default
/etc/asterisk/lantiq.conf
endef

Package/asterisk13-$(PKG_NAME)/conffiles = $(Package/conffiles/Default)
Package/asterisk15-$(PKG_NAME)/conffiles = $(Package/conffiles/Default)

define Package/Install/Default
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/$(PKG_NAME)/src/configs/samples/lantiq.conf.sample \
		$(1)/etc/asterisk/lantiq.conf
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/$(PKG_NAME)/src/channels/chan_lantiq.so \
		$(1)/usr/lib/asterisk/modules
endef

Package/asterisk13-$(PKG_NAME)/install = $(Package/Install/Default)
Package/asterisk15-$(PKG_NAME)/install = $(Package/Install/Default)

ifeq ($(BUILD_VARIANT),asterisk13)
CHAN_LANTIQ_AST_INCLUDES:=-I$(STAGING_DIR)/usr/include/asterisk-13/include
CHAN_LANTIQ_VERSION:=$(LANTIQ_AST13_VERSION)
endif

ifeq ($(BUILD_VARIANT),asterisk15)
CHAN_LANTIQ_AST_INCLUDES:=-I$(STAGING_DIR)/usr/include/asterisk-15/include
CHAN_LANTIQ_VERSION:=$(LANTIQ_AST15_VERSION)
endif

define Build/Prepare
	$(eval $(call Download/github,$(CHAN_LANTIQ_VERSION)))
	$(TAR) --extract --no-same-owner --no-same-permissions --xz \
		--file=$(DL_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)-$(CHAN_LANTIQ_VERSION).tar.xz \
		--directory=$(PKG_BUILD_DIR)
	$(CP) ./files/default.exports \
		$(PKG_BUILD_DIR)/$(PKG_NAME)/src/channels/chan_lantiq.exports
endef

define Build/Configure
endef

define Build/Compile
	cd $(PKG_BUILD_DIR)/$(PKG_NAME)/src/channels && \
	$(TARGET_CC) -o chan_lantiq.o -c chan_lantiq.c -MD -MT chan_lantiq.o \
		-MF .chan_lantiq.o.d -MP -pthread \
		$(TARGET_CFLAGS) -DAST_MODULE_SELF_SYM=__internal_chan_lantiq_self \
		$(CHAN_LANTIQ_AST_INCLUDES) \
		$(TARGET_CPPFLAGS) \
		-Wall -Wstrict-prototypes -Wmissing-prototypes \
		-Wmissing-declarations $(FPIC) -DAST_MODULE=\"chan_lantiq\" && \
	$(TARGET_CC) -o chan_lantiq.so -pthread $(TARGET_LDFLAGS) -shared \
		-Wl,--version-script,chan_lantiq.exports,--warn-common \
		chan_lantiq.o
endef

$(eval $(call BuildPackage,asterisk13-$(PKG_NAME)))
$(eval $(call BuildPackage,asterisk15-$(PKG_NAME)))
