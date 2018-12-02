#
# Copyright (C) 2014 - 2018 OpenWrt.org
# Copyright (C) 2017 - 2018 Jiri Slachta <jiri@slachta.eu>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rtpproxy
PKG_VERSION:=2.1.0-20170914
PKG_RELEASE:=4

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/sippy/rtpproxy.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=589cc78cb8698b49aa408c6411c8720a2a0efe3c
PKG_MIRROR_HASH:=087b363a7e5f112fe0c601e147ac087f528a500a25340cbccc12d90935876137
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.xz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_CHECK_FORMAT_SECURITY:=0
PKG_INSTALL:=1

PKG_FIXUP:=autoreconf

PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

include $(INCLUDE_DIR)/package.mk

define Package/rtpproxy/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  URL:=http://www.rtpproxy.org/
endef

define Package/rtpproxy
$(call Package/rtpproxy/Default)
  DEPENDS:=+libpthread +librt
  TITLE:=RTP (Realtime Transport Protocol) proxy
  MENU:=1
endef

define Package/rtpproxy/conffiles
/etc/init.d/rtpproxy
/etc/config/rtpproxy
endef

define Package/rtpproxy-mod-acct-csv
$(call Package/rtpproxy/Default)
  DEPENDS:=rtpproxy
  TITLE:=RTPproxy accounting module
endef

CONFIGURE_VARS += \
        ac_cv_lib_bcg729_initBcg729EncoderChannel=no

# Otherwise OpenWrt's CPPFLAGS are ignored
TARGET_CFLAGS+=$(TARGET_CPPFLAGS)

define Package/rtpproxy/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/rtpproxy $(1)/usr/bin

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/rtpproxy.init $(1)/etc/init.d/rtpproxy

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/rtpproxy.config $(1)/etc/config/rtpproxy

	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) ./files/rtpproxy.hotplug $(1)/etc/hotplug.d/iface/90-rtpproxy
endef

define Package/rtpproxy/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  echo
  echo "o-------------------------------------------------------------------o"
  echo "| RTPProxy note                                                     |"
  echo "o-------------------------------------------------------------------o"
  echo "| Edit /etc/config/rtpproxy to change basic init configuration.     |"
  echo "o-------------------------------------------------------------=^_^=-o"
  echo
fi
exit 0
endef

define Package/rtpproxy-mod-acct-csv/install
	$(INSTALL_DIR) $(1)/usr/lib/rtpproxy
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/rtpproxy/rtpp_acct_csv.so \
							$(1)/usr/lib/rtpproxy
endef

$(eval $(call BuildPackage,rtpproxy))
$(eval $(call BuildPackage,rtpproxy-mod-acct-csv))
