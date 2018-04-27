#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk13-chan-lantiq
PKG_VERSION:=20180215
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/kochstefan/asterisk_channel_lantiq.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=f0d7ca7df8e5df802c5bcb79643e3bdc3956c190
PKG_MIRROR_HASH:=aaf5ce87a2e23b801318add79eaaa1b7c4a8aa497ca8e2a71ef5d452a7595a73
PKG_SOURCE_PROTO:=git

PKG_LICENSE:=GPL-2.0

PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_FLAGS:=nonshared

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SUBMENU:=Telephony Lantiq
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Lantiq channel driver
  URL:=https://github.com/kochstefan/asterisk_channel_lantiq
  DEPENDS:=+asterisk13 +kmod-ltq-vmmc
endef

define Package/$(PKG_NAME)/description
An implementation of a Lantiq TAPI channel driver for Asterisk 13.
endef

define Package/$(PKG_NAME)/conffiles
/etc/asterisk/lantiq.conf
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(INSTALL_DATA) ./files/default.exports \
		$(PKG_BUILD_DIR)/src/channels/chan_lantiq.exports
endef

define Build/Compile
	cd $(PKG_BUILD_DIR)/src/channels && \
	$(TARGET_CC) -o chan_lantiq.o -c chan_lantiq.c -MD -MT chan_lantiq.o \
		-MF .chan_lantiq.o.d -MP -pthread \
		$(TARGET_CFLAGS) -DAST_MODULE_SELF_SYM=__internal_chan_lantiq_self \
		-I$(STAGING_DIR)/usr/include/asterisk-13/include \
		$(TARGET_CPPFLAGS) \
		-Wall -Wstrict-prototypes -Wmissing-prototypes \
		-Wmissing-declarations $(FPIC) -DAST_MODULE=\"chan_lantiq\" && \
	$(TARGET_CC) -o chan_lantiq.so -pthread $(TARGET_LDFLAGS) -shared \
		-Wl,--version-script,chan_lantiq.exports,--warn-common \
		chan_lantiq.o
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/src/configs/samples/lantiq.conf.sample \
		$(1)/etc/asterisk/lantiq.conf
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/src/channels/chan_lantiq.so \
		$(1)/usr/lib/asterisk/modules
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
