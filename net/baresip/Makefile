#
# Copyright (C) 2010-2017 OpenWrt.org
# Copyright (C) 2010 Alfred E. Heggestad
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=baresip
PKG_VERSION:=0.5.6
PKG_RELEASE:=4

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.creytiv.com/pub
PKG_HASH:=148defef160842e0247af92c84bb0c8de4b36ffa68cf3a87c4cd7e510cddd00c

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=docs/COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_INSTALL:=1

baresip-mods:= \
	alsa \
	avcodec \
	avformat \
	cons \
	evdev \
	g711 \
	g722 \
	g726 \
	opus \
	oss \
	plc \
	portaudio \
	pulse \
	sndfile \
	speex \
	speex_aec \
	speex_pp \
	srtp \
	stdio \
	v4l \
	v4l2

PKG_CONFIG_DEPENDS:= \
	$(patsubst %,CONFIG_PACKAGE_baresip-mod-%,$(baresip-mods)) \

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)/config
	source "$(SOURCE)/Config.in"
endef

define Package/baresip/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  URL:=http://www.creytiv.com
endef

define Package/baresip
$(call Package/baresip/Default)
  TITLE:=Portable and modular SIP User-Agent with A/V support
  DEPENDS:=+libre +librem
  MENU:=1
endef

baresip-mod-alsa      := USE_ALSA
baresip-mod-avcodec   := USE_AVCODEC
baresip-mod-avformat  := USE_AVFORMAT
baresip-mod-cons      := USE_CONS
baresip-mod-evdev     := USE_EVDEV
baresip-mod-g711      := USE_G711
baresip-mod-g722      := USE_G722
baresip-mod-g726      := USE_G726
baresip-mod-opus      := USE_OPUS
baresip-mod-oss       := USE_OSS
baresip-mod-plc       := USE_PLC
baresip-mod-portaudio := USE_PORTAUDIO
baresip-mod-pulse     := USE_PULSE
baresip-mod-sndfile   := USE_SNDFILE
baresip-mod-speex     := USE_SPEEX
baresip-mod-speex_aec := USE_SPEEX_AEC
baresip-mod-speex_pp  := USE_SPEEX_PP
baresip-mod-srtp      := USE_SRTP
baresip-mod-stdio     := USE_STDIO
baresip-mod-v4l       := USE_V4L
baresip-mod-v4l2      := USE_V4L2

BARESIP_MOD_OPTIONS:= \
	MOD_AUTODETECT= \
	EXTRA_MODULES="dtmfio" \
	$(foreach m,$(baresip-mods),$(baresip-mod-$(m))=$(if $(CONFIG_PACKAGE_baresip-mod-$(m)),1))

MAKE_FLAGS+= \
	EXTRA_LFLAGS="$(TARGET_LDFLAGS)" \
	LD="$(TARGET_CC)" \
	LIBRE_MK="$(STAGING_DIR)/usr/share/re/re.mk" \
	LIBRE_INC="$(STAGING_DIR)/usr/include/re" \
	LIBRE_SO="$(STAGING_DIR)/usr/lib" \
	LIBREM_PATH="$(STAGING_DIR)/usr" \
	SYSROOT="$(shell $(FIND) $(TOOLCHAIN_DIR) -path '*/include/pthread.h' | sed -ne '1s|/include/pthread.h||p')" \
	SYSROOT_ALT="$(STAGING_DIR)/usr" \
	RELEASE=1 \
	$(BARESIP_MOD_OPTIONS)

TARGET_CFLAGS+=-D_GNU_SOURCE

define Package/baresip/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/baresip $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/lib/baresip/modules
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/lib/baresip/modules/{account,auloop,contact,ice,menu,stun,turn}.so \
		$(1)/usr/lib/baresip/modules
	$(INSTALL_DIR) $(1)/usr/share/baresip
	$(CP) $(PKG_INSTALL_DIR)/usr/share/baresip/* $(1)/usr/share/baresip
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/baresip.init $(1)/etc/init.d/baresip
endef

##################
# bareSIP modules
# 1. Name
# 2. Title
# 3. Files
# 4. Dependencies
##################

define BuildPlugin

  define Package/baresip-mod-$(1)
    $$(call Package/baresip/Default)
    TITLE:=$(2)
    DEPENDS:=baresip $(patsubst +%,+PACKAGE_$(PKG_NAME)-mod-$(1):%,$(4))
  endef

  define Package/baresip-mod-$(1)/install
	[ -z "$(3)" ] || $(INSTALL_DIR) $$(1)/usr/lib/baresip/modules
	for f in $(3); do \
		$(INSTALL_DATA) \
			$(PKG_INSTALL_DIR)/usr/lib/baresip/modules/$$$$$$$${f}.so \
			$$(1)/usr/lib/baresip/modules; \
	done
  endef

  $$(eval $$(call BuildPackage,baresip-mod-$(1)))
endef

$(eval $(call BuildPackage,baresip))

$(eval $(call BuildPlugin,alsa,ALSA audio driver,alsa,+alsa-lib))
$(eval $(call BuildPlugin,aubridge,Audio bridge module,aubridge,))
$(eval $(call BuildPlugin,aufile,Audio module for using a WAV-file as audio input,aufile,))
$(eval $(call BuildPlugin,avcodec,Video codec using FFmpeg,avcodec,@BARESIP_WITH_FFMPEG +libffmpeg-full +libx264))
$(eval $(call BuildPlugin,avformat,Video source using FFmpeg,avformat,@BARESIP_WITH_FFMPEG +libffmpeg-full))
$(eval $(call BuildPlugin,cons,UDP/TCP console UI driver,cons,))
$(eval $(call BuildPlugin,debug_cmd,Debug commands,debug_cmd,))
$(eval $(call BuildPlugin,dtls_srtp,DTLS-SRTP end-to-end encryption,dtls_srtp,))
$(eval $(call BuildPlugin,dtmfio,DTMF input/output,dtmfio,))
$(eval $(call BuildPlugin,evdev,Linux input driver,evdev,))
$(eval $(call BuildPlugin,fakevideo,Fake video input/output driver,fakevideo,))
$(eval $(call BuildPlugin,g711,G.711 audio codec,g711,))
$(eval $(call BuildPlugin,g722,G.722 audio codec,g722,+libspandsp))
$(eval $(call BuildPlugin,g726,G.726 audio codec,g726,+libspandsp))
$(eval $(call BuildPlugin,httpd,HTTP webserver UI-module,httpd,))
$(eval $(call BuildPlugin,mwi,Message Waiting Indication,mwi,))
$(eval $(call BuildPlugin,natbd,NAT Behavior Discovery Module,natbd,))
$(eval $(call BuildPlugin,natpmp,NAT Port Mapping Protocol module,natpmp,))
$(eval $(call BuildPlugin,opus,OPUS Interactive audio codec,opus,+libopus))
$(eval $(call BuildPlugin,oss,OSS audio driver,oss,))
$(eval $(call BuildPlugin,plc,Packet Loss Concealment,plc,+libspandsp))
$(eval $(call BuildPlugin,portaudio,Portaudio audio driver,portaudio,+portaudio))
$(eval $(call BuildPlugin,presence,Presence module,presence,))
$(eval $(call BuildPlugin,pulse,Pulseaudio audio driver,pulse,+pulseaudio-daemon))
$(eval $(call BuildPlugin,selfview,Video selfview module,selfview,))
$(eval $(call BuildPlugin,sndfile,Audio dumper using libsndfile,sndfile,+libsndfile))
$(eval $(call BuildPlugin,speex,Speex audio codec,speex,+libspeex))
$(eval $(call BuildPlugin,speex_aec,Speex Acoustic Echo Canceller,speex_aec,+libspeex +libspeexdsp))
$(eval $(call BuildPlugin,speex_pp,Speex preprocessor,speex_pp,+libspeex +libspeexdsp))
$(eval $(call BuildPlugin,srtp,Secure RTP module using libre,srtp,))
$(eval $(call BuildPlugin,stdio,Standard input/output UI driver,stdio,))
$(eval $(call BuildPlugin,uuid,UUID generator and loader,uuid,))
$(eval $(call BuildPlugin,v4l,Video4Linux video source,v4l,+libv4l))
$(eval $(call BuildPlugin,v4l2,Video4Linux2 video source,v4l2,+libv4l))
$(eval $(call BuildPlugin,v4l2_codec,Video4Linux2 video codec module,v4l2_codec,))
$(eval $(call BuildPlugin,vidbridge,Video bridge module,vidbridge,))
$(eval $(call BuildPlugin,vidloop,Video-loop test module,vidloop,))
$(eval $(call BuildPlugin,vumeter,Display audio levels in console,vumeter,))
