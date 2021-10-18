#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk-opus
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_URL:=https://github.com/traud/asterisk-opus.git
PKG_SOURCE_DATE:=2021-11-01
PKG_SOURCE_VERSION:=20522fbcd3fdf6f0adb20602d096d14cd69055e8
PKG_MIRROR_HASH:=e14dc42b0e5f4720e3f028e0b426f4e660bf315a103a015820ca3697e1fe9985
PKG_SOURCE_PROTO:=git

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

include $(INCLUDE_DIR)/package.mk

TARGET_CFLAGS += \
	$(FPIC)

define Package/asterisk-codec-opus
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Opus codec support
  URL:=https://github.com/traud/asterisk-opus
  DEPENDS:=asterisk +libopus
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

define Build/Configure
endef

$(eval $(call BuildPackage,asterisk-codec-opus))
