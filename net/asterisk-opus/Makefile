#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk-opus
PKG_RELEASE:=2

PKG_SOURCE_URL:=https://github.com/traud/asterisk-opus.git
PKG_SOURCE_DATE:=2021-11-01
PKG_SOURCE_VERSION:=20522fbcd3fdf6f0adb20602d096d14cd69055e8
PKG_MIRROR_HASH:=b69ff63f18a21168d94da97da453ebac30aa1de05d1fbef72723b6231c902e2f
PKG_SOURCE_PROTO:=git

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

include $(INCLUDE_DIR)/package.mk

TARGET_CFLAGS += \
	$(FPIC)

define Package/asterisk-opus/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=https://github.com/traud/asterisk-opus
  DEPENDS:=asterisk +libopus
endef

define Package/asterisk-codec-opus
$(call Package/asterisk-opus/Default)
  TITLE:=Opus codec support
endef

define Package/asterisk-codec-opus/description
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

define Package/asterisk-codec-opus/install
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/codecs/codec_opus_open_source.so \
		$(1)/usr/lib/asterisk/modules
endef

define Package/asterisk-format-ogg-opus
$(call Package/asterisk-opus/Default)
  TITLE:=OGG/Opus audio support
  DEPENDS+=+libopusfile +libopusenc
endef

define Package/asterisk-format-ogg-opus/description
  Reading and writing audio files in the OGG/Opus format.
endef

define Package/asterisk-format-ogg-opus/install
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/formats/format_ogg_opus_open_source.so \
		$(1)/usr/lib/asterisk/modules
endef

define Build/Configure
endef

$(eval $(call BuildPackage,asterisk-codec-opus))
$(eval $(call BuildPackage,asterisk-format-ogg-opus))
