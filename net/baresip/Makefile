#
# Copyright (C) 2010-2017 OpenWrt.org
# Copyright (C) 2010 Alfred E. Heggestad
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=baresip
PKG_VERSION:=3.16.0
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/baresip/baresip/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=95338c4e4dd6931c94d425d69089b66d32c173e48cb992344e856ead7ba9393b

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=docs/COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_BUILD_DEPENDS:=glib2/host
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/baresip/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  URL:=https://github.com/baresip/baresip
endef

define Package/baresip
$(call Package/baresip/Default)
  TITLE:=Portable and modular SIP User-Agent with A/V support
  DEPENDS:=+libre
  USERID:=$(PKG_NAME)=374:$(PKG_NAME)=374
  MENU:=1
  FILE_MODES:= \
	  /etc/baresip:baresip:baresip:0750 \
	  /etc/baresip/accounts:baresip:baresip:0640 \
	  /etc/baresip/config:baresip:baresip:0640 \
	  /etc/baresip/contacts:baresip:baresip:0640
endef

baresip-mods:= \
	aac \
	alsa \
	aubridge \
	auconv \
	aufile \
	auresamp \
	ausine \
	avcodec \
	avfilter \
	avformat \
	cons \
	ctrl_dbus \
	ctrl_tcp \
	debug_cmd \
	dtls_srtp \
	ebuacip \
	echo \
	evdev \
	fakevideo \
	g711 \
	g722 \
	g726 \
	gst \
	httpd \
	httpreq \
	in_band_dtmf \
	l16 \
	mixausrc \
	mixminus \
	mqtt \
	mwi \
	natpmp \
	netroam \
	opus \
	opus_multistream \
	pcp \
	plc \
	portaudio \
	presence \
	pulse \
	rtcpsummary \
	selfview \
	serreg \
	snapshot \
	sndfile \
	srtp \
	stdio \
	swscale \
	syslog \
	uuid \
	v4l2 \
	vidbridge \
	vidinfo \
	vp8 \
	vp9 \
	vumeter

empty:=
space:= $(empty) $(empty)

MODULES:=stun;turn;menu;ice;contact;account
MODULES+=$(foreach m,$(baresip-mods),$(if $(CONFIG_PACKAGE_baresip-mod-$(m)),$(m)))
MODULES:=$(strip $(MODULES))
MODULES:=$(subst $(space),;,$(MODULES))

CMAKE_OPTIONS += -DMODULES="$(MODULES)" \
		-DGST_INCLUDE_DIRS="$(STAGING_DIR)/usr/include/gstreamer-1.0" \
		-DGL_INCLUDE_DIRS="$(STAGING_DIR)/usr/include/glib-2.0"

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr
	$(CP) $(PKG_INSTALL_DIR)/usr/* $(1)/usr
endef

define Package/baresip/install
	$(INSTALL_DIR) $(1)/usr/bin \
			$(1)/usr/lib/baresip/modules \
			$(1)/usr/share/baresip \
			$(1)/etc/baresip \
			$(1)/etc/uci-defaults \
			$(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/baresip $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/libbaresip.so* $(1)/usr/lib
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/lib/baresip/modules/{account,contact,ice,menu,stun,turn}.so \
		$(1)/usr/lib/baresip/modules
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/baresip/* $(1)/usr/share/baresip
	$(SED) '/^#/!s/^/#/' $(PKG_BUILD_DIR)/docs/examples/accounts
	$(SED) '/^#module_path/s|^#||;s|/local||' $(PKG_BUILD_DIR)/docs/examples/config
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/docs/examples/{accounts,config,contacts} $(1)/etc/baresip
	$(INSTALL_DATA) ./files/baresip.defaults $(1)/etc/uci-defaults/90-baresip
	$(INSTALL_BIN) ./files/baresip.init $(1)/etc/init.d/baresip
endef

define Package/baresip/conffiles
/etc/baresip/config
/etc/baresip/contacts
endef

##################
# bareSIP modules
# 1. Name
# 2. Title
# 3. Dependencies
##################

define BuildPlugin
  define Package/baresip-mod-$(1)
    $$(call Package/baresip/Default)
    TITLE:=$(2)
    DEPENDS:=baresip $(patsubst +%,+PACKAGE_$(PKG_NAME)-mod-$(1):%,$(3))
  endef
  define Package/baresip-mod-$(1)/install
	$(INSTALL_DIR) $$(1)/usr/lib/baresip/modules
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/baresip/modules/$(1).so \
			$$(1)/usr/lib/baresip/modules
  endef
  $$(eval $$(call BuildPackage,baresip-mod-$(1)))
endef

$(eval $(call BuildPackage,baresip))

$(eval $(call BuildPlugin,aac,MPEG-4 AAC Audio Codec,+fdk-aac))
$(eval $(call BuildPlugin,alsa,ALSA audio driver,+alsa-lib))
$(eval $(call BuildPlugin,aubridge,Audio bridge module,))
$(eval $(call BuildPlugin,aufile,Audio module for using a WAV-file as audio input,))
$(eval $(call BuildPlugin,ausine,Sine Audio Source,))
$(eval $(call BuildPlugin,auconv,Audio format conversion,))
$(eval $(call BuildPlugin,auresamp,Audio resampler,))
$(eval $(call BuildPlugin,avcodec,Video codec using FFmpeg,+libffmpeg-full))
$(eval $(call BuildPlugin,avfilter,Video filter using FFmpeg,+libffmpeg-full))
$(eval $(call BuildPlugin,avformat,Video source using FFmpeg,+baresip-mod-avcodec))
$(eval $(call BuildPlugin,cons,UDP/TCP console UI driver,))
$(eval $(call BuildPlugin,ctrl_dbus,DBus control interface,+glib2))
$(eval $(call BuildPlugin,ctrl_tcp,TCP control interface,))
$(eval $(call BuildPlugin,debug_cmd,Debug commands,))
$(eval $(call BuildPlugin,dtls_srtp,DTLS-SRTP end-to-end encryption,))
$(eval $(call BuildPlugin,ebuacip,EBU ACIP [Audio Contribution over IP] Profile,))
$(eval $(call BuildPlugin,echo,Echo server module,))
$(eval $(call BuildPlugin,evdev,Linux input driver,))
$(eval $(call BuildPlugin,fakevideo,Fake video input/output driver,))
$(eval $(call BuildPlugin,g711,G.711 audio codec,))
$(eval $(call BuildPlugin,g722,G.722 audio codec,+libspandsp))
$(eval $(call BuildPlugin,g726,G.726 audio codec,+libspandsp))
$(eval $(call BuildPlugin,gst,Gstreamer 1.0 playbin pipeline,@AUDIO_SUPPORT +glib2 +libgstreamer1))
$(eval $(call BuildPlugin,httpd,HTTP webserver UI-module,))
$(eval $(call BuildPlugin,httpreq,HTTP request module,))
$(eval $(call BuildPlugin,l16,16-bit linear codec,))
$(eval $(call BuildPlugin,mixausrc,Mixes another audio source into audio stream,))
$(eval $(call BuildPlugin,mixminus,Mixes N-1 audio streams for conferencing,))
$(eval $(call BuildPlugin,mqtt,Message Queue Telemetry Transport [MQTT] client,+libmosquitto))
$(eval $(call BuildPlugin,mwi,Message Waiting Indication,))
$(eval $(call BuildPlugin,natpmp,NAT Port Mapping Protocol module,))
$(eval $(call BuildPlugin,netroam,Network roaming module,))
$(eval $(call BuildPlugin,opus,OPUS Interactive audio codec,+libopus))
$(eval $(call BuildPlugin,opus_multistream,Opus Multistream Audio Codec,+libopus))
$(eval $(call BuildPlugin,plc,Packet Loss Concealment,+libspandsp))
$(eval $(call BuildPlugin,pcp,Port Control Protocol for Media NAT-traversal,))
$(eval $(call BuildPlugin,portaudio,Portaudio audio driver,+portaudio))
$(eval $(call BuildPlugin,presence,Presence module,))
$(eval $(call BuildPlugin,pulse,Pulseaudio audio driver,PACKAGE_$(PKG_NAME)-mod-pulse:pulseaudio))
$(eval $(call BuildPlugin,rtcpsummary,RTCP summary module,))
$(eval $(call BuildPlugin,selfview,Video selfview module,))
$(eval $(call BuildPlugin,serreg,Serial registration mode,))
$(eval $(call BuildPlugin,snapshot,Snapshot video module,+libpng))
$(eval $(call BuildPlugin,sndfile,Audio dumper using libsndfile,+libsndfile))
$(eval $(call BuildPlugin,srtp,Secure RTP module using libre,))
$(eval $(call BuildPlugin,stdio,Standard input/output UI driver,))
$(eval $(call BuildPlugin,syslog,Syslog module,))
$(eval $(call BuildPlugin,swscale,Video filter for scaling by FFmpeg,+libffmpeg-full))
$(eval $(call BuildPlugin,uuid,UUID generator and loader,))
$(eval $(call BuildPlugin,v4l2,Video4Linux2 video source,+libv4l))
$(eval $(call BuildPlugin,vidbridge,Video bridge module,))
$(eval $(call BuildPlugin,vidinfo,Video-info filter,))
$(eval $(call BuildPlugin,vumeter,Display audio levels in console,))
$(eval $(call BuildPlugin,vp8,VP8 video codec,+libvpx))
$(eval $(call BuildPlugin,vp9,VP9 video codec,+libvpx))
