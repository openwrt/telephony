# 
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dahdi-tools
PKG_VERSION:=3.1.0
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://downloads.asterisk.org/pub/telephony/dahdi-tools/releases
PKG_HASH:=ea852ebd274ee1cc90ff5e4ac84261b0b787b1a74e8b76ad659bc9ec4f77e67e

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Vittorio Gambaletta <openwrt@vittgam.net>

PKG_BUILD_PARALLEL:=1

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/dahdi-cfg/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Telephony
  DEPENDS=+kmod-dahdi
endef

define Package/dahdi-cfg
  $(call Package/dahdi-cfg/Default)
  DEPENDS+=+libpthread +dahdi-tools-libtonezone
  TITLE:=DAHDI tools dahdi_cfg, dahdi_scan and fxotune
endef

define Package/dahdi-monitor
  $(call Package/dahdi-cfg/Default)
  TITLE:=DAHDI tools dahdi_monitor, dahdi_speed and dahdi_test
endef

define Package/dahdi-tools-libtonezone
  $(call Package/dahdi-cfg/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=DAHDI tonezone library
endef

CONFIGURE_ARGS += \
	--disable-silent-rules \
	--with-perllib="" \
	--without-libusb \
	--without-libusbx \
	--without-newt \
	--without-pcap \
	--without-ppp \
	--without-selinux \
	--without-usb

# https://issues.asterisk.org/jira/browse/DAHTOOL-85
TARGET_CFLAGS+=-fcommon

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libtonezone.{a,so*} \
		$(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/include/dahdi
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/dahdi/tonezone.h \
		$(1)/usr/include/dahdi/
endef

define Package/dahdi-cfg/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/{dahdi_cfg,dahdi_scan,fxotune} \
		$(1)/usr/sbin/
endef

define Package/dahdi-monitor/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/{dahdi_monitor,dahdi_speed,dahdi_test} \
		$(1)/usr/sbin/
endef

define Package/dahdi-tools-libtonezone/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libtonezone.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,dahdi-cfg))
$(eval $(call BuildPackage,dahdi-monitor))
$(eval $(call BuildPackage,dahdi-tools-libtonezone))
