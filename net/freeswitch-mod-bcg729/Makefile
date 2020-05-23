#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=freeswitch-mod-bcg729

PKG_VERSION:=20170629
PKG_RELEASE:=1
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

PKG_LICENSE:=MPL-1.1
PKG_LICENSE_FILES:=LICENSE

PKG_SOURCE:=freeswitch-mod-bcg729-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/xadhoom/mod_bcg729.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=freeswitch-mod-bcg729-$(PKG_VERSION)
PKG_SOURCE_VERSION:=686eb06d4a395d94c364efff4b63579af76ebec7
PKG_MIRROR_HASH:=efc9421223bba3ba7dd127531aa6887c39ed42d5fb8c0b0c67b15f3c98134b0a

include $(INCLUDE_DIR)/package.mk

BCG729_MOD_DIR:=/usr/lib/freeswitch/mod

BCG729_CFLAGS:=\
	$(FPIC) \
	$(TARGET_CFLAGS) \
	-fno-exceptions \
	-Wall \
	-std=c99 \
	-pedantic

BCG729_INCLUDES:= \
	$(TARGET_CPPFLAGS) \
	-I$(STAGING_DIR)/usr/include/bcg729 \
	-I$(STAGING_DIR)/usr/include/freeswitch

BCG729_LDFLAGS:=-lm -Wl,-shared -lbcg729 -Wl,-Bdynamic

define Package/freeswitch-mod-bcg729
  TITLE:=bcg729 module
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=https://github.com/xadhoom/mod_bcg729
  DEPENDS:=freeswitch +bcg729
endef

define Package/freeswitch-mod-bcg729/description
FreeSWITCH G.729 module using the opensource bcg729 implementation by
Belledonne Communications.
endef

define Package/freeswitch-mod-bcg729/install
	$(INSTALL_DIR) $(1)$(BCG729_MOD_DIR)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mod_bcg729.so $(1)$(BCG729_MOD_DIR)
endef

define Build/Compile
	cd $(PKG_BUILD_DIR) && \
	$(TARGET_CC) \
		$(BCG729_CFLAGS) \
		$(BCG729_INCLUDES) \
		-c mod_bcg729.c && \
	$(TARGET_CC) \
		$(BCG729_CFLAGS) \
		$(BCG729_INCLUDES) \
		-shared \
		-Xlinker \
		-x \
		-o mod_bcg729.so \
		mod_bcg729.o \
		$(BCG729_LDFLAGS)
endef

$(eval $(call BuildPackage,freeswitch-mod-bcg729))
