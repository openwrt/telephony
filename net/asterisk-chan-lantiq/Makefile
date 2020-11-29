#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk-chan-lantiq
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/kochstefan/asterisk_channel_lantiq.git
PKG_SOURCE_VERSION:=1d940b38cde0348dfe129d2b764e6faee440c45b
PKG_SOURCE_DATE:=2019-08-03
PKG_MIRROR_HASH:=f8aa4cccc90ad8503c94ddb03c4af7870f3262b99f1dca198c0e8d351aa96588
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
  DEPENDS:=+asterisk +kmod-ltq-vmmc
endef

define Package/$(PKG_NAME)/description
An implementation of a Lantiq TAPI channel driver for Asterisk.
endef

define Package/$(PKG_NAME)/conffiles
/etc/asterisk/lantiq.conf
endef

define Build/Compile
	cd $(PKG_BUILD_DIR)/src/channels && \
	$(TARGET_CC) -o chan_lantiq.o -c chan_lantiq.c -MD -MT chan_lantiq.o \
		-MF .chan_lantiq.o.d -MP -pthread \
		$(TARGET_CFLAGS) -DAST_MODULE_SELF_SYM=__internal_chan_lantiq_self \
		$(TARGET_CPPFLAGS) \
		-Wall -Wstrict-prototypes -Wmissing-prototypes \
		-Wmissing-declarations $(FPIC) -DAST_MODULE=\"chan_lantiq\" && \
	$(TARGET_CC) -o chan_lantiq.so -pthread $(TARGET_LDFLAGS) -shared \
		-Wl,--version-script,chan_lantiq.exports,--warn-common \
		chan_lantiq.o
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/src/configs/samples/lantiq.conf.sample \
		$(1)/etc/asterisk/lantiq.conf
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/src/channels/chan_lantiq.so \
		$(1)/usr/lib/asterisk/modules
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
