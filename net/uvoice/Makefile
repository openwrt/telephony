# SPDX-License-Identifier: GPL-2.0-only
#
# uvoice - native voice stack for OpenWrt
# Copyright (C) 2026 Adtran Inc.
# Author: Chad Monroe <chad.monroe@adtran.com>
#
# Licensed under GPL-2.0-only with the linking exception stated in LICENSE.

include $(TOPDIR)/rules.mk

PKG_NAME:=uvoice
PKG_VERSION:=1.1.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/cmonroe/uvoice.git
PKG_SOURCE_DATE:=2026-11-04
PKG_SOURCE_VERSION:=055e5b400ef71f69be5c69995da61b8555c3b7b1
PKG_MIRROR_HASH:=6d1040e382abb0ce72c0c7ddeb0c60a3e5a1c40458902d541a34b19673d1730e

PKG_LICENSE:=GPL-2.0-only LGPL-2.1-only BSD-2-Clause
PKG_LICENSE_FILES:=uvoice/LICENSE uvsrtp/LICENSE udsp/LICENSE \
	udsp/LICENSES/BSD-2-Clause.txt
PKG_MAINTAINER:=Chad Monroe <chad.monroe@adtran.com>, John Crispin <john@phrozen.org>
PKG_BUILD_PARALLEL:=1
CMAKE_INSTALL:=1
# Every config symbol CMAKE_OPTIONS or DEPENDS reads, so a change of one
# reconfigures the package.
PKG_CONFIG_DEPENDS:= \
	CONFIG_PACKAGE_libudsp \
	CONFIG_UDSP_OPUS \
	CONFIG_UVOICE_HAL_UDSP \
	CONFIG_UVOICE_HAL_CSS \
	CONFIG_UVOICE_PROTO_SIP \
	CONFIG_UVOICE_PROTO_MGCP

UVSRTP_VERSION:=1.0.0
UDSP_VERSION:=1.2.0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_SOURCE_DIR=$(PKG_BUILD_DIR)/$(1)/src
CMAKE_BINARY_DIR=$(PKG_BUILD_DIR)/build-$(1)
CMAKE_OPTIONS+=$(CMAKE_OPTIONS_$(1))

CMAKE_OPTIONS_uvsrtp:=-DUVSRTP_VERSION=$(UVSRTP_VERSION)

# ON or OFF, never AUTO: a staging-dir libopus left by another package must
# not flip the link under a config that did not select it.
CMAKE_OPTIONS_udsp:= \
	-DUDSP_TOOLS=ON \
	-DUDSP_OPUS=$(if $(CONFIG_UDSP_OPUS),ON,OFF) \
	-DUDSP_VERSION=$(UDSP_VERSION)

# The HAL backend is a build time choice between stub, udsp and css, see
# Package/uvoice/config. The default choice is css on the dspg target and stub
# elsewhere. The udsp and css backends link the libudsp and libuvsrtp built
# by this package. The SIP entry prompts only beside MGCP, and the cmake
# configure refuses an image with no protocol unit.
CMAKE_OPTIONS_uvoice:= \
	-DUVOICE_HAL=$(if $(CONFIG_UVOICE_HAL_UDSP),udsp,$(if $(CONFIG_UVOICE_HAL_CSS),css,stub)) \
	-DUVOICE_PROTO_SIP=$(if $(CONFIG_UVOICE_PROTO_SIP),ON,OFF) \
	-DUVOICE_PROTO_MGCP=$(if $(CONFIG_UVOICE_PROTO_MGCP),ON,OFF) \
	-DUVOICE_VERSION=$(PKG_VERSION) \
	-DUVOICE_UVSRTP_INCLUDEDIR=$(PKG_BUILD_DIR)/uvsrtp/src/include \
	-DUVOICE_UVSRTP_LIBDIR=$(PKG_BUILD_DIR)/build-uvsrtp \
	-DUVOICE_UDSP_INCLUDEDIR=$(PKG_BUILD_DIR)/udsp/src/include \
	-DUVOICE_UDSP_LIBDIR=$(PKG_BUILD_DIR)/build-udsp

UVOICE_PARTS:=uvsrtp $(if $(CONFIG_PACKAGE_libudsp),udsp) uvoice

define Build/Configure
endef

define Build/Compile
	$(foreach part,$(UVOICE_PARTS),
		$(call Build/Configure/Default,$(part))
		+$(NINJA) -C $(call CMAKE_BINARY_DIR,$(part))
	)
endef

define Build/Install
	$(foreach part,$(UVOICE_PARTS),
		DESTDIR="$(PKG_INSTALL_DIR)" $(NINJA) -C $(call CMAKE_BINARY_DIR,$(part)) install
	)
endef

define Package/uvoice/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  URL:=https://github.com/cmonroe/uvoice
endef

define Package/libuvsrtp
$(call Package/uvoice/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=SRTP/SRTCP per-stream protection over libsrtp2
  DEPENDS:=+libsrtp2
  ABI_VERSION:=$(UVSRTP_VERSION)
  LICENSE:=LGPL-2.1-only
  LICENSE_FILES:=uvsrtp/LICENSE
endef

define Package/libuvsrtp/description
  A small library that protects and unprotects one RTP/RTCP stream with
  AES-CM-128 and HMAC-SHA1, over Cisco libsrtp2. One context per stream, with
  create, rekey, protect, unprotect and counters.
endef

define Package/libudsp
$(call Package/uvoice/Default)
  TITLE:=udsp software voice DSP for FXS lines
  DEPENDS:=@ARCH_64BIT +alsa-lib +libsrtp2 +libuvsrtp +UDSP_OPUS:libopus
  ABI_VERSION:=$(UDSP_VERSION)
  LICENSE:=LGPL-2.1-only BSD-2-Clause
  LICENSE_FILES:=udsp/LICENSE udsp/LICENSES/BSD-2-Clause.txt
endef

define Package/libudsp/config
config UDSP_OPUS
	bool "Build the Opus codec into libudsp"
	depends on PACKAGE_libudsp
	default n
	help
	  Compiles dsp/opus.c against libopus and advertises the Opus
	  selector. Off by default; images without it carry no libopus.
endef

define Package/libudsp/description
  A shared library with a software voice DSP for FXS lines: line control,
  codecs, RTP/SRTP, jitter buffer, tone/DTMF/CID generation and detection, and
  echo cancellation, behind a plug-in HAL. Hosted in-process by uvoiced through
  its hal/udsp backend. The SLIC control plug-in is a separate package
  (udsp-slic-proslic).
endef

define Package/udsp-cli
$(call Package/uvoice/Default)
  TITLE:=udsp lab and bring-up tool
  DEPENDS:=+libudsp
  LICENSE:=LGPL-2.1-only BSD-2-Clause
  LICENSE_FILES:=udsp/LICENSE udsp/LICENSES/BSD-2-Clause.txt
endef

define Package/udsp-cli/description
  Bring-up and lab tools for libudsp. udsp-cli: loopback, tone, ring, cid,
  dtmf and a call to a fixed RTP peer, the line-level lab tool.
  udsp-linecap: one line action while the SLIC transmit path is
  recorded to a file, for the host-side analysis of what the line carried.
endef

define Package/uvoice
$(call Package/uvoice/Default)
  TITLE:=Native voice stack for OpenWrt
  DEPENDS:=+libubox +libubus +libuci +libblobmsg-json \
	+UVOICE_PROTO_SIP:libopenssl \
	+curl \
	+firewall4 \
	+jq \
	+tcpdump \
	+ucode-mod-struct \
	+ucode \
	+ucode-mod-ubus \
	+UVOICE_HAL_UDSP:libudsp \
	+UVOICE_HAL_UDSP:alsa-utils \
	+UVOICE_HAL_CSS:libuvsrtp \
	+UVOICE_HAL_CSS:alsa-lib
endef

define Package/uvoice/description
  Lightweight voice stack for the MediaTek MT798x and Airoha AN7581
  FXS platforms and the Snom D735 desk phone. One libubox and libubus
  daemon contains the SIP user agents or the MGCP endpoints, FXS state
  machines and the DSP control plane. The hardware backend and the
  protocols are selected at build time.
endef

define Package/uvoice/config
	choice
		prompt "uvoice HAL backend"
		default UVOICE_HAL_CSS if TARGET_dspg
		default UVOICE_HAL_STUB

		config UVOICE_HAL_STUB
			bool "stub: no hardware, x86 and CI"

		config UVOICE_HAL_UDSP
			bool "udsp: software voice DSP on ALSA and spidev"
			depends on ARCH_64BIT

		config UVOICE_HAL_CSS
			bool "css: Snom D735 CSS co-processor (DVF99)"
	endchoice

	config UVOICE_PROTO_SIP
		bool "SIP signaling" if UVOICE_PROTO_MGCP
		default y
		help
		  Puts the SIP protocol unit and its OpenSSL link in the image.
		  voip.base.protocol sip selects it at the daemon start. The
		  prompt shows only while UVOICE_PROTO_MGCP is set; without it,
		  the entry keeps its default, so an image always carries a
		  protocol.

	config UVOICE_PROTO_MGCP
		bool "MGCP signaling (RFC 3435)"
		default n
		help
		  Puts the MGCP protocol unit in the image, the gateway side
		  of RFC 3435 and PacketCable NCS 1.5. voip.base.protocol mgcp
		  selects it at the daemon start. The unit links no OpenSSL,
		  so an image with MGCP alone carries no libopenssl. With
		  this option set, UVOICE_PROTO_SIP can be turned off.
endef

UDSP_SRC:=$(PKG_BUILD_DIR)/udsp/src

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/uvsrtp $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/include/uvsrtp/uvsrtp.h $(1)/usr/include/uvsrtp/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libuvsrtp.so* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/uvsrtp.pc $(1)/usr/lib/pkgconfig/
	$(if $(CONFIG_PACKAGE_libudsp), \
		$(INSTALL_DIR) $(1)/usr/include/udsp $(1)/usr/share/udsp/src; \
		$(CP) $(UDSP_SRC)/include/udsp/*.h $(1)/usr/include/udsp/; \
		$(CP) $(UDSP_SRC)/slic/host_linux.h $(UDSP_SRC)/slic/plugin_load.h \
			$(UDSP_SRC)/slic/fake.h $(1)/usr/include/udsp/; \
		$(CP) $(PKG_INSTALL_DIR)/usr/lib/libudsp.so* $(1)/usr/lib/; \
		$(CP) $(UDSP_SRC)/slic/host_linux.c $(UDSP_SRC)/slic/plugin_load.c \
			$(1)/usr/share/udsp/src/)
endef

define Package/libuvsrtp/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libuvsrtp.so.* $(1)/usr/lib/
endef

define Package/libudsp/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libudsp.so.* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/share/udsp/regions
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/udsp/data/regions/*.conf \
		$(1)/usr/share/udsp/regions/
endef

define Package/udsp-cli/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/udsp-cli $(1)/usr/bin/udsp-cli
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/udsp-linecap \
		$(1)/usr/bin/udsp-linecap
endef

UVOICE_FILES:=$(PKG_BUILD_DIR)/uvoice/files

define Package/uvoice/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/uvoiced $(1)/usr/sbin/uvoiced
	$(INSTALL_BIN) $(UVOICE_FILES)/uvoice_tls_cert.sh $(1)/usr/sbin/uvoice_tls_cert.sh
	$(INSTALL_BIN) $(UVOICE_FILES)/voice-cli $(1)/usr/sbin/voice-cli

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(UVOICE_FILES)/uvoice.init $(1)/etc/init.d/uvoice

	$(INSTALL_DIR) $(1)/etc/profile.d
	$(INSTALL_DATA) $(UVOICE_FILES)/uvoice.profile $(1)/etc/profile.d/uvoice.sh

	$(INSTALL_DIR) $(1)/usr/share/uvoice
	$(if $(CONFIG_UVOICE_HAL_CSS),echo css > $(1)/usr/share/uvoice/hal)
	$(INSTALL_DATA) $(UVOICE_FILES)/uvoice.sh $(1)/usr/share/uvoice/uvoice.sh
	$(INSTALL_BIN) $(UVOICE_FILES)/uvoice-cli.uc $(1)/usr/share/uvoice/uvoice-cli.uc
	$(INSTALL_BIN) $(UVOICE_FILES)/calltrace-wire.sh $(1)/usr/share/uvoice/calltrace-wire.sh
	$(INSTALL_BIN) $(UVOICE_FILES)/calltrace-finish.sh $(1)/usr/share/uvoice/calltrace-finish.sh
	$(INSTALL_DATA) $(UVOICE_FILES)/calltrace-README.txt $(1)/usr/share/uvoice/calltrace-README.txt
	$(INSTALL_DATA) $(UVOICE_FILES)/calltrace-summary.uc $(1)/usr/share/uvoice/calltrace-summary.uc
	$(INSTALL_DATA) $(UVOICE_FILES)/voip-defaults.sh \
		$(1)/usr/share/uvoice/voip-defaults.sh

	$(INSTALL_DIR) $(1)/usr/share/nftables.d/table-pre
	$(INSTALL_DATA) $(UVOICE_FILES)/nftables.d/table-pre/20-uvoice.nft $(1)/usr/share/nftables.d/table-pre/20-uvoice.nft
	$(INSTALL_DIR) $(1)/usr/share/nftables.d/chain-pre/input
	$(INSTALL_DATA) $(UVOICE_FILES)/nftables.d/chain-pre/input/20-uvoice.nft $(1)/usr/share/nftables.d/chain-pre/input/20-uvoice.nft

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) $(UVOICE_FILES)/uvoice.defaults $(1)/etc/uci-defaults/90-uvoice
endef

$(eval $(call BuildPackage,libuvsrtp))
$(eval $(call BuildPackage,libudsp))
$(eval $(call BuildPackage,udsp-cli))
$(eval $(call BuildPackage,uvoice))
