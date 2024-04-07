#
# Copyright (C) 2014 - 2018 OpenWrt.org
# Copyright (C) 2017 - 2018 Jiri Slachta <jiri@slachta.eu>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rtpproxy

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/sippy/rtpproxy.git
PKG_SOURCE_DATE=2019-10-02
PKG_SOURCE_VERSION:=aa1f179e09097f467bc4726e3300014c1e35246f
PKG_RELEASE:=4
PKG_MIRROR_HASH:=36ecff6b69b580db5fe7e34e1d6764f111aa26ce81999743cea1f3c80ffa545c

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_FIXUP:=autoreconf

PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=LICENSE
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
  DEPENDS:=+libatomic +libpthread +librt
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
  TITLE:=RTPproxy CSV accounting module
endef

define Package/rtpproxy-mod-acct-rtcp-hep
$(call Package/rtpproxy/Default)
  DEPENDS:=rtpproxy
  TITLE:=RTPproxy RTCP HEP accounting module
endef

CONFIGURE_ARGS += \
	--without-xsltproc

# Otherwise OpenWrt's CPPFLAGS are ignored
TARGET_CFLAGS+=$(TARGET_CPPFLAGS)

define Package/rtpproxy/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/rtpproxy $(1)/usr/bin

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/rtpproxy.init $(1)/etc/init.d/rtpproxy

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/rtpproxy.conf $(1)/etc/config/rtpproxy

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

define Package/rtpproxy-mod-acct-rtcp-hep/install
	$(INSTALL_DIR) $(1)/usr/lib/rtpproxy
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/lib/rtpproxy/rtpp_acct_rtcp_hep.so \
							$(1)/usr/lib/rtpproxy
endef

define Package/$(PKG_NAME)/Util
  define Package/$(PKG_NAME)-util-$(1)
    $(call Package/$(PKG_NAME)/Default)
    DEPENDS:= $(PKG_NAME) $(patsubst +%,+PACKAGE_$(PKG_NAME)-util-$(1):%,$(2))
    TITLE:=RTPproxy $(1) utility
  endef

  define Package/$(PKG_NAME)-util-$(1)/install
	  $$(INSTALL_DIR) $$(1)/usr/bin
	  $$(INSTALL_BIN) $$(PKG_INSTALL_DIR)/usr/bin/$(1) $$(1)/usr/bin
  endef

  $$(eval $$(call BuildPackage,$(PKG_NAME)-util-$(1)))
endef

$(eval $(call BuildPackage,rtpproxy))
$(eval $(call BuildPackage,rtpproxy-mod-acct-csv))
$(eval $(call BuildPackage,rtpproxy-mod-acct-rtcp-hep))
$(eval $(call Package/$(PKG_NAME)/Util,extractaudio,+bcg729 +libsndfile +libsrtp2))
$(eval $(call Package/$(PKG_NAME)/Util,makeann,+bcg729))
