#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=chan-lantiq
PKG_VERSION:=20170304
PKG_RELEASE:=1

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

PKG_FLAGS:=nonshared

# WARNING: Because this module is target specific ("nonshared") it cannot depend
# on the shared Asterisk package. Asterisk needs to be built _before_ this
# package, though, to generate the necessary headers.

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/version.mk

define Package/$(PKG_NAME)/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Lantiq channel driver
  URL:=https://github.com/kochstefan/asterisk_channel_lantiq
  DEPENDS:=@(TARGET_lantiq_falcon||TARGET_lantiq_xway||TARGET_lantiq_xrx200) +kmod-ltq-vmmc
endef

define Package/$(PKG_NAME)-asterisk13
$(call Package/$(PKG_NAME)/Default)
  VARIANT:=asterisk13
endef

define Package/description/Default
An implementation of a Lantiq TAPI channel driver for Asterisk.
endef

Package/$(PKG_NAME)-asterisk13/description = $(Package/description/Default)

define Package/conffiles/Default
/etc/asterisk/lantiq.conf
endef

Package/$(PKG_NAME)-asterisk13/conffiles = $(Package/conffiles/Default)

define Package/Install/Default
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(INSTALL_CONF) $(SOURCE)/files/lantiq-$(BUILD_VARIANT).conf.sample \
		$(1)/etc/asterisk/lantiq.conf
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/chan_lantiq.so \
		$(1)/usr/lib/asterisk/modules
endef

Package/$(PKG_NAME)-asterisk13/install = $(Package/Install/Default)

define Build/Prepare
	$(CP) $(SOURCE)/files/chan_lantiq-$(BUILD_VARIANT).c $(PKG_BUILD_DIR)/chan_lantiq.c
	$(CP) $(SOURCE)/files/default.exports $(PKG_BUILD_DIR)/chan_lantiq.exports
	$(TAR) --extract --no-same-owner --no-same-permissions --xz \
		--file=$(DL_DIR)/$(BUILD_VARIANT)-$(call qstrip,$(CONFIG_TARGET_ARCH_PACKAGES))-headers-for-chan-lantiq-$(VERSION_NUMBER).tar.xz \
		--directory=$(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
	cd $(PKG_BUILD_DIR) && \
	$(TARGET_CC) -o chan_lantiq.o -c chan_lantiq.c -MD -MT chan_lantiq.o \
		-MF .chan_lantiq.o.d -MP -pthread \
		$(TARGET_CFLAGS) \
		-I$(PKG_BUILD_DIR)/include \
		$(TARGET_CPPFLAGS) \
		-Wall -Wstrict-prototypes -Wmissing-prototypes \
		-Wmissing-declarations $(FPIC) -DAST_MODULE=\"chan_lantiq\" && \
	$(TARGET_CC) -o chan_lantiq.so -pthread $(TARGET_LDFLAGS) -shared \
		-Wl,--version-script,chan_lantiq.exports,--warn-common \
		chan_lantiq.o
endef

$(eval $(call BuildPackage,$(PKG_NAME)-asterisk13))
