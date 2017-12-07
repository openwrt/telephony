#
# Copyright (C) 2017 Jiri Slachta <jiri@slachta.eu>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk15
PKG_VERSION:=15.1.3
PKG_RELEASE:=2

PKG_SOURCE:=asterisk-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://downloads.asterisk.org/pub/telephony/asterisk/releases
PKG_HASH:=cfd7c49e42878b4f7de5af7baa9f43d39476f70d1848e5f158409400c31a0c3a

PKG_BUILD_DIR:=$(BUILD_DIR)/asterisk-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=libxml2/host

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING LICENSE
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

MENUSELECT_CATEGORIES:= \
	MENUSELECT_ADDONS \
	MENUSELECT_APPS \
	MENUSELECT_BRIDGES \
	MENUSELECT_CDR \
	MENUSELECT_CEL \
	MENUSELECT_CHANNELS \
	MENUSELECT_CODECS \
	MENUSELECT_FORMATS \
	MENUSELECT_FUNCS \
	MENUSELECT_PBX \
	MENUSELECT_RES \
	MENUSELECT_UTILS \
	MENUSELECT_AGIS

AST_ENABLE:=

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/asterisk15/install/module
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/asterisk/modules/*$(2).so* $(1)/usr/lib/asterisk/modules/
endef

define Package/asterisk15/install/conffile
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(CP) $(PKG_INSTALL_DIR)/etc/asterisk/$(2) $(1)/etc/asterisk/
endef

define Package/asterisk15/install/lib
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(2).so* $(1)/usr/lib/
endef

define Package/asterisk15/install/sbin
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/$(2) $(1)/usr/sbin/
endef

define Package/asterisk15/install/sounds
	$(INSTALL_DIR) $(1)/usr/share/asterisk/sounds/
	$(CP) $(PKG_INSTALL_DIR)/usr/share/asterisk/sounds/en/$(2) $(1)/usr/share/asterisk/sounds/
endef

define Package/asterisk15/install/util-conffile
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/asterisk/$(2) $(1)/etc
endef

define Package/$(PKG_NAME)/config
	source "$(SOURCE)/Config.in"
endef

define BuildAsterisk15Module
  define Package/asterisk15-$(1)
  $$(call Package/asterisk15/Default)
    TITLE:=$(2) support
    DEPENDS:= asterisk15 $(patsubst +%,+PACKAGE_asterisk15-$(1):%,$(4))
    ifneq ($$(CONFIG_PACKAGE_asterisk15-$(1)),)
    AST_ENABLE+=$(6)
    endif
  endef

  define Package/asterisk15-$(1)/conffiles
$(subst $(space),$(newline),$(foreach c,$(5),/etc/asterisk/$(c)))
  endef

  define Package/asterisk15-$(1)/description
This package provides support for '$(3)' in Asterisk.
  endef

  define Package/asterisk15-$(1)/install
$(foreach c,$(5),$(call Package/asterisk15/install/conffile,$$(1),$(c));)
$(foreach m,$(6),$(call Package/asterisk15/install/module,$$(1),$(m));)
$(foreach s,$(7),$(call Package/asterisk15/install/sounds,$$(1),$(s));)
$(foreach b,$(8),$(call Package/asterisk15/install/sbin,$$(1),$(b));)
  endef

  $$(eval $$(call BuildPackage,asterisk15-$(1)))
endef

define BuildAsterisk15Util
  define Package/asterisk15-util-$(1)
  $$(call Package/asterisk15/Default)
    TITLE:=$(1) utility
    DEPENDS:=asterisk15 $(patsubst +%,+PACKAGE_asterisk15-util-$(1):%,$(3))
    ifneq ($$(CONFIG_PACKAGE_asterisk15-util-$(1)),)
    AST_ENABLE+=$(1)
    endif
  endef

  define Package/asterisk15-util-$(1)/conffiles
$(subst $(space),$(newline),$(foreach c,$(4),/etc/$(c)))
  endef

  define Package/asterisk15-util-$(1)/description
$(2)
  endef

  define Package/asterisk15-util-$(1)/install
$(call Package/asterisk15/install/sbin,$$(1),$(1))
$(foreach c,$(4),$(call Package/asterisk15/install/util-conffile,$$(1),$(c));)
  endef

  $$(eval $$(call BuildPackage,asterisk15-util-$(1)))
endef

define Package/asterisk15/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=http://www.asterisk.org/
endef

define Package/asterisk15/Default/description
 Asterisk is a complete PBX in software. It provides all of the features
 you would expect from a PBX and more. Asterisk does voice over IP in three
 protocols, and can interoperate with almost all standards-based telephony
 equipment using relatively inexpensive hardware.
endef

define Package/asterisk15
$(call Package/asterisk15/Default)
  TITLE:=Complete open source PBX, v$(PKG_VERSION)
  MENU:=1
  DEPENDS:=+jansson +libcap +libedit +libncurses +libopenssl +libpopt +libsqlite3 +libstdcpp +libuuid +libxml2 +libxslt +zlib
endef

define Package/asterisk15/description
$(call Package/asterisk15/Default/description)
endef

define Package/asterisk15/conffiles
/etc/asterisk/asterisk.conf
/etc/asterisk/acl.conf
/etc/asterisk/cel.conf
/etc/asterisk/ccss.conf
/etc/asterisk/cli.conf
/etc/asterisk/cli_permissions.conf
/etc/asterisk/codecs.conf
/etc/asterisk/dnsmgr.conf
/etc/asterisk/dsp.conf
/etc/asterisk/extconfig.conf
/etc/asterisk/extensions.conf
/etc/asterisk/features.conf
/etc/asterisk/http.conf
/etc/asterisk/indications.conf
/etc/asterisk/logger.conf
/etc/asterisk/manager.conf
/etc/asterisk/modules.conf
/etc/asterisk/res_config_sqlite3.conf
/etc/asterisk/stasis.conf
/etc/asterisk/udptl.conf
/etc/asterisk/users.conf
/etc/default/asterisk
/etc/init.d/asterisk
endef

AST_CFG_FILES:= \
	asterisk.conf acl.conf cel.conf ccss.conf cli.conf \
	cli_permissions.conf codecs.conf dnsmgr.conf dsp.conf extconfig.conf \
	extensions.conf features.conf http.conf indications.conf \
	logger.conf manager.conf modules.conf stasis.conf udptl.conf \
	users.conf res_config_sqlite3.conf

AST_EMB_MODULES:=\
	app_dial app_echo app_macro app_playback \
	func_callerid func_logic func_strings func_timeout \
	pbx_config res_crypto

define Package/asterisk15/install
$(call Package/asterisk15/install/lib,$(1),libasteriskssl)
$(call Package/asterisk15/install/sbin,$(1),asterisk)
$(call Package/asterisk15/install/sbin,$(1),safe_asterisk)
$(call Package/asterisk15/install/sbin,$(1),astgenkey)
$(foreach m,$(AST_CFG_FILES),$(call Package/asterisk15/install/conffile,$(1),$(m));)
$(foreach m,$(AST_EMB_MODULES),$(call Package/asterisk15/install/module,$(1),$(m));)
	$(INSTALL_DIR) $(1)/usr/share/asterisk/sounds/
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_DATA) ./files/asterisk.default $(1)/etc/default/asterisk
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/asterisk.init $(1)/etc/init.d/asterisk
endef

define Package/asterisk15-sounds
$(call Package/asterisk15/Default)
  TITLE:=Sounds support
  DEPENDS:=asterisk15
endef

define Package/asterisk15-sounds/description
This package provides the sound-files for Asterisk-15.
endef

define Package/asterisk15-sounds/install
	$(INSTALL_DIR) $(1)/usr/share/asterisk/sounds/
	$(CP) $(PKG_INSTALL_DIR)/usr/share/asterisk/sounds/en/* $(1)/usr/share/asterisk/sounds/
	rm -f $(1)/usr/share/asterisk/sounds/vm-*
endef

ifneq ($(CONFIG_PACKAGE_asterisk15-chan-dahdi),)
  CONFIGURE_ARGS+= \
	--with-dahdi="$(STAGING_DIR)/usr" \
	--with-pri="$(STAGING_DIR)/usr" \
	--with-tonezone="$(STAGING_DIR)/usr"
else
  CONFIGURE_ARGS+= \
	--without-dahdi \
	--without-pri \
	--without-tonezone
endif

# Pass CPPFLAGS in the CFLAGS as otherwise the build system will
# ignore them.
TARGET_CFLAGS+=$(TARGET_CPPFLAGS)

CONFIGURE_ARGS+= \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-chan-alsa),--with-asound="$(STAGING_DIR)/usr",--without-asound) \
	--without-execinfo \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-chan-mobile),--with-bluetooth="$(STAGING_DIR)/usr",--without-bluetooth) \
	--with-cap="$(STAGING_DIR)/usr" \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-curl),--with-libcurl="$(STAGING_DIR)/usr") \
	--without-curses \
	--with-gsm=internal \
	--without-gtk2 \
	--with-ilbc=internal \
	--without-isdnnet \
	--without-misdn \
	--without-nbs \
	--without-pjproject-bundled \
	--with-libedit="$(STAGING_DIR)/usr" \
	--with-libxml2 \
	--with-ncurses="$(STAGING_DIR)/usr" \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-res-snmp),--with-netsnmp="$(STAGING_DIR)/usr",--without-netsnmp) \
	--without-newt \
	--without-osptk \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-pbx-lua),--with-lua="$(STAGING_DIR)/usr",--without-lua) \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-pgsql),--with-postgres="$(STAGING_DIR)/usr",--without-postgres) \
	--with-popt="$(STAGING_DIR)/usr" \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-chan-console),--with-portaudio="$(STAGING_DIR)/usr",--without-portaudio) \
	--without-pwlib \
	--without-radius \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-res-fax-spandsp),--with-spandsp="$(STAGING_DIR)/usr",--without-spandsp) \
	--without-sdl \
	--without-sqlite \
	--with-sqlite3="$(STAGING_DIR)/usr" \
	--without-suppserv \
	--without-tds \
	--without-termcap \
	--without-tinfo \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-res-resolver-unbound),--with-unbound="$(STAGING_DIR)/usr",--without-unbound) \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-format-ogg-vorbis),--with-vorbis="$(STAGING_DIR)/usr",--without-vorbis) \
	--without-vpb \
	--with-z="$(STAGING_DIR)/usr" \
	--with-sounds-cache="$(DL_DIR)" \
	--enable-xmldoc

ifeq ($(CONFIG_PACKAGE_$(PKG_NAME)-codec-speex)$(CONFIG_PACKAGE_$(PKG_NAME)-format-ogg-speex)$(CONFIG_PACKAGE_$(PKG_NAME)-func-speex),)
CONFIGURE_ARGS+= \
	--without-speex
else
CONFIGURE_ARGS+= \
	--with-speex="$(STAGING_DIR)/usr"
endif

ifeq ($(CONFIG_PACKAGE_$(PKG_NAME)-codec-speex)$(CONFIG_PACKAGE_$(PKG_NAME)-func-speex),)
CONFIGURE_ARGS+= \
	--without-speexdsp
else
CONFIGURE_ARGS+= \
	--with-speexdsp="$(STAGING_DIR)/usr"
endif

ifeq ($(CONFIG_PACKAGE_$(PKG_NAME)-format-ogg-speex)$(CONFIG_PACKAGE_$(PKG_NAME)-format-ogg-vorbis),)
CONFIGURE_ARGS+= \
	--without-ogg
else
CONFIGURE_ARGS+= \
	--with-ogg="$(STAGING_DIR)/usr"
endif

ifeq ($(CONFIG_PACKAGE_$(PKG_NAME)-res-pjproject)$(CONFIG_PACKAGE_$(PKG_NAME)-res-srtp),)
CONFIGURE_ARGS+= \
	--without-srtp
else
CONFIGURE_ARGS+= \
	--with-srtp="$(STAGING_DIR)/usr"
endif

ifeq ($(CONFIG_PACKAGE_$(PKG_NAME)-pjsip)$(CONFIG_PACKAGE_$(PKG_NAME)-res-pjproject)$(CONFIG_PACKAGE_$(PKG_NAME)-res-rtp-asterisk)$(CONFIG_PACKAGE_$(PKG_NAME)-res-sdp-translator-pjmedia),)
CONFIGURE_ARGS+= \
	--without-pjproject
else
CONFIGURE_ARGS+= \
	--with-pjproject="$(STAGING_DIR)/usr"
endif

# res-calendar-ews requires both neon and neon29 detection
ifeq ($(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-caldav)$(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-ews)$(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-exchange)$(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-icalendar),)
CONFIGURE_ARGS+= \
	--without-neon
endif

ifeq ($(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-caldav)$(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-exchange)$(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-icalendar),)
CONFIGURE_ARGS+= \
	--without-ical
else
CONFIGURE_ARGS+= \
	--with-ical="$(STAGING_DIR)/usr"
endif

ifeq ($(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-ews),)
CONFIGURE_ARGS+= \
	--without-neon29
endif

ifeq ($(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-exchange)$(CONFIG_PACKAGE_$(PKG_NAME)-res-xmpp),)
CONFIGURE_ARGS+= \
	--without-iksemel
else
CONFIGURE_ARGS+= \
	--with-iksemel="$(STAGING_DIR)/usr"
endif

CONFIGURE_VARS += \
	ac_cv_path_ac_pt_CONFIG_LIBXML2=$(STAGING_DIR)/host/bin/xml2-config

ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-caldav)$(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-ews)$(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-exchange)$(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-icalendar),)
CONFIGURE_VARS += \
	ac_cv_path_CONFIG_NEON=$(STAGING_DIR)/usr/bin/neon-config
endif

ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-res-calendar-ews),)
CONFIGURE_VARS += \
	ac_cv_path_CONFIG_NEON29=$(STAGING_DIR)/usr/bin/neon-config
endif

MAKE_FLAGS+= \
	ASTDATADIR="/usr/share/asterisk" \
	DESTDIR="$(PKG_INSTALL_DIR)"

# show full gcc arguments instead of [CC] and [LD]
MAKE_FLAGS+= \
	NOISY_BUILD="yes"

# don't let asterisk mess with build flags
MAKE_FLAGS+= \
	AST_FORTIFY_SOURCE="" \
	DEBUG="" \
	OPTIMIZE=""

AST_MENUSELECT_OPTS = \
	--without-newt \
	--without-curses \
	--with-libxml2="$(STAGING_DIR_HOSTPKG)/usr"

define Build/Configure
	cd $(PKG_BUILD_DIR); \
		./bootstrap.sh
	$(call Build/Configure/Default)
	cd $(PKG_BUILD_DIR)/menuselect; \
		./bootstrap.sh; \
		CC="$(HOSTCC)" \
		CFLAGS="$(HOST_CFLAGS) -I$(STAGING_DIR_HOSTPKG)/include/libxml2" \
		CONFIG_SITE= \
		LDFLAGS="$(HOST_LDFLAGS) -Wl,-rpath,$(STAGING_DIR_HOSTPKG)/lib" \
		ac_cv_path_ac_pt_CONFIG_LIBXML2=$(STAGING_DIR_HOSTPKG)/bin/xml2-config \
		./configure \
		$(HOST_CONFIGURE_ARGS) \
		$(AST_MENUSELECT_OPTS)
endef

define Build/Compile
	CC="$(HOSTCC)" \
	CFLAGS="$(HOST_CFLAGS) -I$(STAGING_DIR_HOSTPKG)/include/libxml2" \
	LDFLAGS="$(HOST_LDFLAGS) -Wl,-rpath,$(STAGING_DIR_HOSTPKG)/lib" \
	$(MAKE) -C "$(PKG_BUILD_DIR)/menuselect"
	$(MAKE) -C "$(PKG_BUILD_DIR)" menuselect-tree
	cd "$(PKG_BUILD_DIR)" && MENUSELECT_ARGS= && \
		for cat in $(MENUSELECT_CATEGORIES); do \
			MENUSELECT_ARGS="$$$$MENUSELECT_ARGS --disable-category $$$$cat"; \
		done; \
		./menuselect/menuselect \
			$$$$MENUSELECT_ARGS \
			menuselect.makeopts
	cd "$(PKG_BUILD_DIR)" && MENUSELECT_ARGS= && \
		for item in $(AST_EMB_MODULES) $$(AST_ENABLE); do \
			MENUSELECT_ARGS="$$$$MENUSELECT_ARGS --enable $$$$item"; \
		done; \
		./menuselect/menuselect \
			$$$$MENUSELECT_ARGS \
			menuselect.makeopts
	cd "$(PKG_BUILD_DIR)" && \
		./menuselect/menuselect \
			--disable BUILD_NATIVE \
			$(if $(CONFIG_ASTERISK15_LOW_MEMORY),--enable LOW_MEMORY) \
			menuselect.makeopts
	# Hack:
	# When changing anything in MENUSELECT_CFLAGS the file ".lastclean"
	# gets deleted. E.g. when compiling on x86 for x86 "--disable
	# BUILD_NATIVE" changes MENUSELECT_CFLAGS and the file gets removed.
	# But that will result in a rebuild attempt of menuselect which will
	# likely fail. Prevent that by recreating ".lastclean".
	$(CP) "$(PKG_BUILD_DIR)/.cleancount" "$(PKG_BUILD_DIR)/.lastclean"
	$(call Build/Compile/Default,all install samples)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/asterisk-15/include/asterisk/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/asterisk/*.h $(1)/usr/include/asterisk-15/include/asterisk/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/asterisk.h $(1)/usr/include/asterisk-15/include/
endef

$(eval $(call BuildPackage,asterisk15))
$(eval $(call BuildPackage,asterisk15-sounds))

################################
# AST modules
# Params:
# 1 - Package subname
# 2 - Package title
# 3 - Module description
# 4 - Module dependencies
# 5 - conf files
# 6 - module files
# 7 - sound files
# 8 - binary files
################################
#$(eval $(call BuildAsterisk15Module,subname,title,module description,module dependencies,conf files,module files,sound files,binary files))

$(eval $(call BuildAsterisk15Module,app-adsiprog,ADSI programming,program Asterisk ADSI scripts into phone,+$(PKG_NAME)-res-adsi,adsi.conf asterisk.adsi telcordia-1.adsi,app_adsiprog,,))
$(eval $(call BuildAsterisk15Module,app-agent-pool,Call center agent pool,call center agent pool,,agents.conf,app_agent_pool,,))
$(eval $(call BuildAsterisk15Module,app-alarmreceiver,Alarm receiver,Central Station Alarm receiver for Ademco Contact ID,,,app_alarmreceiver,,))
$(eval $(call BuildAsterisk15Module,app-amd,Answering machine detection,answering machine detection,,amd.conf,app_amd,,))
$(eval $(call BuildAsterisk15Module,app-authenticate,Authenticate commands,Execute arbitrary authenticate commands,,,app_authenticate,,))
$(eval $(call BuildAsterisk15Module,app-bridgeaddchan,Bridge add channel,place a channel into an existing bridge,,,app_bridgeaddchan,,))
$(eval $(call BuildAsterisk15Module,app-bridgewait,Holding bridge,place a channel into a holding bridge,+$(PKG_NAME)-bridge-holding,,app_bridgewait,,))
$(eval $(call BuildAsterisk15Module,app-celgenuserevent,User-defined CEL event,generate user-defined CEL event,,,app_celgenuserevent,,))
$(eval $(call BuildAsterisk15Module,app-chanisavail,Channel availability check,support for checking if a channel is available,,,app_chanisavail,,))
$(eval $(call BuildAsterisk15Module,app-channelredirect,Redirect a channel,ChannelRedirect application,,,app_channelredirect,,))
$(eval $(call BuildAsterisk15Module,app-chanspy,Channel listen in,support for listening in on any channel,,,app_chanspy,,))
$(eval $(call BuildAsterisk15Module,app-confbridge,ConfBridge,Software bridge for multi-party audio conferencing,+asterisk15-bridge-builtin-features +asterisk15-bridge-simple +asterisk15-bridge-softmix,confbridge.conf,app_confbridge,,))
$(eval $(call BuildAsterisk15Module,app-controlplayback,Control playback,trivial application to control playback of a sound file,,,app_controlplayback,,))
$(eval $(call BuildAsterisk15Module,app-dahdiras,Execute an ISDN RAS,support for executing an ISDN RAS using DAHDI,+asterisk15-chan-dahdi,,app_dahdiras,,))
$(eval $(call BuildAsterisk15Module,app-dictate,Virtual dictation machine,virtual dictation machine application,,,app_dictate,,))
$(eval $(call BuildAsterisk15Module,app-directed_pickup,Directed call pickup,support for directed call pickup,,,app_directed_pickup,,))
$(eval $(call BuildAsterisk15Module,app-directory,Extension directory,provide a directory of extensions,,,app_directory,,))
$(eval $(call BuildAsterisk15Module,app-disa,Direct Inward System Access,Direct Inward System Access,,,app_disa,,))
$(eval $(call BuildAsterisk15Module,app-dumpchan,Dump info about channel,application to dump channel variables,,,app_dumpchan,,))
$(eval $(call BuildAsterisk15Module,app-exec,Exec application,support for application execution,,,app_exec,,))
$(eval $(call BuildAsterisk15Module,app-externalivr,External IVR interface,external IVR application interface,,,app_externalivr,,))
$(eval $(call BuildAsterisk15Module,app-festival,Simple festival interface,connect to festival,,festival.conf,app_festival,,))
$(eval $(call BuildAsterisk15Module,app-flash,Flash channel,flash a DAHDI trunk,+$(PKG_NAME)-chan-dahdi,,app_flash,,))
$(eval $(call BuildAsterisk15Module,app-followme,Find-me/follow-me,find-me/follow-me application,,followme.conf,app_followme,,))
$(eval $(call BuildAsterisk15Module,app-getcpeid,Get ADSI CPE ID,get ADSI CPE ID,,,app_getcpeid,,))
$(eval $(call BuildAsterisk15Module,app-ices,Encode and stream,stream to an icecast server via ICES,,,app_ices,,))
$(eval $(call BuildAsterisk15Module,app-image,Image transmission,transmit an image,,,app_image,,))
$(eval $(call BuildAsterisk15Module,app-ivrdemo,IVR demo,IVR demo application,,,app_ivrdemo,,))
$(eval $(call BuildAsterisk15Module,app-milliwatt,Digital milliwatt [mu-law] test app,digital milliwatt test,,,app_milliwatt,,))
$(eval $(call BuildAsterisk15Module,app-minivm,Minimal voicemail system,a voicemail system in small building blocks working together based on the Comedian Mail voicemail,,extensions_minivm.conf minivm.conf,app_minivm,,))
$(eval $(call BuildAsterisk15Module,app-mixmonitor,Record a call and mix the audio,record a call and mix the audio during the recording,,,app_mixmonitor,,))
$(eval $(call BuildAsterisk15Module,app-morsecode,Morse code,Morsecode application,,,app_morsecode,,))
$(eval $(call BuildAsterisk15Module,app-mp3,Silly MP3,silly application to play an MP3 file [uses mpg123],+mpg123,,app_mp3,,))
$(eval $(call BuildAsterisk15Module,app-originate,Originate a call,originating an outbound call and connecting it to a specified extension or application,,,app_originate,,))
$(eval $(call BuildAsterisk15Module,app-page,Page multiple phones,paging application,+$(PKG_NAME)-app-confbridge,,app_page,,))
$(eval $(call BuildAsterisk15Module,app-playtones,Playtones application,play a tone list,,,app_playtones,,))
$(eval $(call BuildAsterisk15Module,app-privacy,Require phone number,require phone number to be entered if no CallerID sent,,,app_privacy,,))
$(eval $(call BuildAsterisk15Module,app-queue,True Call Queueing,support for ACD,,queues.conf queuerules.conf,app_queue,,))
$(eval $(call BuildAsterisk15Module,app-read,Variable read,a trivial application to read a variable,,,app_read,,))
$(eval $(call BuildAsterisk15Module,app-readexten,Extension to variable,a trivial application to read an extension into a variable,,,app_readexten,,))
$(eval $(call BuildAsterisk15Module,app-record,Record sound file,to record a sound file,,,app_record,,))
$(eval $(call BuildAsterisk15Module,app-saycounted,Decline words,applications to decline words according to current language,,,app_saycounted,,))
$(eval $(call BuildAsterisk15Module,app-sayunixtime,Say Unix time,an application to say Unix time,,,app_sayunixtime,,))
$(eval $(call BuildAsterisk15Module,app-senddtmf,Send DTMF digits,Sends arbitrary DTMF digits,,,app_senddtmf,,))
$(eval $(call BuildAsterisk15Module,app-sendtext,Send text,transmit a text message,,,app_sendtext,,))
$(eval $(call BuildAsterisk15Module,app-skel,Skeleton [sample],skeleton for development of an Asterisk application,,app_skel.conf,app_skel,,))
$(eval $(call BuildAsterisk15Module,app-sms,SMS,SMS support (ETSI ES 201 912 protocol 1),+libpopt +libstdcpp,,app_sms,,))
$(eval $(call BuildAsterisk15Module,app-softhangup,Hang up requested channel,SoftHangup application,,,app_softhangup,,))
$(eval $(call BuildAsterisk15Module,app-speech,Dialplan Speech,Dialplan Speech Applications,+asterisk15-res-speech,,app_speech_utils,,))
$(eval $(call BuildAsterisk15Module,app-stack,Stack applications,Stack applications Gosub Return etc.,+asterisk15-res-agi,,app_stack,,))
$(eval $(call BuildAsterisk15Module,app-stasis,Stasis dialplan,Stasis dialplan application,+$(PKG_NAME)-res-stasis,,app_stasis,,))
$(eval $(call BuildAsterisk15Module,app-statsd,statsd dialplan,statsd dialplan,+$(PKG_NAME)-res_statsd,,app_statsd,,))
$(eval $(call BuildAsterisk15Module,app-stream-echo,Stream echo,stream echo,,,app_stream_echo,,))
$(eval $(call BuildAsterisk15Module,app-system,System exec,support for executing system commands,,,app_system,,))
$(eval $(call BuildAsterisk15Module,app-talkdetect,File playback with audio detect,for file playback with audio detect,,,app_talkdetect,,))
$(eval $(call BuildAsterisk15Module,app-test,Interface test,applications to test connection and produce report in text file,,,app_test,,))
$(eval $(call BuildAsterisk15Module,app-transfer,Transfers caller to other ext,transfer a caller,,,app_transfer,,))
$(eval $(call BuildAsterisk15Module,app-url,Send URL,app to transmit a URL,,,app_url,,))
$(eval $(call BuildAsterisk15Module,app-userevent,Custom user event,UserEvent application -- send manager event,,,app_userevent,,))
$(eval $(call BuildAsterisk15Module,app-verbose,Verbose logging,Verbose logging application,,,app_verbose,,))
$(eval $(call BuildAsterisk15Module,app-waitforring,Wait for first ring,wait for ring application,,,app_waitforring,,))
$(eval $(call BuildAsterisk15Module,app-waitforsilence,Wait for silence/noise,wait for silence,,,app_waitforsilence,,))
$(eval $(call BuildAsterisk15Module,app-waituntil,Sleep,support sleeping until the given epoch,,,app_waituntil,,))
$(eval $(call BuildAsterisk15Module,app-while,While loop,a while loop implementation,,,app_while,,))
$(eval $(call BuildAsterisk15Module,app-zapateller,Block telemarketers,playback the special information tone to get rid of telemarketers,,,app_zapateller,,))
$(eval $(call BuildAsterisk15Module,bridge-builtin-features,Bridging features,built in bridging features,,,bridge_builtin_features,,))
$(eval $(call BuildAsterisk15Module,bridge-builtin-interval-features,Built in bridging interval features,built in bridging interval features,,,bridge_builtin_interval_features,,))
$(eval $(call BuildAsterisk15Module,bridge-holding,Bridging for storing channels in a bridge,bridging technology for storing channels in a bridge,,,bridge_holding,,))
$(eval $(call BuildAsterisk15Module,bridge-native-rtp,Native RTP bridging technology module,native RTP bridging technology module,,,bridge_native_rtp,,))
$(eval $(call BuildAsterisk15Module,bridge-simple,Simple two channel bridging module,simple two channel bridging module,,,bridge_simple,,))
$(eval $(call BuildAsterisk15Module,bridge-softmix,Multi-party software based channel mixing,multi-party software based channel mixing,,,bridge_softmix,,))
$(eval $(call BuildAsterisk15Module,cdr,Provides CDR,Call Detail Record,,cdr.conf cdr_custom.conf cdr_manager.conf cdr_syslog.conf,app_cdr app_forkcdr cdr_custom cdr_manager cdr_syslog func_cdr,,))
$(eval $(call BuildAsterisk15Module,cdr-csv,Provides CDR CSV,Call Detail Record with CSV support,,,cdr_csv,,))
$(eval $(call BuildAsterisk15Module,cdr-sqlite3,Provides CDR SQLITE3,Call Detail Record with SQLITE3 support,libsqlite3,,cdr_sqlite3_custom,,))
$(eval $(call BuildAsterisk15Module,cel-custom,Customizable CSV CEL backend,custom Comma Separated Value CEL records,,cel_custom.conf,cel_custom,,))
$(eval $(call BuildAsterisk15Module,cel-manager,AMI CEL backend,Asterisk channel event records,,,cel_manager,,))
$(eval $(call BuildAsterisk15Module,cel-sqlite3-custom,SQLite3 custom CEL,custom SQLite3 CEL records,,cel_sqlite3_custom.conf,cel_sqlite3_custom,,))
$(eval $(call BuildAsterisk15Module,chan-alsa,ALSA channel,the channel chan_alsa,+alsa-lib,alsa.conf,chan_alsa,,))
$(eval $(call BuildAsterisk15Module,chan-bridge-media,Bridge media channel driver,bridge media channel driver,,,chan_bridge_media,,))
$(eval $(call BuildAsterisk15Module,chan-console,Console channel driver,cross-platform console channel driver,+portaudio,console.conf,chan_console,,))
$(eval $(call BuildAsterisk15Module,chan-dahdi,DAHDI channel,DAHDI channel support,+dahdi-tools-libtonezone +kmod-dahdi +libpri @!aarch64,chan_dahdi.conf,chan_dahdi,,))
$(eval $(call BuildAsterisk15Module,chan-iax2,IAX2 channel,IAX support,+asterisk15-res-timing-timerfd,iax.conf iaxprov.conf,chan_iax2,,))
$(eval $(call BuildAsterisk15Module,chan-mgcp,MGCP,Media Gateway Control Protocol,,mgcp.conf,chan_mgcp,,))
$(eval $(call BuildAsterisk15Module,chan-mobile,Bluetooth channel,Bluetooth mobile device channel driver,+bluez-libs,chan_mobile.conf,chan_mobile,,))
$(eval $(call BuildAsterisk15Module,chan-motif,Jingle channel,Motif Jingle Channel Driver,+asterisk15-res-xmpp,motif.conf,chan_motif,,))
$(eval $(call BuildAsterisk15Module,chan-ooh323,H.323 channel,Objective Systems H.323 channel,,ooh323.conf,chan_ooh323,,))
$(eval $(call BuildAsterisk15Module,chan-oss,OSS channel,the channel chan_oss,,oss.conf,chan_oss,,))
$(eval $(call BuildAsterisk15Module,chan-phone,Linux telephony API,generic Linux telephony interface driver,,phone.conf,chan_phone,,))
$(eval $(call BuildAsterisk15Module,chan-rtp,RTP media channel,RTP [Multicast and Unicast] media channel,,,chan_rtp,,))
$(eval $(call BuildAsterisk15Module,chan-sip,SIP channel,the channel chan_sip,+asterisk15-app-confbridge,sip.conf sip_notify.conf,chan_sip,,))
$(eval $(call BuildAsterisk15Module,chan-skinny,Skinny channel,the channel chan_skinny,,skinny.conf,chan_skinny,,))
$(eval $(call BuildAsterisk15Module,chan-unistim,Unistim channel,channel driver for the UNISTIM (Unified Networks IP Stimulus) protocol,,unistim.conf,chan_unistim,,))
$(eval $(call BuildAsterisk15Module,codec-a-mu,Alaw to ulaw translation,translation between alaw and ulaw codecs,,,codec_a_mu,,))
$(eval $(call BuildAsterisk15Module,codec-adpcm,ADPCM text,ADPCM text ,,,codec_adpcm,,))
$(eval $(call BuildAsterisk15Module,codec-alaw,Signed linear to alaw translation,translation between signed linear and alaw codecs,,,codec_alaw,,))
$(eval $(call BuildAsterisk15Module,codec-dahdi,DAHDI codec,DAHDI native transcoding support,+asterisk15-chan-dahdi,,codec_dahdi,,))
$(eval $(call BuildAsterisk15Module,codec-g722,G.722,a high bit rate 48/56/64Kbps ITU standard codec,,,codec_g722,,))
$(eval $(call BuildAsterisk15Module,codec-g726,Signed linear to G.726 translation,translation between signed linear and ITU G.726-32kbps codecs,,,codec_g726,,))
$(eval $(call BuildAsterisk15Module,codec-gsm,linear to GSM translation,translate between signed linear and GSM,,,codec_gsm,,))
$(eval $(call BuildAsterisk15Module,codec-ilbc,linear to ILBC translation,translate between signed linear and ILBC,,,codec_ilbc,,))
$(eval $(call BuildAsterisk15Module,codec-lpc10,Linear to LPC10 translation,translate between signed linear and LPC10,,,codec_lpc10,,))
$(eval $(call BuildAsterisk15Module,codec-resample,resample sLinear audio,resample sLinear audio,,,codec_resample,,))
$(eval $(call BuildAsterisk15Module,codec-speex,Speex Coder/Decoder,translate between signed linear and Speex,@!SOFT_FLOAT +libspeex +libspeexdsp,,codec_speex,,))
$(eval $(call BuildAsterisk15Module,codec-ulaw,Signed linear to ulaw translation,translation between signed linear and ulaw codecs,,,codec_ulaw,,))
$(eval $(call BuildAsterisk15Module,curl,CURL,CURL support,+libcurl,,func_curl res_config_curl res_curl,,))
$(eval $(call BuildAsterisk15Module,format-g719,G.719,ITU G.719 64kbps-only,,,format_g719,,))
$(eval $(call BuildAsterisk15Module,format-g723,G.723.1,old-style G.723.1 frame/timestamp format,,,format_g723,,))
$(eval $(call BuildAsterisk15Module,format-g726,G.726,support for headerless G.726 16/24/32/40kbps data format,,,format_g726,,))
$(eval $(call BuildAsterisk15Module,format-g729,G.729,support for raw headerless G729 data,,,format_g729,,))
$(eval $(call BuildAsterisk15Module,format-gsm,GSM format,support for GSM format,,,format_gsm,,))
$(eval $(call BuildAsterisk15Module,format-h263,H263 format,support for H264 format,,,format_h263,,))
$(eval $(call BuildAsterisk15Module,format-h264,H264 format,support for H264 format,,,format_h264,,))
$(eval $(call BuildAsterisk15Module,format-ilbc,ILBC format,support for ILBC format,,,format_ilbc,,))
$(eval $(call BuildAsterisk15Module,format-jpeg,JPEG image format,JPEG file format,,,format_jpeg,,))
$(eval $(call BuildAsterisk15Module,format-mp3,MP3 format,support for MP3 format,@BROKEN,,format_mp3,,)) # requires patched mpg123 source
$(eval $(call BuildAsterisk15Module,format-ogg-speex,OGG/Speex audio,OGG/Speex streams,@!SOFT_FLOAT +libogg +libspeex,,format_ogg_speex,,))
$(eval $(call BuildAsterisk15Module,format-ogg-vorbis,OGG/Vorbis audio,OGG/Vorbis streams,+libvorbis,,format_ogg_vorbis,,))
$(eval $(call BuildAsterisk15Module,format-pcm,PCM format,support for PCM format,,,format_pcm,,))
$(eval $(call BuildAsterisk15Module,format-siren14,Siren14,ITU G.722.1 Annex C Siren14 48kbps-only format,,,format_siren14,,))
$(eval $(call BuildAsterisk15Module,format-siren7,Siren7,ITU G.722.1 Siren7 32kbps-only format,,,format_siren7,,))
$(eval $(call BuildAsterisk15Module,format-sln,Raw slinear format,support for raw slinear format,,,format_sln,,))
$(eval $(call BuildAsterisk15Module,format-vox,VOX format,support for ADPCM vox format,,,format_vox,,))
$(eval $(call BuildAsterisk15Module,format-wav,WAV format (8000hz Signed Linear),support for proprietary Microsoft WAV format (8000hz Signed Linear),,,format_wav,,))
$(eval $(call BuildAsterisk15Module,format-wav-gsm,WAV format (Proprietary GSM),support for proprietary Microsoft WAV format (Proprietary GSM),,,format_wav_gsm,,))
$(eval $(call BuildAsterisk15Module,func-aes,AES dialplan functions,AES encryption/decryption dialplan functions,,,func_aes,,))
$(eval $(call BuildAsterisk15Module,func-base64,base64 support,support of base64 function,,,func_base64,,))
$(eval $(call BuildAsterisk15Module,func-blacklist,Blacklist on callerid,looking up the callerid number and see if it is blacklisted,,,func_blacklist,,))
$(eval $(call BuildAsterisk15Module,func-callcompletion,Call control configuration function,call completion supplementary services implementation,,,func_callcompletion,,))
$(eval $(call BuildAsterisk15Module,func-channel,Channel info,Channel info dialplan function,,,func_channel,,))
$(eval $(call BuildAsterisk15Module,func-config,Configuration file variable access,a function to retrieve variables from an Asterisk configuration file,,,func_config,,))
$(eval $(call BuildAsterisk15Module,func-cut,CUT function,CUT function,,,func_cut,,))
$(eval $(call BuildAsterisk15Module,func-db,Database interaction,functions for interaction with the database,,,func_db app_db,,))
$(eval $(call BuildAsterisk15Module,func-devstate,Blinky lights control,functions for manually controlled blinky lights,,,func_devstate,,))
$(eval $(call BuildAsterisk15Module,func-dialgroup,Dialgroup dialplan function,dialgroup dialplan function,,,func_dialgroup,,))
$(eval $(call BuildAsterisk15Module,func-dialplan,Dialplan context/extension/priority checking functions,dialplan group functions check if a dialplan entry exists,,,func_dialplan,,))
$(eval $(call BuildAsterisk15Module,func-enum,ENUM,ENUM,,enum.conf,func_enum,,))
$(eval $(call BuildAsterisk15Module,func-env,Environment functions,Environment dialplan functions,,,func_env,,))
$(eval $(call BuildAsterisk15Module,func-extstate,Hinted extension state,retrieving the state of a hinted extension for dialplan control,,,func_extstate,,))
$(eval $(call BuildAsterisk15Module,func-frame-trace,Frame trace for internal ast_frame debugging,trace internal ast_frames on a channel,,,func_frame_trace,,))
$(eval $(call BuildAsterisk15Module,func-global,Global variable,global variable dialplan functions,,,func_global,,))
$(eval $(call BuildAsterisk15Module,func-groupcount,Group count,for counting number of channels in the specified group,,,func_groupcount,,))
$(eval $(call BuildAsterisk15Module,func-hangupcause,HANGUPCAUSE related functions,functions related to retreiving per-channel hangupcause information,,,func_hangupcause,,))
$(eval $(call BuildAsterisk15Module,func-holdintercept,Hold interception dialplan function,function that intercepts HOLD frames from channels and raises events,,,func_holdintercept,,))
$(eval $(call BuildAsterisk15Module,func-iconv,Charset conversion,charset conversion,@!USE_UCLIBC,,func_iconv,,))
$(eval $(call BuildAsterisk15Module,func-jitterbuffer,Jitter buffer for read side of channel,put a jitterbuffer on the read side of a channel,,,func_jitterbuffer,,))
$(eval $(call BuildAsterisk15Module,func-lock,Dialplan mutexes,dialplan mutexes,,,func_lock,,))
$(eval $(call BuildAsterisk15Module,func-math,Math functions,Math functions,,,func_math,,))
$(eval $(call BuildAsterisk15Module,func-md5,MD5 digest dialplan functions,MD5 digest related dialplan functions,,,func_md5,,))
$(eval $(call BuildAsterisk15Module,func-module,Simple module check function,Simple module check function,,,func_module,,))
$(eval $(call BuildAsterisk15Module,func-periodic-hook,Periodic dialplan hooks,Execute a periodic dialplan hook into the audio of a call,,,func_periodic_hook,,))
$(eval $(call BuildAsterisk15Module,func-pitchshift,Audio effects dialplan functions,pitch shift audio effect,,,func_pitchshift,,))
$(eval $(call BuildAsterisk15Module,func-presencestate,Hinted presence state,Gets or sets a presence state in the dialplan,,,func_presencestate,,))
$(eval $(call BuildAsterisk15Module,func-rand,RAND dialplan function,RAND dialplan function,,,func_rand,,))
$(eval $(call BuildAsterisk15Module,func-realtime,REALTIME dialplan function,REALTIME dialplan function,,,func_realtime,,))
$(eval $(call BuildAsterisk15Module,func-sha1,SHA-1 computation dialplan function,SHA1 digest related dialplan functions,,,func_sha1,,))
$(eval $(call BuildAsterisk15Module,func-shell,Shell,support for shell execution,,,func_shell,,))
$(eval $(call BuildAsterisk15Module,func-sorcery,Get a field from a sorcery object,get a field from a sorcery object,,,func_sorcery,,))
$(eval $(call BuildAsterisk15Module,func-speex,Noise reduction and AGC,noise reduction and automatic gain control,@!SOFT_FLOAT +libspeex +libspeexdsp,,func_speex,,))
$(eval $(call BuildAsterisk15Module,func-sprintf,SPRINTF dialplan function,string manipulation dialplan functions,,,func_sprintf,,))
$(eval $(call BuildAsterisk15Module,func-srv,SRV functions,SRV related dialplan functions,,,func_srv,,))
$(eval $(call BuildAsterisk15Module,func-sysinfo,System information related functions,SYSINFO function to return various system data,,,func_sysinfo,,))
$(eval $(call BuildAsterisk15Module,func-talkdetect,Talk detection dialplan function,function that raises events when talking is detected on a channel,,,func_talkdetect,,))
$(eval $(call BuildAsterisk15Module,func-uri,URI encoding and decoding,Encodes and decodes URI-safe strings,,,func_uri,,))
$(eval $(call BuildAsterisk15Module,func-version,Get Asterisk version/build info,return the current version strings,,,func_version,,))
$(eval $(call BuildAsterisk15Module,func-vmcount,vmcount dialplan,a vmcount dialplan function,,,func_vmcount,,))
$(eval $(call BuildAsterisk15Module,func-volume,Technology independent volume control,technology independent volume control,,,func_volume,,))
$(eval $(call BuildAsterisk15Module,odbc,ODBC,ODBC support,+libpthread +libc +unixodbc,cdr_adaptive_odbc.conf cdr_odbc.conf cel_odbc.conf func_odbc.conf res_odbc.conf,cdr_adaptive_odbc cdr_odbc cel_odbc func_odbc res_config_odbc res_odbc res_odbc_transaction,,))
$(eval $(call BuildAsterisk15Module,pbx-ael,Asterisk Extension Logic,support for symbolic Asterisk Extension Logic,,extensions.ael,pbx_ael,,))
$(eval $(call BuildAsterisk15Module,pbx-dundi,Dundi,provides Dundi Lookup service for Asterisk,,dundi.conf,pbx_dundi,,))
$(eval $(call BuildAsterisk15Module,pbx-loopback,Loopback switch,loopback PBX module,,,pbx_loopback,,))
$(eval $(call BuildAsterisk15Module,pbx-lua,Lua,provides Lua resources for Asterisk,+liblua,extensions.lua,pbx_lua,,))
$(eval $(call BuildAsterisk15Module,pbx-realtime,Realtime Switch,realtime switch support,,,pbx_realtime,,))
$(eval $(call BuildAsterisk15Module,pbx-spool,Call Spool,outgoing call spool support,,,pbx_spool,,))
$(eval $(call BuildAsterisk15Module,pgsql,PostgreSQL,PostgreSQL support,+libpq @!arc,cel_pgsql.conf cdr_pgsql.conf res_pgsql.conf,cel_pgsql cdr_pgsql res_config_pgsql,,))
$(eval $(call BuildAsterisk15Module,pjsip,pjsip channel,the channel pjsip,+asterisk15-res-sorcery +asterisk15-res-pjproject +libpjsip +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsua +libpjsua2,pjsip.conf pjsip_notify.conf pjsip_wizard.conf,chan_pjsip func_pjsip_aor func_pjsip_contact func_pjsip_endpoint res_pjsip res_pjsip_acl res_pjsip_authenticator_digest res_pjsip_caller_id res_pjsip_config_wizard res_pjsip_dialog_info_body_generator res_pjsip_diversion res_pjsip_dlg_options res_pjsip_dtmf_info res_pjsip_empty_info res_pjsip_endpoint_identifier_anonymous res_pjsip_endpoint_identifier_ip res_pjsip_endpoint_identifier_user res_pjsip_exten_state res_pjsip_header_funcs res_pjsip_history res_pjsip_logger res_pjsip_messaging res_pjsip_mwi res_pjsip_mwi_body_generator res_pjsip_nat res_pjsip_notify res_pjsip_one_touch_record_info res_pjsip_outbound_authenticator_digest res_pjsip_outbound_publish res_pjsip_outbound_registration res_pjsip_path res_pjsip_pidf_body_generator res_pjsip_pidf_digium_body_supplement res_pjsip_pidf_eyebeam_body_supplement res_pjsip_publish_asterisk res_pjsip_pubsub res_pjsip_refer res_pjsip_registrar res_pjsip_registrar_expire res_pjsip_rfc3326 res_pjsip_sdp_rtp res_pjsip_send_to_voicemail res_pjsip_session res_pjsip_sips_contact res_pjsip_t38 res_pjsip_transport_management res_pjsip_transport_websocket res_pjsip_xpidf_body_generator,,))
$(eval $(call BuildAsterisk15Module,res-adsi,Provide ADSI,Analog Display Services Interface capability,,,res_adsi,,))
$(eval $(call BuildAsterisk15Module,res-ael-share,Shareable AEL code,support for shareable AEL code mainly between internal and external modules,,,res_ael_share,,))
$(eval $(call BuildAsterisk15Module,res-agi,Asterisk Gateway Interface,Support for the Asterisk Gateway Interface extension,+asterisk15-res-speech,,res_agi,,))
$(eval $(call BuildAsterisk15Module,res-ari,Asterisk RESTful interface,HTTP binding for the Stasis API,+$(PKG_NAME)-res-http-websocket,ari.conf,res_ari,,))
$(eval $(call BuildAsterisk15Module,res-ari-applications,RESTful Stasis application resources,RESTful API module - Stasis application resources,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis,,res_ari_applications,))
$(eval $(call BuildAsterisk15Module,res-ari-asterisk,RESTful Asterisk resources,RESTful API module - Asterisk resources,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis,,res_ari_asterisk,,))
$(eval $(call BuildAsterisk15Module,res-ari-bridges,RESTful bridge resources,RESTful API module - bridge resources,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-playback,,res_ari_bridges,,))
$(eval $(call BuildAsterisk15Module,res-ari-channels,RESTful channel resources,RESTful API module - channel resources,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-answer +$(PKG_NAME)-res-stasis-playback +$(PKG_NAME)-res-stasis-snoop,,res_ari_channels,,))
$(eval $(call BuildAsterisk15Module,res-ari-device-states,RESTful device state resources,RESTful API module - device state resources,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-device-state,,res_ari_device_states,,))
$(eval $(call BuildAsterisk15Module,res-ari-endpoints,RESTful endpoint resources,RESTful API module - endpoint resources,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis,,res_ari_endpoints,,))
$(eval $(call BuildAsterisk15Module,res-ari-events,RESTful WebSocket resource,RESTful API module - WebSocket resource,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis,,res_ari_events,,))
$(eval $(call BuildAsterisk15Module,res-ari-mailboxes,RESTful mailboxes resources,RESTful API module - mailboxes resources,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-mailbox,,res_ari_mailboxes,,))
$(eval $(call BuildAsterisk15Module,res-ari-model,ARI model validators,ARI model validators,,,res_ari_model,,))
$(eval $(call BuildAsterisk15Module,res-ari-playbacks,RESTful playback control resources,RESTful API module - playback control resources,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-playback,,res_ari_playbacks,,))
$(eval $(call BuildAsterisk15Module,res-ari-recordings,RESTful recording resources,RESTful API module - recording resources,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-recording,,res_ari_recordings,,))
$(eval $(call BuildAsterisk15Module,res-ari-sounds,RESTful sound resources,RESTful API module - sound resources,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis,,res_ari_sounds,))
$(eval $(call BuildAsterisk15Module,res-calendar,Calendar API,the calendar API,,calendar.conf,res_calendar,,))
$(eval $(call BuildAsterisk15Module,res-calendar-caldav,CalDAV calendar,CalDAV calendar integration,+asterisk15-res-calendar +libical +libneon +libxml2,,res_calendar_caldav,,))
$(eval $(call BuildAsterisk15Module,res-calendar-ews,EWS calendar,MS Exchange Web Service calendar integration,+asterisk15-res-calendar +libneon,,res_calendar_ews,,))
$(eval $(call BuildAsterisk15Module,res-calendar-exchange,Exchange calendar,MS Exchange calendar integration,+asterisk15-res-calendar +libical +libiksemel +libneon,,res_calendar_exchange,,))
$(eval $(call BuildAsterisk15Module,res-calendar-icalendar,iCalendar calendar,iCalendar calendar integration,+asterisk15-res-calendar +libical +libneon,,res_calendar_icalendar,,))
$(eval $(call BuildAsterisk15Module,res-chan-stats,statsd channel stats,example of how to subscribe to Stasis events,+$(PKG_NAME)-res-statsd,,res_chan_stats,,))
$(eval $(call BuildAsterisk15Module,res-clialiases,CLI aliases,CLI aliases,,cli_aliases.conf,res_clialiases,,))
$(eval $(call BuildAsterisk15Module,res-clioriginate,Calls via CLI,Originate calls via the CLI,,,res_clioriginate,,))
$(eval $(call BuildAsterisk15Module,res-config-ldap,LDAP realtime interface,LDAP plugin for portable configuration engine,+libopenldap,res_ldap.conf,res_config_ldap,,))
$(eval $(call BuildAsterisk15Module,res-config-mysql,MySQL CDR backend,MySQL CDR backend,+libmysqlclient,,res_config_mysql,,))
$(eval $(call BuildAsterisk15Module,res-config-sqlite3,SQLite 3 realtime config engine,SQLite 3 configuration engine,,,res_config_sqlite3,,))
$(eval $(call BuildAsterisk15Module,res-convert,File format conversion CLI command,file format conversion CLI command using Asterisk formats and translators,,,res_convert,,))
$(eval $(call BuildAsterisk15Module,res-endpoint-stats,Endpoint statistics,statsd endpoint stats,+$(PKG_NAME)-res-statsd,,res_endpoint_stats,,))
$(eval $(call BuildAsterisk15Module,res-hep,HEPv3 API,Routines for integration with Homer using HEPv3,,hep.conf,res_hep,,))
$(eval $(call BuildAsterisk15Module,res-hep-pjsip,PJSIP HEPv3 Logger,PJSIP logging with Homer,+asterisk15-res-hep +asterisk15-pjsip,,res_hep_pjsip,,))
$(eval $(call BuildAsterisk15Module,res-hep-rtcp,RTCP HEPv3 Logger,RTCP logging with Homer,+asterisk15-res-hep,,res_hep_rtcp,,))
$(eval $(call BuildAsterisk15Module,res-fax-spandsp,Spandsp T.38 and G.711,Spandsp T.38 and G.711 FAX Resource,+asterisk15-res-fax +libspandsp +libtiff,,res_fax_spandsp,,))
$(eval $(call BuildAsterisk15Module,res-fax,FAX modules,Generic FAX resource for FAX technology resource modules,+asterisk15-res-timing-pthread,res_fax.conf,res_fax,,))
$(eval $(call BuildAsterisk15Module,res-format-attr-celt,CELT format attribute module,CELT format attribute interface,,,res_format_attr_celt,,))
$(eval $(call BuildAsterisk15Module,res-format-attr-g729,G.729 format attribute module,G.729 format attribute interface,,,res_format_attr_g729,,))
$(eval $(call BuildAsterisk15Module,res-format-attr-h263,H.263 format attribute module,H.263 format attribute interface,,,res_format_attr_h263,,))
$(eval $(call BuildAsterisk15Module,res-format-attr-h264,H.264 format attribute module,H.264 format attribute interface,,,res_format_attr_h264,,))
$(eval $(call BuildAsterisk15Module,res-format-attr-ilbc,ILBC format attribute module,ILBC format attribute interface,,,res_format_attr_ilbc,,))
$(eval $(call BuildAsterisk15Module,res-format-attr-opus,Opus format attribute module,Opus format attribute interface,,,res_format_attr_opus,,))
$(eval $(call BuildAsterisk15Module,res-format-attr-silk,SILK format attribute module,SILK format attribute interface,,,res_format_attr_silk,,))
$(eval $(call BuildAsterisk15Module,res-format-attr-siren14,Siren14 format attribute module,Siren14 format attribute interface,,,res_format_attr_siren14,,))
$(eval $(call BuildAsterisk15Module,res-format-attr-siren7,Siren7 format attribute module,Siren7 format attribute interface,,,res_format_attr_siren7,,))
$(eval $(call BuildAsterisk15Module,res-format-attr-vp8,VP8 format attribute module,VP8 format attribute interface,,,res_format_attr_vp8,,))
$(eval $(call BuildAsterisk15Module,res-http-media-cache,HTTP media cache backend,HTTP backend for the core media cache,+$(PKG_NAME)-curl,,res_http_media_cache,,))
$(eval $(call BuildAsterisk15Module,res-http-websocket,HTTP websocket support,WebSocket support for the Asterisk internal HTTP server,,,res_http_websocket,,))
$(eval $(call BuildAsterisk15Module,res-limit,Resource limits,resource limits,,,res_limit,,))
$(eval $(call BuildAsterisk15Module,res-manager-devicestate,Device state topic forwarder,list the current known device states,,,res_manager_devicestate,,))
$(eval $(call BuildAsterisk15Module,res-manager-presencestate,Presence state topic forwarder,list the current known presence states,,,res_manager_presencestate,,))
$(eval $(call BuildAsterisk15Module,res-monitor,Provide Monitor,Cryptographic Signature capability,,,res_monitor,,))
$(eval $(call BuildAsterisk15Module,res-musiconhold,MOH,Music On Hold support,,musiconhold.conf,res_musiconhold,,))
$(eval $(call BuildAsterisk15Module,res-mutestream,Mute audio stream resources,MUTESTREAM audiohooks,,,res_mutestream,,))
$(eval $(call BuildAsterisk15Module,res-mwi-external,Core external MWI resource,core external MWI resource,,,res_mwi_external,,))
$(eval $(call BuildAsterisk15Module,res-mwi-external-ami,AMI for external MWI,AMI wrapper for external MWI,+$(PKG_NAME)-res-mwi-external,,res_mwi_external_ami,,))
$(eval $(call BuildAsterisk15Module,res-parking,Phone Parking,Phone Parking application,,res_parking.conf,res_parking,,))
$(eval $(call BuildAsterisk15Module,res-phoneprov,Phone Provisioning,Phone provisioning application for the asterisk internal http server,,phoneprov.conf,res_phoneprov,,))
$(eval $(call BuildAsterisk15Module,res-pjsip-phoneprov,PJSIP Phone Provisioning,PJSIP Phone Provisioning,+asterisk15-pjsip +asterisk15-res-phoneprov,,res_pjsip_phoneprov_provider,,))
$(eval $(call BuildAsterisk15Module,res-pjproject,Bridge PJPROJECT to Asterisk logging,,+libpj +libpjlib-util +libpjmedia +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsip +libpjsua +libpjsua2 +libsrtp2,pjproject.conf,res_pjproject,,))
$(eval $(call BuildAsterisk15Module,res-pktccops,PktcCOPS manager for MGCP,PacketCable MGCP variation / NCS,,res_pktccops.conf,res_pktccops,,))
$(eval $(call BuildAsterisk15Module,res-realtime,RealTime CLI,RealTime CLI,,,res_realtime,,))
$(eval $(call BuildAsterisk15Module,res-resolver-unbound,Unbound DNS resolver,Unbound DNS resolver,+libunbound,resolver_unbound.conf,res_resolver_unbound,,))
$(eval $(call BuildAsterisk15Module,res-rtp-asterisk,RTP stack,Supports RTP and RTCP with Symmetric RTP support for NAT traversal,+libpjsip +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsua +libpjsua2,rtp.conf,res_rtp_asterisk,,))
$(eval $(call BuildAsterisk15Module,res-rtp-multicast,RTP multicast engine,Multicast RTP Engine,,,res_rtp_multicast,,))
$(eval $(call BuildAsterisk15Module,res-sdp-translator-pjmedia,PJMEDIA SDP translator,PJMEDIA SDP translator,+libpjsua2,,res_sdp_translator_pjmedia,,))
$(eval $(call BuildAsterisk15Module,res-security-log,Security event logging,security event logging,,,res_security_log,,))
$(eval $(call BuildAsterisk15Module,res-smdi,Provide SMDI,Simple Message Desk Interface capability,,smdi.conf,res_smdi,,))
$(eval $(call BuildAsterisk15Module,res-snmp,SNMP [Sub]Agent for Asterisk,SNMP Agent / SubAgent,+libnetsnmp,res_snmp.conf,res_snmp,,))
$(eval $(call BuildAsterisk15Module,res-sorcery,Sorcery data layer,Sorcery backend modules for data access intended for using realtime as backend,,sorcery.conf,res_sorcery_astdb res_sorcery_config res_sorcery_memory res_sorcery_realtime,,))
$(eval $(call BuildAsterisk15Module,res-sorcery-memory-cache,Sorcery memory cache object wizard,sorcery memory cache object wizard,,,res_sorcery_memory_cache,,))
$(eval $(call BuildAsterisk15Module,res-speech,Speech Recognition API,Support for the Asterisk Generic Speech Recognition API,,,res_speech,,))
$(eval $(call BuildAsterisk15Module,res-srtp,SRTP Support,Secure RTP connection,+libsrtp2,,res_srtp,,))
$(eval $(call BuildAsterisk15Module,res-stasis,Stasis application,Stasis application,,,res_stasis,,))
$(eval $(call BuildAsterisk15Module,res-stasis-answer,Stasis application answer,Stasis application control,+$(PKG_NAME)-res-stasis,,res_stasis_answer,,))
$(eval $(call BuildAsterisk15Module,res-stasis-device-state,Stasis application device state,Stasis application control,+$(PKG_NAME)-res-stasis,,res_stasis_device_state,,))
$(eval $(call BuildAsterisk15Module,res-stasis-mailbox,Stasis application mailbox,Stasis application control,+$(PKG_NAME)-res-stasis +$(PKG_NAME)-res-mwi-external,,res_stasis_mailbox,,))
$(eval $(call BuildAsterisk15Module,res-stasis-playback,Stasis application playback,res_stasis playback,+$(PKG_NAME)-res-stasis-recording,,res_stasis_playback,,))
$(eval $(call BuildAsterisk15Module,res-stasis-recording,Stasis application recording,res_stasis recording,+$(PKG_NAME)-res-stasis,,res_stasis_recording,,))
$(eval $(call BuildAsterisk15Module,res-stasis-snoop,Stasis application snoop,Stasis application snoop control,+$(PKG_NAME)-res-stasis-recording,,res_stasis_snoop,,))
$(eval $(call BuildAsterisk15Module,res-statsd,statsd client,publishing to a statsd server,,statsd.conf,res_statsd,,))
$(eval $(call BuildAsterisk15Module,res-stun-monitor,STUN monitoring,resource STUN Monitor,,res_stun_monitor.conf,res_stun_monitor,,))
$(eval $(call BuildAsterisk15Module,res-timing-dahdi,DAHDI Timing Interface,DAHDI timing interface,+asterisk15-chan-dahdi,,res_timing_dahdi,,))
$(eval $(call BuildAsterisk15Module,res-timing-pthread,pthread Timing Interface,POSIX pthreads Timing Interface,,,res_timing_pthread,,))
$(eval $(call BuildAsterisk15Module,res-timing-timerfd,Timerfd Timing Interface,Timing interface provided by Linux kernel,,,res_timing_timerfd,,))
$(eval $(call BuildAsterisk15Module,res-xmpp,XMPP client and component module,reference module for interfacting Asterisk directly as a client or component with XMPP server,+libiksemel +libopenssl,xmpp.conf,res_xmpp,,))
$(eval $(call BuildAsterisk15Module,voicemail,Voicemail,voicemail related modules,+asterisk15-res-adsi +asterisk15-res-smdi,voicemail.conf,app_voicemail,vm-*,))

################################
# AST utils
# Params:
# 1 - Utility name
# 2 - Description
# 3 - Dependencies
# 4 - Configuration files
################################
# $(eval $(call BuildAsterisk15Util,Utility,Description,Dependencies,Configuration Files))

$(eval $(call BuildAsterisk15Util,aelparse,Check extensions.ael file.,,))
$(eval $(call BuildAsterisk15Util,astcanary,Assures Asterisk no threads have gone missing.,,))
$(eval $(call BuildAsterisk15Util,astdb2sqlite3,Convert astdb to SQLite 3.,,))
$(eval $(call BuildAsterisk15Util,astdb2bdb,Convert astdb back to Berkeley DB 1.86.,,))
$(eval $(call BuildAsterisk15Util,check_expr,Expression checker [older version].,,))
$(eval $(call BuildAsterisk15Util,check_expr2,Expression checker [newer version].,,))
$(eval $(call BuildAsterisk15Util,conf2ael,Convert .conf to .ael.,,))
$(eval $(call BuildAsterisk15Util,muted,Listens for AMI events. Mutes soundcard during call.,,muted.conf))
$(eval $(call BuildAsterisk15Util,smsq,Send messages from command line.,,))
$(eval $(call BuildAsterisk15Util,stereorize,Merge two mono WAV-files to one stereo WAV-file.,,))
$(eval $(call BuildAsterisk15Util,streamplayer,A utility for reading from a raw TCP stream [MOH source].,,))
