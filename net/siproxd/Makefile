#
# Copyright (C) 2014-2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=siproxd
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/hb9xar/siproxd.git
PKG_SOURCE_DATE:=2025-07-24
PKG_SOURCE_VERSION:=0bb5dd4aac9f5578db664d82f67091bc83c3780d
PKG_MIRROR_HASH:=1f0c7f9aabc130e4d66c6e0b4113f44054d653ff87436c1128b3df8323042447

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

PKG_CONFIG_DEPENDS:=CONFIG_SIPROXD_MAX_CLIENTS

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Tony Ambardar <itugrok@yahoo.com>

include $(INCLUDE_DIR)/package.mk

define Package/siproxd/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  URL:=http://siproxd.sourceforge.net/
endef

define Package/siproxd
  $(call Package/siproxd/Default)
  DEPENDS:=+libltdl +libpthread +libosip2
  TITLE:=SIP (Session Initiation Protocol) proxy
  MENU:=1
endef

define Package/siproxd/description
 Siproxd is a proxy/masquerading daemon for the SIP protocol. Refer to https://openwrt.org/docs/guide-user/services/voip/siproxd for configuration details and examples.
endef

define Package/siproxd/conffiles
/etc/config/siproxd
endef

define Package/siproxd/config
	config SIPROXD_MAX_CLIENTS
		int "Max supported clients"
		default 32
		depends on PACKAGE_siproxd
		help
		  Default 32 is sufficient for home environments. Larger values
		  consume more memory (e.g. RSS of 17 MB with upstream default 512).
endef

CONFIGURE_ARGS+= \
	--enable-reproducible-build \
	--with-libosip-prefix="$(STAGING_DIR)/usr" \
	--without-included-ltdl \
	--disable-doc

MAKE_FLAGS+= \
	SUBDIRS="src contrib"

TARGET_CFLAGS+= \
	-Wno-unused-const-variable

URLMAP:=$(CONFIG_SIPROXD_MAX_CLIENTS)
RTPPROXY:=$(shell expr $(URLMAP) \* 2)

define Build/Configure
	$(call Build/Configure/Default)
	$(ESED) 's;^(#define[[:space:]]+URLMAP_SIZE).*$$$$;\1 $(URLMAP);' \
		-e 's;^(#define[[:space:]]+RTPPROXY_SIZE).*$$$$;\1 $(RTPPROXY);' \
		$(PKG_BUILD_DIR)/src/siproxd.h
endef

define Package/siproxd/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/siproxd $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/siproxd.config $(1)/etc/config/siproxd
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/siproxd.init $(1)/etc/init.d/siproxd
endef

define BuildPlugin
  define Package/siproxd-mod-$(subst _,-,$(1))
    $$(call Package/siproxd/Default)
    TITLE:= siproxd $(1) plugin
    DEPENDS:=siproxd $(2)
  endef

  define Package/siproxd-mod-$(subst _,-,$(1))/install
	$(INSTALL_DIR) $$(1)/usr/lib/siproxd
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/siproxd/plugin_$(1).so \
		$$(1)/usr/lib/siproxd
  endef

  $$(eval $$(call BuildPackage,siproxd-mod-$(subst _,-,$(1))))
endef

$(eval $(call BuildPackage,siproxd))
$(eval $(call BuildPlugin,blacklist,+libsqlite3))
$(eval $(call BuildPlugin,codecfilter))
$(eval $(call BuildPlugin,defaulttarget))
$(eval $(call BuildPlugin,demo))
$(eval $(call BuildPlugin,fix_bogus_via))
$(eval $(call BuildPlugin,fix_DTAG))
$(eval $(call BuildPlugin,fix_fbox_anoncall))
$(eval $(call BuildPlugin,logcall))
$(eval $(call BuildPlugin,prefix))
$(eval $(call BuildPlugin,regex))
$(eval $(call BuildPlugin,shortdial))
$(eval $(call BuildPlugin,stats))
$(eval $(call BuildPlugin,stripheader))
$(eval $(call BuildPlugin,stun))
$(eval $(call BuildPlugin,siptrunk))
