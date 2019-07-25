#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk-opus
PKG_VERSION:=20171009
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/traud/asterisk-opus.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=83e1b458c77e0e287adeca494eeb79edb077b0ff
PKG_MIRROR_HASH:=89265ee63bc3cb02ef9e75087f782147db1dec53433f9d6cfc08c7229cd61881
PKG_SOURCE_PROTO:=git

PKG_BUILD_DIR=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

TARGET_CFLAGS += \
	-DAST_MODULE_SELF_SYM=__internal_codec_opus_open_source_self \
	$(FPIC)

define Package/$(PKG_NAME)/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Opus codec support
  URL:=https://github.com/traud/asterisk-opus
  DEPENDS:=+libopus
endef

define Package/asterisk16-codec-opus
$(call Package/$(PKG_NAME)/Default)
  DEPENDS+=asterisk16
  VARIANT:=asterisk16
endef

define Package/description/Default
  Opus is the default audio codec in WebRTC. WebRTC is available in
  Asterisk via SIP over WebSockets (WSS). Nevertheless, Opus can be used
  for other transports (UDP, TCP, TLS) as well. Opus supersedes previous
  codecs like CELT and SiLK. Furthermore, in favor of Opus, other
  open-source audio codecs are no longer developed, like Speex, iSAC,
  iLBC, and Siren. If you use your Asterisk as a back-to-back user agent
  (B2BUA) and you transcode between various audio codecs, one should
  enable Opus for future compatibility.

  Opus is not only supported for pass-through but can be transcoded as
  well.
endef

Package/asterisk16-codec-opus/description = $(Package/description/Default)

ifeq ($(BUILD_VARIANT),asterisk16)
TARGET_CFLAGS+=-I$(STAGING_DIR)/usr/include/asterisk-16/include
endif

define Package/Install/Default
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/codecs/codec_opus_open_source.so \
		$(1)/usr/lib/asterisk/modules
endef

Package/asterisk16-codec-opus/install = $(Package/Install/Default)

define Build/Configure
endef

$(eval $(call BuildPackage,asterisk16-codec-opus))
