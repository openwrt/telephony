#
# Copyright (C) 2020 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=rtpengine
PKG_VERSION:=11.5.1.18
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-mr$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/sipwise/rtpengine/tar.gz/mr$(PKG_VERSION)?
PKG_HASH:=d5b0288ec02164b13730c14976425160d9a0b42b1c74796f8d9e59649e705fa6

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-mr$(PKG_VERSION)

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE

PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

# When building in parallel, some files (like streambuf.c or dtmflib.c)
# are generated multiple times by the rtpengine build system.
# Intermittently they then contain garbage, leading to redefinition
# errors.
PKG_BUILD_PARALLEL:=0

PKG_BUILD_DEPENDS:=gperf/host perl/host

# With below variable set, $(PKG_SYMVERS_DIR)/rtpengine.symvers gets generated
# from kernel-module/Module.symvers.
PKG_EXTMOD_SUBDIRS:=kernel-module

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

ENGINE_DEPENDS := \
	+glib2 \
	+json-glib \
	+libevent2 \
	+libevent2-pthreads \
	+libhiredis \
	+libip4tc \
	+libmosquitto \
	+libopenssl \
	+libpcap \
	+libpcre2 \
	+libwebsockets-openssl \
	+libopus \
	+xmlrpc-c \
	+xmlrpc-c-client \
	+zlib

ENGINE_DEPENDS_TRANSCODING := \
	$(ENGINE_DEPENDS) \
	+bcg729 \
	+libffmpeg-full \
	+libmariadb \
	+libspandsp3

RECORDING_DEPENDS := \
	+bcg729 \
	+glib2 \
	+libffmpeg-full \
	+libmariadb \
	+libopenssl \
	+libcurl

RTPENGINE_USERID:=378
RTPENGINE_GROUPID:=$(RTPENGINE_USERID)
RTPENGINE_USER:=$(PKG_NAME)=$(RTPENGINE_USERID):$(PKG_NAME)=$(RTPENGINE_GROUPID)

define Package/rtpengine/Default
  URL:=https://github.com/sipwise/rtpengine
endef

define Package/rtpengine/Template
$(call Package/rtpengine/Default)
  TITLE:=Sipwise RTP Engine
  CATEGORY:=Network
  SECTION:=net
  SUBMENU:=Telephony
  USERID:=$(RTPENGINE_USER)
endef

define Package/rtpengine/description/Template
The Sipwise NGCP rtpengine is a proxy for RTP traffic and other UDP
based media traffic. It's meant to be used with the Kamailio SIP proxy
and forms a drop-in replacement for any of the other available RTP and
media proxies.
endef

define Package/rtpengine
$(call Package/rtpengine/Template)
  VARIANT:=transcode
  DEPENDS := \
	  $(patsubst +%,+PACKAGE_rtpengine:%,$(ENGINE_DEPENDS_TRANSCODING)) \
	  +IPV6:libip6tc
endef

define Package/rtpengine/conffiles
/etc/config/rtpengine
/etc/init.d/rtpengine
/etc/rtpengine/rtpengine.conf
endef

define Package/rtpengine/description
$(call Package/rtpengine/description/Template)

Please consider installing kmod-ipt-rtpengine.

endef

define Package/rtpengine/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/daemon/rtpengine $(1)/usr/bin

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/rtpengine.init $(1)/etc/init.d/rtpengine

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/rtpengine.conf $(1)/etc/config/rtpengine

	$(INSTALL_DIR) $(1)/etc/rtpengine
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/rtpengine.conf \
				$(1)/etc/rtpengine/rtpengine.conf

	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) ./files/rtpengine.hotplug \
		$(1)/etc/hotplug.d/iface/90-rtpengine
endef

define Package/rtpengine-no-transcode
$(call Package/rtpengine/Template)
  TITLE+= (no transcoding)
  VARIANT:=no-transcode
  CONFLICTS:=rtpengine
  DEPENDS := \
	  $(patsubst +%,+PACKAGE_rtpengine-no-transcode:%,$(ENGINE_DEPENDS)) \
	  +IPV6:libip6tc
endef

Package/rtpengine-no-transcode/conffiles=$(Package/rtpengine/conffiles)

define Package/rtpengine-no-transcode/description
$(call Package/rtpengine/description/Template)

This package comes without transcoding support.

Please consider installing kmod-ipt-rtpengine.

endef

Package/rtpengine-no-transcode/install=$(Package/rtpengine/install)

define Package/rtpengine-recording
$(call Package/rtpengine/Default)
  TITLE:=Sipwise RTP Recording Daemon
  CATEGORY:=Network
  SECTION:=net
  SUBMENU:=Telephony
  USERID:=$(RTPENGINE_USER)
  DEPENDS:=$(patsubst +%,+PACKAGE_rtpengine-recording:%,$(RECORDING_DEPENDS))
endef

define Package/rtpengine-recording/conffiles
/etc/config/rtpengine-recording
/etc/rtpengine/rtpengine-recording.conf
endef

define Package/rtpengine-recording/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/recording-daemon/rtpengine-recording \
							$(1)/usr/bin

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/rtpengine-recording.init \
		$(1)/etc/init.d/rtpengine-recording

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/rtpengine-recording.conf \
		$(1)/etc/config/rtpengine-recording

	$(INSTALL_DIR) $(1)/etc/rtpengine
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/rtpengine-recording.conf \
				$(1)/etc/rtpengine/rtpengine-recording.conf
endef

define Package/iptables-mod-rtpengine
$(call Package/rtpengine/Default)
  TITLE:=Sipwise rtpengine iptables extension
  CATEGORY:=Network
  SECTION:=net
  SUBMENU:=Firewall
  DEPENDS:=+PACKAGE_iptables-mod-rtpengine:libxtables
endef

define Package/iptables-mod-rtpengine/install
	$(INSTALL_DIR) $(1)/usr/lib/iptables
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/iptables-extension/libxt_RTPENGINE.so \
						$(1)/usr/lib/iptables
endef

define KernelPackage/ipt-rtpengine
$(call Package/rtpengine/Default)
  TITLE:=Sipwise rtpengine netfilter module
  SUBMENU:=Netfilter Extensions
  FILES:=$(PKG_BUILD_DIR)/kernel-module/xt_RTPENGINE.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoProbe,xt_RTPENGINE)
  DEPENDS := \
	  +PACKAGE_kmod-ipt-rtpengine:kmod-crypto-aead \
	  +PACKAGE_kmod-ipt-rtpengine:kmod-crypto-hash \
	  +PACKAGE_kmod-ipt-rtpengine:kmod-ipt-core
  MODPARAMS.xt_RTPENGINE := \
	  proc_uid=$(RTPENGINE_USERID) \
	  proc_gid=$(RTPENGINE_GROUPID)
  USERID:=$(RTPENGINE_USER)
endef

define KernelPackage/ipt-rtpengine/conffiles
/etc/modules.d/ipt-rtpengine
endef

define KernelPackage/ipt-rtpengine/description
Netfilter kernel module for rtpengine

endef

MAKE_VARS+=RTPENGINE_VERSION=$(PKG_VERSION)

ifeq ($(BUILD_VARIANT),no-transcode)
  MAKE_VARS+=with_transcoding=no
endif

# rtpengine uses Debian's dpkg utility programs if it can find them. But
# we don't want build host flags to leak into our cross-compile.
define Build/Prepare
	$(call Build/Prepare/Default)
ifeq ($(QUILT),)
	cd "$(PKG_BUILD_DIR)" && \
		$(FIND) . -maxdepth 2 -name "*Makefile" | \
		xargs  -I{} $(SED) \
		'/shell which dpkg-/s/dpkg/OpenWrt-has-no-dpkg/' {} && \
		$(SED) 's|#!/usr/bin/perl|#!$(STAGING_DIR_HOSTPKG)/usr/bin/perl|' \
		utils/const_str_hash
endif
endef

define Build/Configure
endef

define Build/Compile

ifneq ($(CONFIG_PACKAGE_kmod-ipt-rtpengine),)
	RTPENGINE_VERSION=$(PKG_VERSION) $(MAKE) \
		$(PKG_JOBS) \
		-C $(PKG_BUILD_DIR)/kernel-module \
		KSRC=$(LINUX_DIR) \
		$(KERNEL_MAKE_FLAGS)
endif

ifneq ($(CONFIG_PACKAGE_iptables-mod-rtpengine),)
	$(call Build/Compile/Default,-C $(PKG_BUILD_DIR)/iptables-extension)
endif

ifneq ($(CONFIG_PACKAGE_rtpengine)$(CONFIG_PACKAGE_rtpengine-no-transcode),)
	$(call Build/Compile/Default,-C $(PKG_BUILD_DIR)/daemon)
endif

ifneq ($(CONFIG_PACKAGE_rtpengine-recording),)
	$(call Build/Compile/Default,-C $(PKG_BUILD_DIR)/recording-daemon)
endif

endef

define Build/InstallDev
endef

# KernelPackage calls need to go first, otherwise hooks like
# collect_module_symvers won't get added.
$(eval $(call KernelPackage,ipt-rtpengine))
$(eval $(call BuildPackage,rtpengine-no-transcode))
$(eval $(call BuildPackage,iptables-mod-rtpengine))
$(eval $(call BuildPackage,rtpengine))
$(eval $(call BuildPackage,rtpengine-recording))
