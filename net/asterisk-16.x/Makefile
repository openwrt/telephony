#
# Copyright (C) 2017 - 2018 Jiri Slachta <jiri@slachta.eu>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

AST_MAJOR_VERSION:=16
PKG_NAME:=asterisk$(AST_MAJOR_VERSION)
PKG_VERSION:=$(AST_MAJOR_VERSION).3.0
PKG_RELEASE:=8

PKG_SOURCE:=asterisk-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://downloads.asterisk.org/pub/telephony/asterisk/releases
PKG_HASH:=8b22ee7c0c0b5557eff273118703c6fce8b743c12bbeb679ed86b3f197444a8e

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

MODULES_AVAILABLE:= \
	app-adsiprog \
	app-agent-pool \
	app-alarmreceiver \
	app-amd \
	app-authenticate \
	app-bridgeaddchan \
	app-bridgewait \
	app-celgenuserevent \
	app-chanisavail \
	app-channelredirect \
	app-chanspy \
	app-confbridge \
	app-controlplayback \
	app-dahdiras \
	app-dictate \
	app-directed-pickup \
	app-directory \
	app-disa \
	app-dumpchan \
	app-exec \
	app-externalivr \
	app-festival \
	app-flash \
	app-followme \
	app-getcpeid \
	app-ices \
	app-image \
	app-ivrdemo \
	app-milliwatt \
	app-minivm \
	app-mixmonitor \
	app-morsecode \
	app-mp3 \
	app-originate \
	app-page \
	app-playtones \
	app-privacy \
	app-queue \
	app-read \
	app-readexten \
	app-record \
	app-saycounted \
	app-sayunixtime \
	app-senddtmf \
	app-sendtext \
	app-skel \
	app-sms \
	app-softhangup \
	app-speech \
	app-stack \
	app-stasis \
	app-statsd \
	app-stream-echo \
	app-system \
	app-talkdetect \
	app-test \
	app-transfer \
	app-url \
	app-userevent \
	app-verbose \
	app-waitforring \
	app-waitforsilence \
	app-waituntil \
	app-while \
	app-zapateller \
	bridge-builtin-features \
	bridge-builtin-interval-features \
	bridge-holding \
	bridge-native-rtp \
	bridge-simple \
	bridge-softmix \
	cdr \
	cdr-csv \
	cdr-sqlite3 \
	cel-custom \
	cel-manager \
	cel-sqlite3-custom \
	chan-alsa \
	chan-bridge-media \
	chan-console \
	chan-dahdi \
	chan-iax2 \
	chan-mgcp \
	chan-mobile \
	chan-motif \
	chan-ooh323 \
	chan-oss \
	chan-phone \
	chan-rtp \
	chan-sip \
	chan-skinny \
	chan-unistim \
	codec-a-mu \
	codec-adpcm \
	codec-alaw \
	codec-dahdi \
	codec-g722 \
	codec-g726 \
	codec-gsm \
	codec-ilbc \
	codec-lpc10 \
	codec-resample \
	codec-speex \
	codec-ulaw \
	curl \
	format-g719 \
	format-g723 \
	format-g726 \
	format-g729 \
	format-gsm \
	format-h263 \
	format-h264 \
	format-ilbc \
	format-mp3 \
	format-ogg-speex \
	format-ogg-vorbis \
	format-pcm \
	format-siren14 \
	format-siren7 \
	format-sln \
	format-vox \
	format-wav \
	format-wav-gsm \
	func-aes \
	func-base64 \
	func-blacklist \
	func-callcompletion \
	func-channel \
	func-config \
	func-cut \
	func-db \
	func-devstate \
	func-dialgroup \
	func-dialplan \
	func-enum \
	func-env \
	func-extstate \
	func-frame-trace \
	func-global \
	func-groupcount \
	func-hangupcause \
	func-holdintercept \
	func-iconv \
	func-jitterbuffer \
	func-lock \
	func-math \
	func-md5 \
	func-module \
	func-periodic-hook \
	func-pitchshift \
	func-presencestate \
	func-rand \
	func-realtime \
	func-sha1 \
	func-shell \
	func-sorcery \
	func-speex \
	func-sprintf \
	func-srv \
	func-sysinfo \
	func-talkdetect \
	func-uri \
	func-version \
	func-vmcount \
	func-volume \
	odbc \
	pbx-ael \
	pbx-dundi \
	pbx-loopback \
	pbx-lua \
	pbx-realtime \
	pbx-spool \
	pgsql \
	pjsip \
	res-adsi \
	res-ael-share \
	res-agi \
	res-ari \
	res-ari-applications \
	res-ari-asterisk \
	res-ari-bridges \
	res-ari-channels \
	res-ari-device-states \
	res-ari-endpoints \
	res-ari-events \
	res-ari-mailboxes \
	res-ari-model \
	res-ari-playbacks \
	res-ari-recordings \
	res-ari-sounds \
	res-calendar \
	res-calendar-caldav \
	res-calendar-ews \
	res-calendar-exchange \
	res-calendar-icalendar \
	res-chan-stats \
	res-clialiases \
	res-clioriginate \
	res-config-ldap \
	res-config-mysql \
	res-config-sqlite3 \
	res-convert \
	res-endpoint-stats \
	res-hep \
	res-hep-pjsip \
	res-hep-rtcp \
	res-fax-spandsp \
	res-fax \
	res-format-attr-celt \
	res-format-attr-g729 \
	res-format-attr-h263 \
	res-format-attr-h264 \
	res-format-attr-ilbc \
	res-format-attr-opus \
	res-format-attr-silk \
	res-format-attr-siren14 \
	res-format-attr-siren7 \
	res-format-attr-vp8 \
	res-http-media-cache \
	res-http-websocket \
	res-limit \
	res-manager-devicestate \
	res-manager-presencestate \
	res-monitor \
	res-musiconhold \
	res-mutestream \
	res-mwi-devstate \
	res-mwi-external \
	res-mwi-external-ami \
	res-parking \
	res-phoneprov \
	res-pjsip-phoneprov \
	res-pjproject \
	res-pktccops \
	res-realtime \
	res-remb-modifier \
	res-resolver-unbound \
	res-rtp-asterisk \
	res-rtp-multicast \
	res-security-log \
	res-smdi \
	res-snmp \
	res-sorcery \
	res-sorcery-memory-cache \
	res-speech \
	res-srtp \
	res-stasis \
	res-stasis-answer \
	res-stasis-device-state \
	res-stasis-mailbox \
	res-stasis-playback \
	res-stasis-recording \
	res-stasis-snoop \
	res-statsd \
	res-stun-monitor \
	res-timing-dahdi \
	res-timing-pthread \
	res-timing-timerfd \
	res-xmpp \
	voicemail

UTILS_AVAILABLE:= \
	aelparse \
	astcanary \
	astdb2sqlite3 \
	astdb2bdb \
	check_expr \
	check_expr2 \
	conf2ael \
	muted \
	smsq \
	stereorize \
	streamplayer

AST_ENABLE:=

PKG_CONFIG_DEPENDS:= \
	$(patsubst %,CONFIG_PACKAGE_$(PKG_NAME)-%,$(MODULES_AVAILABLE)) \
	$(patsubst %,CONFIG_PACKAGE_$(PKG_NAME)-util-%,$(subst _,-,$(UTILS_AVAILABLE))) \
	CONFIG_ASTERISK$(AST_MAJOR_VERSION)_LOW_MEMORY

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
# Needed for res-config-mysql and func-iconv to find iconv
include $(INCLUDE_DIR)/nls.mk

define Package/$(PKG_NAME)/install/module
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/asterisk/modules/*$(2).so* $(1)/usr/lib/asterisk/modules/
endef

define Package/$(PKG_NAME)/install/conffile
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(CP) $(PKG_INSTALL_DIR)/etc/asterisk/$(2) $(1)/etc/asterisk/
endef

define Package/$(PKG_NAME)/install/lib
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(2).so* $(1)/usr/lib/
endef

define Package/$(PKG_NAME)/install/sbin
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/$(2) $(1)/usr/sbin/
endef

define Package/$(PKG_NAME)/install/sounds
	$(INSTALL_DIR) $(1)/usr/share/asterisk/sounds/
	$(CP) $(PKG_INSTALL_DIR)/usr/share/asterisk/sounds/en/$(2) $(1)/usr/share/asterisk/sounds/
endef

define Package/$(PKG_NAME)/install/util-conffile
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/asterisk/$(2) $(1)/etc
endef

define Package/$(PKG_NAME)/config
	menu "Advanced configuration"
		depends on PACKAGE_asterisk$(AST_MAJOR_VERSION)

	config ASTERISK$(AST_MAJOR_VERSION)_LOW_MEMORY
		bool "Optimize Asterisk $(AST_MAJOR_VERSION) for low memory usage"
		default n
		help
		  Warning: this feature is known to cause problems with some modules.
		  Disable it if you experience problems like segmentation faults.

	endmenu
endef

define BuildAsteriskModule
  define Package/$(PKG_NAME)-$(1)
  $$(call Package/$(PKG_NAME)/Default)
    TITLE:=$(2) support
    DEPENDS:= $(PKG_NAME) $(patsubst +%,+PACKAGE_$(PKG_NAME)-$(1):%,$(4)) $(9)
    ifneq ($$(CONFIG_PACKAGE_$(PKG_NAME)-$(1)),)
    AST_ENABLE+=$(6)
    endif
  endef

  define Package/$(PKG_NAME)-$(1)/conffiles
$(subst $(space),$(newline),$(foreach c,$(5),/etc/asterisk/$(c)))
  endef

  define Package/$(PKG_NAME)-$(1)/description
$(subst \n,$(newline),$(3))
  endef

  define Package/$(PKG_NAME)-$(1)/install
$(foreach c,$(5),$(call Package/$(PKG_NAME)/install/conffile,$$(1),$(c));)
$(foreach m,$(6),$(call Package/$(PKG_NAME)/install/module,$$(1),$(m));)
$(foreach s,$(7),$(call Package/$(PKG_NAME)/install/sounds,$$(1),$(s));)
$(foreach b,$(8),$(call Package/$(PKG_NAME)/install/sbin,$$(1),$(b));)
  endef

  $$(eval $$(call BuildPackage,$(PKG_NAME)-$(1)))
endef

define BuildAsteriskUtil
  define Package/$(PKG_NAME)-util-$(subst _,-,$(1))
  $$(call Package/$(PKG_NAME)/Default)
    TITLE:=$(1) utility
    DEPENDS:=$(PKG_NAME) $(patsubst +%,+PACKAGE_$(PKG_NAME)-util-$(subst _,-,$(1)):%,$(3))
    ifneq ($$(CONFIG_PACKAGE_$(PKG_NAME)-util-$(subst _,-,$(1))),)
    AST_ENABLE+=$(1)
    endif
  endef

  define Package/$(PKG_NAME)-util-$(subst _,-,$(1))/conffiles
$(subst $(space),$(newline),$(foreach c,$(4),/etc/$(c)))
  endef

  define Package/$(PKG_NAME)-util-$(subst _,-,$(1))/description
$(2)
  endef

  define Package/$(PKG_NAME)-util-$(subst _,-,$(1))/install
$(call Package/$(PKG_NAME)/install/sbin,$$(1),$(1))
$(foreach c,$(4),$(call Package/$(PKG_NAME)/install/util-conffile,$$(1),$(c));)
  endef

  $$(eval $$(call BuildPackage,$(PKG_NAME)-util-$(subst _,-,$(1))))
endef

define Package/$(PKG_NAME)/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=http://www.asterisk.org/
endef

define Package/$(PKG_NAME)/Default/description
 Asterisk is a complete PBX in software. It provides all of the features
 you would expect from a PBX and more. Asterisk does voice over IP in three
 protocols, and can interoperate with almost all standards-based telephony
 equipment using relatively inexpensive hardware.
endef

define Package/$(PKG_NAME)
$(call Package/$(PKG_NAME)/Default)
  TITLE:=Complete open source PBX, v$(PKG_VERSION)
  MENU:=1
  DEPENDS:=$(CXX_DEPENDS) +jansson +libcap +libedit +libopenssl +libsqlite3 +libuuid +libxml2 +zlib
endef

define Package/$(PKG_NAME)/description
$(call Package/$(PKG_NAME)/Default/description)
endef

define Package/$(PKG_NAME)/conffiles
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

define Package/$(PKG_NAME)/install
$(call Package/$(PKG_NAME)/install/lib,$(1),libasteriskssl)
$(call Package/$(PKG_NAME)/install/sbin,$(1),asterisk)
$(call Package/$(PKG_NAME)/install/sbin,$(1),safe_asterisk)
$(call Package/$(PKG_NAME)/install/sbin,$(1),astgenkey)
$(foreach m,$(AST_CFG_FILES),$(call Package/$(PKG_NAME)/install/conffile,$(1),$(m));)
$(foreach m,$(AST_EMB_MODULES),$(call Package/$(PKG_NAME)/install/module,$(1),$(m));)
	$(INSTALL_DIR) $(1)/usr/share/asterisk/sounds/
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_DATA) ./files/asterisk.default $(1)/etc/default/asterisk
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/asterisk.init $(1)/etc/init.d/asterisk
endef

define Package/$(PKG_NAME)-sounds
$(call Package/$(PKG_NAME)/Default)
  TITLE:=Sounds support
  DEPENDS:=$(PKG_NAME)
endef

define Package/$(PKG_NAME)-sounds/description
This package provides the sound-files for Asterisk $(AST_MAJOR_VERSION).
endef

define Package/$(PKG_NAME)-sounds/install
	$(INSTALL_DIR) $(1)/usr/share/asterisk/sounds/
	$(CP) $(PKG_INSTALL_DIR)/usr/share/asterisk/sounds/en/* $(1)/usr/share/asterisk/sounds/
	rm -f $(1)/usr/share/asterisk/sounds/vm-*
endef

ifeq ($(call qstrip,$(CONFIG_LIBC)),musl)
  CONFIGURE_ARGS+= \
	--enable-permanent-dlopen
endif

ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-chan-dahdi),)
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
	--disable-xmldoc \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-chan-alsa),--with-asound="$(STAGING_DIR)/usr",--without-asound) \
	--without-execinfo \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-chan-mobile),--with-bluetooth="$(STAGING_DIR)/usr",--without-bluetooth) \
	--with-cap="$(STAGING_DIR)/usr" \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-curl),--with-libcurl="$(STAGING_DIR)/usr") \
	--with-gsm=internal \
	--without-gtk2 \
	--with-ilbc=internal \
	--without-isdnnet \
	--without-misdn \
	--without-nbs \
	--without-pjproject-bundled \
	--with-libedit="$(STAGING_DIR)/usr" \
	--with-libxml2 \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-res-snmp),--with-netsnmp="$(STAGING_DIR)/usr",--without-netsnmp) \
	--without-newt \
	--without-osptk \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-pbx-lua),--with-lua="$(STAGING_DIR)/usr",--without-lua) \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-pgsql),--with-postgres="$(STAGING_DIR)/usr",--without-postgres) \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-util-smsq),--with-popt="$(STAGING_DIR)/usr",--without-popt) \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-chan-console),--with-portaudio="$(STAGING_DIR)/usr",--without-portaudio) \
	--without-radius \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-res-fax-spandsp),--with-spandsp="$(STAGING_DIR)/usr",--without-spandsp) \
	--without-sdl \
	--without-sqlite \
	--with-sqlite3="$(STAGING_DIR)/usr" \
	--without-suppserv \
	--without-tds \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-res-resolver-unbound),--with-unbound="$(STAGING_DIR)/usr",--without-unbound) \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-format-ogg-vorbis),--with-vorbis="$(STAGING_DIR)/usr",--without-vorbis) \
	--without-vpb \
	--with-z="$(STAGING_DIR)/usr"

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

ifeq ($(CONFIG_PACKAGE_$(PKG_NAME)-pjsip)$(CONFIG_PACKAGE_$(PKG_NAME)-res-pjproject)$(CONFIG_PACKAGE_$(PKG_NAME)-res-rtp-asterisk),)
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

define Build/menuselect
	CC="$(HOSTCC)" \
	CFLAGS="$(HOST_CFLAGS) -I$(STAGING_DIR_HOSTPKG)/include/libxml2" \
	LDFLAGS="$(HOST_LDFLAGS) -Wl,-rpath,$(STAGING_DIR_HOSTPKG)/lib" \
	$(MAKE) -C "$(PKG_BUILD_DIR)/menuselect"
endef

define Build/Configure
	cd $(PKG_BUILD_DIR); \
		./bootstrap.sh
	$(call Build/Configure/Default)
	cd $(PKG_BUILD_DIR)/menuselect; \
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
	$(call Build/menuselect)
	$(call Build/Compile/Default,menuselect-tree)

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
			$(if $(CONFIG_ASTERISK$(AST_MAJOR_VERSION)_LOW_MEMORY),--enable LOW_MEMORY) \
			menuselect.makeopts

	# When changing anything in MENUSELECT_CFLAGS the file ".lastclean"
	# gets deleted. E.g. when compiling on x86 for x86 "--disable
	# BUILD_NATIVE" changes MENUSELECT_CFLAGS and the file gets removed.
	# But that will result in a rebuild attempt of menuselect which will
	# likely fail. Prevent that by recreating ".lastclean" and menuselect.
	$(call Build/Compile/Default,.lastclean)
	$(call Build/menuselect)

	$(call Build/Compile/Default,all install samples)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/asterisk-$(AST_MAJOR_VERSION)/include/asterisk/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/asterisk/*.h $(1)/usr/include/asterisk-$(AST_MAJOR_VERSION)/include/asterisk/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/asterisk.h $(1)/usr/include/asterisk-$(AST_MAJOR_VERSION)/include/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-sounds))

#######################################
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
# 9 - complex depends (passed on as is)
#######################################
#$(eval $(call BuildAsteriskModule,subname,title,module description,module dependencies,conf files,module files,sound files,binary files,complex depends))

$(eval $(call BuildAsteriskModule,app-adsiprog,ADSI programming,Asterisk ADSI programming application.,+$(PKG_NAME)-res-adsi,adsi.conf asterisk.adsi telcordia-1.adsi,app_adsiprog,,))
$(eval $(call BuildAsteriskModule,app-agent-pool,Call center agent pool,Call center agent pool applications.,,agents.conf,app_agent_pool,,))
$(eval $(call BuildAsteriskModule,app-alarmreceiver,Alarm receiver,Alarm receiver for Asterisk.,,,app_alarmreceiver,,))
$(eval $(call BuildAsteriskModule,app-amd,Answering machine detection,Answering Machine Detection application.,,amd.conf,app_amd,,))
$(eval $(call BuildAsteriskModule,app-authenticate,Authenticate commands,Authentication application.,,,app_authenticate,,))
$(eval $(call BuildAsteriskModule,app-bridgeaddchan,Bridge add channel,Bridge-add-channel application.,,,app_bridgeaddchan,,))
$(eval $(call BuildAsteriskModule,app-bridgewait,Holding bridge,Application to place a channel into a holding bridge.,+$(PKG_NAME)-bridge-holding,,app_bridgewait,,))
$(eval $(call BuildAsteriskModule,app-celgenuserevent,User-defined CEL event,Generate a user defined CEL event.,,,app_celgenuserevent,,))
$(eval $(call BuildAsteriskModule,app-chanisavail,Channel availability check,Check channel availability.,,,app_chanisavail,,))
$(eval $(call BuildAsteriskModule,app-channelredirect,Redirect a channel,Redirects a given channel to a dialplan target.,,,app_channelredirect,,))
$(eval $(call BuildAsteriskModule,app-chanspy,Channel listen in,Listen to the audio of an active channel.,,,app_chanspy,,))
$(eval $(call BuildAsteriskModule,app-confbridge,ConfBridge,Conference bridge application.,+$(PKG_NAME)-bridge-builtin-features +$(PKG_NAME)-bridge-simple +$(PKG_NAME)-bridge-softmix,confbridge.conf,app_confbridge,,))
$(eval $(call BuildAsteriskModule,app-controlplayback,Control playback,Control playback application.,,,app_controlplayback,,))
$(eval $(call BuildAsteriskModule,app-dahdiras,Execute an ISDN RAS,DAHDI ISDN Remote Access Server.,+$(PKG_NAME)-chan-dahdi,,app_dahdiras,,))
$(eval $(call BuildAsteriskModule,app-dictate,Virtual dictation machine,Virtual dictation machine.,,,app_dictate,,))
$(eval $(call BuildAsteriskModule,app-directed-pickup,Directed call pickup,Directed call pickup application.,,,app_directed_pickup,,))
$(eval $(call BuildAsteriskModule,app-directory,Extension directory,Extension directory.,,,app_directory,,))
$(eval $(call BuildAsteriskModule,app-disa,Direct Inward System Access,Direct Inward System Access application.,,,app_disa,,))
$(eval $(call BuildAsteriskModule,app-dumpchan,Dump info about channel,Dump info about the calling channel.,,,app_dumpchan,,))
$(eval $(call BuildAsteriskModule,app-exec,Exec application,Executes dialplan applications.,,,app_exec,,))
$(eval $(call BuildAsteriskModule,app-externalivr,External IVR interface,External IVR interface application.,,,app_externalivr,,))
$(eval $(call BuildAsteriskModule,app-festival,Simple festival interface,Simple Festival interface.,,festival.conf,app_festival,,))
$(eval $(call BuildAsteriskModule,app-flash,Flash channel,Flash channel application.,+$(PKG_NAME)-chan-dahdi,,app_flash,,))
$(eval $(call BuildAsteriskModule,app-followme,Find-me/follow-me,Find-Me/Follow-Me application.,,followme.conf,app_followme,,))
$(eval $(call BuildAsteriskModule,app-getcpeid,Get ADSI CPE ID,Get ADSI CPE ID.,,,app_getcpeid,,))
$(eval $(call BuildAsteriskModule,app-ices,Encode and stream,Encode and stream via Icecast and IceS.,,,app_ices,,))
$(eval $(call BuildAsteriskModule,app-image,Image transmission,Image transmission application.,,,app_image,,))
$(eval $(call BuildAsteriskModule,app-ivrdemo,IVR demo,IVR demo application.,,,app_ivrdemo,,))
$(eval $(call BuildAsteriskModule,app-milliwatt,Digital milliwatt [mu-law] test app,Digital milliwatt test application.,,,app_milliwatt,,))
$(eval $(call BuildAsteriskModule,app-minivm,Minimal voicemail system,A minimal voicemail e-mail system.,,extensions_minivm.conf minivm.conf,app_minivm,,))
$(eval $(call BuildAsteriskModule,app-mixmonitor,Record a call and mix the audio,Mixed audio monitoring application.,,,app_mixmonitor,,))
$(eval $(call BuildAsteriskModule,app-morsecode,Morse code,Morse code.,,,app_morsecode,,))
$(eval $(call BuildAsteriskModule,app-mp3,Silly MP3,Silly MP3 application.,+mpg123,,app_mp3,,))
$(eval $(call BuildAsteriskModule,app-originate,Originate a call,Originate call.,,,app_originate,,))
$(eval $(call BuildAsteriskModule,app-page,Page multiple phones,Page multiple phones.,+$(PKG_NAME)-app-confbridge,,app_page,,))
$(eval $(call BuildAsteriskModule,app-playtones,Playtones application,Playtones application.,,,app_playtones,,))
$(eval $(call BuildAsteriskModule,app-privacy,Require phone number,Require phone number to be entered if no Caller ID sent.,,,app_privacy,,))
$(eval $(call BuildAsteriskModule,app-queue,True Call Queueing,True call queueing.,,queues.conf queuerules.conf,app_queue,,))
$(eval $(call BuildAsteriskModule,app-read,Variable read,Read variable application.,,,app_read,,))
$(eval $(call BuildAsteriskModule,app-readexten,Extension to variable,Read and evaluate extension validity.,,,app_readexten,,))
$(eval $(call BuildAsteriskModule,app-record,Record sound file,Trivial record application.,,,app_record,,))
$(eval $(call BuildAsteriskModule,app-saycounted,Decline words,Decline words according to channel language.,,,app_saycounted,,))
$(eval $(call BuildAsteriskModule,app-sayunixtime,Say Unix time,Say time.,,,app_sayunixtime,,))
$(eval $(call BuildAsteriskModule,app-senddtmf,Send DTMF digits,Send DTMF digits application.,,,app_senddtmf,,))
$(eval $(call BuildAsteriskModule,app-sendtext,Send text,Send text applications.,,,app_sendtext,,))
$(eval $(call BuildAsteriskModule,app-skel,Skeleton [sample],Skeleton application.,,app_skel.conf,app_skel,,))
$(eval $(call BuildAsteriskModule,app-sms,SMS,SMS/PSTN handler.,,,app_sms,,))
$(eval $(call BuildAsteriskModule,app-softhangup,Hang up requested channel,Hangs up the requested channel.,,,app_softhangup,,))
$(eval $(call BuildAsteriskModule,app-speech,Dialplan Speech,Dialplan speech applications.,+$(PKG_NAME)-res-speech,,app_speech_utils,,))
$(eval $(call BuildAsteriskModule,app-stack,Stack applications,Dialplan subroutines.,+$(PKG_NAME)-res-agi,,app_stack,,))
$(eval $(call BuildAsteriskModule,app-stasis,Stasis dialplan,Stasis dialplan application.,+$(PKG_NAME)-res-stasis,,app_stasis,,))
$(eval $(call BuildAsteriskModule,app-statsd,statsd dialplan,StatsD dialplan application.,+$(PKG_NAME)-res-statsd,,app_statsd,,))
$(eval $(call BuildAsteriskModule,app-stream-echo,Stream echo,Stream echo application.,,,app_stream_echo,,))
$(eval $(call BuildAsteriskModule,app-system,System exec,Generic system application.,,,app_system,,))
$(eval $(call BuildAsteriskModule,app-talkdetect,File playback with audio detect,Playback with talk detection.,,,app_talkdetect,,))
$(eval $(call BuildAsteriskModule,app-test,Interface test,Interface test application.,,,app_test,,))
$(eval $(call BuildAsteriskModule,app-transfer,Transfers caller to other ext,Transfers a caller to another extension.,,,app_transfer,,))
$(eval $(call BuildAsteriskModule,app-url,Send URL,Send URL applications.,,,app_url,,))
$(eval $(call BuildAsteriskModule,app-userevent,Custom user event,Custom user event application.,,,app_userevent,,))
$(eval $(call BuildAsteriskModule,app-verbose,Verbose logging,Send verbose output.,,,app_verbose,,))
$(eval $(call BuildAsteriskModule,app-waitforring,Wait for first ring,Waits until first ring after time.,,,app_waitforring,,))
$(eval $(call BuildAsteriskModule,app-waitforsilence,Wait for silence/noise,Wait for silence/noise.,,,app_waitforsilence,,))
$(eval $(call BuildAsteriskModule,app-waituntil,Sleep,Wait until specified time.,,,app_waituntil,,))
$(eval $(call BuildAsteriskModule,app-while,While loop,While loops and conditional execution.,,,app_while,,))
$(eval $(call BuildAsteriskModule,app-zapateller,Block telemarketers,Block telemarketers with special information tone.,,,app_zapateller,,))
$(eval $(call BuildAsteriskModule,bridge-builtin-features,Bridging features,Built in bridging features.,,,bridge_builtin_features,,))
$(eval $(call BuildAsteriskModule,bridge-builtin-interval-features,Built in bridging interval features,Built in bridging interval features.,,,bridge_builtin_interval_features,,))
$(eval $(call BuildAsteriskModule,bridge-holding,Bridging for storing channels in a bridge,Holding bridge module.,,,bridge_holding,,))
$(eval $(call BuildAsteriskModule,bridge-native-rtp,Native RTP bridging technology module,Native RTP bridging module.,,,bridge_native_rtp,,))
$(eval $(call BuildAsteriskModule,bridge-simple,Simple two channel bridging module,Simple two channel bridging module.,,,bridge_simple,,))
$(eval $(call BuildAsteriskModule,bridge-softmix,Multi-party software based channel mixing,Multi-party software based channel mixing.,,,bridge_softmix,,))
$(eval $(call BuildAsteriskModule,cdr,Provides CDR,Call Detail Records.,,cdr.conf cdr_custom.conf cdr_manager.conf cdr_syslog.conf,app_cdr app_forkcdr cdr_custom cdr_manager cdr_syslog func_cdr,,))
$(eval $(call BuildAsteriskModule,cdr-csv,Provides CDR CSV,Comma Separated Values CDR backend.,,,cdr_csv,,))
$(eval $(call BuildAsteriskModule,cdr-sqlite3,Provides CDR SQLITE3,SQLite3 CDR backend.,libsqlite3,,cdr_sqlite3_custom,,))
$(eval $(call BuildAsteriskModule,cel-custom,Customizable CSV CEL backend,Customizable Comma Separated Values CEL backend.,,cel_custom.conf,cel_custom,,))
$(eval $(call BuildAsteriskModule,cel-manager,AMI CEL backend,Asterisk Manager Interface CEL backend.,,,cel_manager,,))
$(eval $(call BuildAsteriskModule,cel-sqlite3-custom,SQLite3 custom CEL,SQLite3 custom CEL module.,,cel_sqlite3_custom.conf,cel_sqlite3_custom,,))
$(eval $(call BuildAsteriskModule,chan-alsa,ALSA channel,ALSA console channel driver.,+alsa-lib,alsa.conf,chan_alsa,,))
$(eval $(call BuildAsteriskModule,chan-bridge-media,Bridge media channel driver,Bridge media channel driver.,,,chan_bridge_media,,))
$(eval $(call BuildAsteriskModule,chan-console,Console channel driver,Console channel driver.,+portaudio,console.conf,chan_console,,))
$(eval $(call BuildAsteriskModule,chan-dahdi,DAHDI channel,DAHDI telephony.,+dahdi-tools-libtonezone +kmod-dahdi +libpri @!aarch64,chan_dahdi.conf,chan_dahdi,,))
$(eval $(call BuildAsteriskModule,chan-iax2,IAX2 channel,Inter Asterisk eXchange.,+$(PKG_NAME)-res-timing-timerfd,iax.conf iaxprov.conf,chan_iax2,,))
$(eval $(call BuildAsteriskModule,chan-mgcp,MGCP,Media Gateway Control Protocol.,,mgcp.conf,chan_mgcp,,))
$(eval $(call BuildAsteriskModule,chan-mobile,Bluetooth channel,Bluetooth mobile device channel driver.,+bluez-libs,chan_mobile.conf,chan_mobile,,))
$(eval $(call BuildAsteriskModule,chan-motif,Jingle channel,Motif Jingle channel driver.,+$(PKG_NAME)-res-xmpp,motif.conf,chan_motif,,))
$(eval $(call BuildAsteriskModule,chan-ooh323,H.323 channel,Objective Systems H.323 channel.,,ooh323.conf,chan_ooh323,,))
$(eval $(call BuildAsteriskModule,chan-oss,OSS channel,OSS console channel driver.,,oss.conf,chan_oss,,))
$(eval $(call BuildAsteriskModule,chan-phone,Linux telephony API,Linux telephony API support.,,phone.conf,chan_phone,,))
$(eval $(call BuildAsteriskModule,chan-rtp,RTP media channel,RTP media channel.,,,chan_rtp,,))
$(eval $(call BuildAsteriskModule,chan-sip,SIP channel,Session Initiation Protocol.,+$(PKG_NAME)-app-confbridge,sip.conf sip_notify.conf,chan_sip,,))
$(eval $(call BuildAsteriskModule,chan-skinny,Skinny channel,Skinny Client Control Protocol.,,skinny.conf,chan_skinny,,))
$(eval $(call BuildAsteriskModule,chan-unistim,Unistim channel,UNISTIM protocol.,,unistim.conf,chan_unistim,,))
$(eval $(call BuildAsteriskModule,codec-a-mu,Alaw to ulaw translation,Alaw and ulaw direct coder/decoder.,,,codec_a_mu,,))
$(eval $(call BuildAsteriskModule,codec-adpcm,ADPCM text,Adaptive Differential PCM coder/decoder.,,,codec_adpcm,,))
$(eval $(call BuildAsteriskModule,codec-alaw,Signed linear to alaw translation,Alaw coder/decoder.,,,codec_alaw,,))
$(eval $(call BuildAsteriskModule,codec-dahdi,DAHDI codec,Generic DAHDI transcoder codec translator.,+$(PKG_NAME)-chan-dahdi,,codec_dahdi,,))
$(eval $(call BuildAsteriskModule,codec-g722,G.722,ITU G.722-64kbps G722 transcoder.,,,codec_g722,,))
$(eval $(call BuildAsteriskModule,codec-g726,Signed linear to G.726 translation,ITU G.726-32kbps G726 transcoder.,,,codec_g726,,))
$(eval $(call BuildAsteriskModule,codec-gsm,linear to GSM translation,GSM coder/decoder.,,,codec_gsm,,))
$(eval $(call BuildAsteriskModule,codec-ilbc,linear to ILBC translation,iLBC coder/decoder.,,,codec_ilbc,,))
$(eval $(call BuildAsteriskModule,codec-lpc10,Linear to LPC10 translation,LPC10 2.4kbps coder/decoder.,,,codec_lpc10,,))
$(eval $(call BuildAsteriskModule,codec-resample,resample sLinear audio,SLIN resampling codec.,,,codec_resample,,))
$(eval $(call BuildAsteriskModule,codec-speex,Speex Coder/Decoder,Speex coder/decoder.,@!SOFT_FLOAT +libspeex +libspeexdsp,,codec_speex,,))
$(eval $(call BuildAsteriskModule,codec-ulaw,Signed linear to ulaw translation,Ulaw coder/decoder.,,,codec_ulaw,,))
$(eval $(call BuildAsteriskModule,curl,CURL,cURL support,+libcurl,,func_curl res_config_curl res_curl,,))
$(eval $(call BuildAsteriskModule,format-g719,G.719,ITU G.719.,,,format_g719,,))
$(eval $(call BuildAsteriskModule,format-g723,G.723.1,G.723.1 simple timestamp file format.,,,format_g723,,))
$(eval $(call BuildAsteriskModule,format-g726,G.726,Raw G.726 data.,,,format_g726,,))
$(eval $(call BuildAsteriskModule,format-g729,G.729,Raw G.729 data.,,,format_g729,,))
$(eval $(call BuildAsteriskModule,format-gsm,GSM format,Raw GSM data.,,,format_gsm,,))
$(eval $(call BuildAsteriskModule,format-h263,H263 format,Raw H.263 data.,,,format_h263,,))
$(eval $(call BuildAsteriskModule,format-h264,H264 format,Raw H.264 data.,,,format_h264,,))
$(eval $(call BuildAsteriskModule,format-ilbc,ILBC format,Raw iLBC data.,,,format_ilbc,,))
$(eval $(call BuildAsteriskModule,format-mp3,MP3 format,MP3 format.,@BROKEN,,format_mp3,,)) # requires patched mpg123 source
$(eval $(call BuildAsteriskModule,format-ogg-speex,OGG/Speex audio,OGG/Speex audio.,@!SOFT_FLOAT +libogg +libspeex,,format_ogg_speex,,))
$(eval $(call BuildAsteriskModule,format-ogg-vorbis,OGG/Vorbis audio,OGG/Vorbis audio.,+libvorbis,,format_ogg_vorbis,,))
$(eval $(call BuildAsteriskModule,format-pcm,PCM format,Raw/Sun ulaw/alaw 8KHz and G.722 16Khz.,,,format_pcm,,))
$(eval $(call BuildAsteriskModule,format-siren14,Siren14,ITU G.722.1 Annex C.,,,format_siren14,,))
$(eval $(call BuildAsteriskModule,format-siren7,Siren7,ITU G.722.1.,,,format_siren7,,))
$(eval $(call BuildAsteriskModule,format-sln,Raw slinear format,Raw signed linear audio support 8khz-192khz.,,,format_sln,,))
$(eval $(call BuildAsteriskModule,format-vox,VOX format,Dialogic VOX file format.,,,format_vox,,))
$(eval $(call BuildAsteriskModule,format-wav,WAV format (8000hz Signed Linear),Microsoft WAV/WAV16 format.,,,format_wav,,))
$(eval $(call BuildAsteriskModule,format-wav-gsm,WAV format (Proprietary GSM),Microsoft WAV format.,,,format_wav_gsm,,))
$(eval $(call BuildAsteriskModule,func-aes,AES dialplan functions,AES dialplan functions.,,,func_aes,,))
$(eval $(call BuildAsteriskModule,func-base64,base64 support,Base64 encode/decode dialplan functions.,,,func_base64,,))
$(eval $(call BuildAsteriskModule,func-blacklist,Blacklist on callerid,Look up Caller ID name/number from blacklist database.,,,func_blacklist,,))
$(eval $(call BuildAsteriskModule,func-callcompletion,Call control configuration function,Call control configuration function.,,,func_callcompletion,,))
$(eval $(call BuildAsteriskModule,func-channel,Channel info,Channel information dialplan functions.,,,func_channel,,))
$(eval $(call BuildAsteriskModule,func-config,Configuration file variable access,Asterisk configuration file variable access.,,,func_config,,))
$(eval $(call BuildAsteriskModule,func-cut,CUT function,Cut out information from a string.,,,func_cut,,))
$(eval $(call BuildAsteriskModule,func-db,Database interaction,Database related dialplan functions.,,,func_db app_db,,))
$(eval $(call BuildAsteriskModule,func-devstate,Blinky lights control,Gets or sets a device state in the dialplan.,,,func_devstate,,))
$(eval $(call BuildAsteriskModule,func-dialgroup,Dialgroup dialplan function,Dialgroup dialplan function.,,,func_dialgroup,,))
$(eval $(call BuildAsteriskModule,func-dialplan,Dialplan context/extension/priority checking functions,Dialplan context/extension/priority checking functions.,,,func_dialplan,,))
$(eval $(call BuildAsteriskModule,func-enum,ENUM,ENUM related dialplan functions.,,enum.conf,func_enum,,))
$(eval $(call BuildAsteriskModule,func-env,Environment functions,Environment/filesystem dialplan functions.,,,func_env,,))
$(eval $(call BuildAsteriskModule,func-extstate,Hinted extension state,Gets the state of an extension in the dialplan.,,,func_extstate,,))
$(eval $(call BuildAsteriskModule,func-frame-trace,Frame trace for internal ast_frame debugging,Frame trace for internal ast_frame debugging.,,,func_frame_trace,,))
$(eval $(call BuildAsteriskModule,func-global,Global variable,Variable dialplan functions.,,,func_global,,))
$(eval $(call BuildAsteriskModule,func-groupcount,Group count,Channel group dialplan functions.,,,func_groupcount,,))
$(eval $(call BuildAsteriskModule,func-hangupcause,HANGUPCAUSE related functions,Hangup cause related functions and applications.,,,func_hangupcause,,))
$(eval $(call BuildAsteriskModule,func-holdintercept,Hold interception dialplan function,Hold interception dialplan function.,,,func_holdintercept,,))
$(eval $(call BuildAsteriskModule,func-iconv,Charset conversion,Charset conversions.,,,func_iconv,,,$(ICONV_DEPENDS)))
$(eval $(call BuildAsteriskModule,func-jitterbuffer,Jitter buffer for read side of channel,Jitter buffer for read side of channel.,,,func_jitterbuffer,,))
$(eval $(call BuildAsteriskModule,func-lock,Dialplan mutexes,Dialplan mutexes.,,,func_lock,,))
$(eval $(call BuildAsteriskModule,func-math,Math functions,Mathematical dialplan function.,,,func_math,,))
$(eval $(call BuildAsteriskModule,func-md5,MD5 digest dialplan functions,MD5 digest dialplan functions.,,,func_md5,,))
$(eval $(call BuildAsteriskModule,func-module,Simple module check function,Checks if Asterisk module is loaded in memory.,,,func_module,,))
$(eval $(call BuildAsteriskModule,func-periodic-hook,Periodic dialplan hooks,Periodic dialplan hooks.,+$(PKG_NAME)-app-chanspy +$(PKG_NAME)-func-cut +$(PKG_NAME)-func-groupcount +$(PKG_NAME)-func-uri,,func_periodic_hook,,))
$(eval $(call BuildAsteriskModule,func-pitchshift,Audio effects dialplan functions,Audio effects dialplan functions.,,,func_pitchshift,,))
$(eval $(call BuildAsteriskModule,func-presencestate,Hinted presence state,Gets or sets a presence state in the dialplan.,,,func_presencestate,,))
$(eval $(call BuildAsteriskModule,func-rand,RAND dialplan function,Random number dialplan function.,,,func_rand,,))
$(eval $(call BuildAsteriskModule,func-realtime,REALTIME dialplan function,Read/write/store/destroy values from a realtime repository.,,,func_realtime,,))
$(eval $(call BuildAsteriskModule,func-sha1,SHA-1 computation dialplan function,SHA-1 computation dialplan function.,,,func_sha1,,))
$(eval $(call BuildAsteriskModule,func-shell,Shell,Collects the output generated by a command executed by the system shell.,,,func_shell,,))
$(eval $(call BuildAsteriskModule,func-sorcery,Get a field from a sorcery object,Get a field from a sorcery object.,,,func_sorcery,,))
$(eval $(call BuildAsteriskModule,func-speex,Noise reduction and AGC,Noise reduction and Automatic Gain Control.,@!SOFT_FLOAT +libspeex +libspeexdsp,,func_speex,,))
$(eval $(call BuildAsteriskModule,func-sprintf,SPRINTF dialplan function,SPRINTF dialplan function.,,,func_sprintf,,))
$(eval $(call BuildAsteriskModule,func-srv,SRV functions,SRV related dialplan functions.,,,func_srv,,))
$(eval $(call BuildAsteriskModule,func-sysinfo,System information related functions,System information related functions.,,,func_sysinfo,,))
$(eval $(call BuildAsteriskModule,func-talkdetect,Talk detection dialplan function,Talk detection dialplan function.,,,func_talkdetect,,))
$(eval $(call BuildAsteriskModule,func-uri,URI encoding and decoding,URI encode/decode dialplan functions.,,,func_uri,,))
$(eval $(call BuildAsteriskModule,func-version,Get Asterisk version/build info,Get Asterisk version/build info.,,,func_version,,))
$(eval $(call BuildAsteriskModule,func-vmcount,vmcount dialplan,Indicator for whether a voice mailbox has messages in a given folder.,,,func_vmcount,,))
$(eval $(call BuildAsteriskModule,func-volume,Technology independent volume control,Technology independent volume control.,,,func_volume,,))
$(eval $(call BuildAsteriskModule,odbc,ODBC,ODBC support.,+libpthread +libc +unixodbc,cdr_adaptive_odbc.conf cdr_odbc.conf cel_odbc.conf func_odbc.conf res_odbc.conf,cdr_adaptive_odbc cdr_odbc cel_odbc func_odbc res_config_odbc res_odbc res_odbc_transaction,,))
$(eval $(call BuildAsteriskModule,pbx-ael,Asterisk Extension Logic,Asterisk Extension Language compiler.,+$(PKG_NAME)-res-ael-share,extensions.ael,pbx_ael,,))
$(eval $(call BuildAsteriskModule,pbx-dundi,Dundi,Distributed Universal Number Discovery.,,dundi.conf,pbx_dundi,,))
$(eval $(call BuildAsteriskModule,pbx-loopback,Loopback switch,Loopback switch.,,,pbx_loopback,,))
$(eval $(call BuildAsteriskModule,pbx-lua,Lua,Lua PBX switch.,+liblua,extensions.lua,pbx_lua,,))
$(eval $(call BuildAsteriskModule,pbx-realtime,Realtime Switch,Realtime switch.,,,pbx_realtime,,))
$(eval $(call BuildAsteriskModule,pbx-spool,Call Spool,Outgoing spool support.,,,pbx_spool,,))
$(eval $(call BuildAsteriskModule,pgsql,PostgreSQL,PostgreSQL support.,+libpq,cel_pgsql.conf cdr_pgsql.conf res_pgsql.conf,cel_pgsql cdr_pgsql res_config_pgsql,,))
$(eval $(call BuildAsteriskModule,pjsip,pjsip channel,PJSIP SIP stack.,+$(PKG_NAME)-res-http-websocket +$(PKG_NAME)-res-pjproject +$(PKG_NAME)-res-sorcery +libpjsip +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsua +libpjsua2,pjsip.conf pjsip_notify.conf pjsip_wizard.conf,chan_pjsip func_pjsip_aor func_pjsip_contact func_pjsip_endpoint res_pjsip res_pjsip_acl res_pjsip_authenticator_digest res_pjsip_caller_id res_pjsip_config_wizard res_pjsip_dialog_info_body_generator res_pjsip_diversion res_pjsip_dlg_options res_pjsip_dtmf_info res_pjsip_empty_info res_pjsip_endpoint_identifier_anonymous res_pjsip_endpoint_identifier_ip res_pjsip_endpoint_identifier_user res_pjsip_exten_state res_pjsip_header_funcs res_pjsip_history res_pjsip_logger res_pjsip_messaging res_pjsip_mwi res_pjsip_mwi_body_generator res_pjsip_nat res_pjsip_notify res_pjsip_one_touch_record_info res_pjsip_outbound_authenticator_digest res_pjsip_outbound_publish res_pjsip_outbound_registration res_pjsip_path res_pjsip_pidf_body_generator res_pjsip_pidf_digium_body_supplement res_pjsip_pidf_eyebeam_body_supplement res_pjsip_publish_asterisk res_pjsip_pubsub res_pjsip_refer res_pjsip_registrar res_pjsip_rfc3326 res_pjsip_sdp_rtp res_pjsip_send_to_voicemail res_pjsip_session res_pjsip_sips_contact res_pjsip_t38 res_pjsip_transport_websocket res_pjsip_xpidf_body_generator,,))
$(eval $(call BuildAsteriskModule,res-adsi,Provide ADSI,ADSI resource.,,,res_adsi,,))
$(eval $(call BuildAsteriskModule,res-ael-share,Shareable AEL code,Shareable code for AEL.,,,res_ael_share,,))
$(eval $(call BuildAsteriskModule,res-agi,Asterisk Gateway Interface,Asterisk Gateway Interface.,+$(PKG_NAME)-res-speech,,res_agi,,))
$(eval $(call BuildAsteriskModule,res-ari,Asterisk RESTful interface,Asterisk RESTful Interface.,+$(PKG_NAME)-res-http-websocket,ari.conf,res_ari,,))
$(eval $(call BuildAsteriskModule,res-ari-applications,RESTful Stasis application resources,RESTful API module - Stasis application resources.,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis,,res_ari_applications,))
$(eval $(call BuildAsteriskModule,res-ari-asterisk,RESTful Asterisk resources,RESTful API module - Asterisk resources.,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis,,res_ari_asterisk,,))
$(eval $(call BuildAsteriskModule,res-ari-bridges,RESTful bridge resources,RESTful API module - bridge resources.,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-playback,,res_ari_bridges,,))
$(eval $(call BuildAsteriskModule,res-ari-channels,RESTful channel resources,RESTful API module - channel resources.,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-answer +$(PKG_NAME)-res-stasis-playback +$(PKG_NAME)-res-stasis-snoop,,res_ari_channels,,))
$(eval $(call BuildAsteriskModule,res-ari-device-states,RESTful device state resources,RESTful API module - device state resources.,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-device-state,,res_ari_device_states,,))
$(eval $(call BuildAsteriskModule,res-ari-endpoints,RESTful endpoint resources,RESTful API module - endpoint resources.,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis,,res_ari_endpoints,,))
$(eval $(call BuildAsteriskModule,res-ari-events,RESTful WebSocket resource,RESTful API module - WebSocket resource.,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis,,res_ari_events,,))
$(eval $(call BuildAsteriskModule,res-ari-mailboxes,RESTful mailboxes resources,RESTful API module - mailboxes resources.,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-mailbox,,res_ari_mailboxes,,))
$(eval $(call BuildAsteriskModule,res-ari-model,ARI model validators,ARI model validators.,,,res_ari_model,,))
$(eval $(call BuildAsteriskModule,res-ari-playbacks,RESTful playback control resources,RESTful API module - playback control resources.,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-playback,,res_ari_playbacks,,))
$(eval $(call BuildAsteriskModule,res-ari-recordings,RESTful recording resources,RESTful API module - recording resources.,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis-recording,,res_ari_recordings,,))
$(eval $(call BuildAsteriskModule,res-ari-sounds,RESTful sound resources,RESTful API module - sound resources.,+$(PKG_NAME)-res-ari +$(PKG_NAME)-res-ari-model +$(PKG_NAME)-res-stasis,,res_ari_sounds,))
$(eval $(call BuildAsteriskModule,res-calendar,Calendar API,Asterisk calendar integration.,,calendar.conf,res_calendar,,))
$(eval $(call BuildAsteriskModule,res-calendar-caldav,CalDAV calendar,Asterisk CalDAV calendar integration.,+$(PKG_NAME)-res-calendar +libical +libneon +libxml2,,res_calendar_caldav,,))
$(eval $(call BuildAsteriskModule,res-calendar-ews,EWS calendar,Asterisk MS Exchange Web Service calendar integration.,+$(PKG_NAME)-res-calendar +libneon,,res_calendar_ews,,))
$(eval $(call BuildAsteriskModule,res-calendar-exchange,Exchange calendar,Asterisk MS Exchange calendar integration.,+$(PKG_NAME)-res-calendar +libical +libiksemel +libneon,,res_calendar_exchange,,))
$(eval $(call BuildAsteriskModule,res-calendar-icalendar,iCalendar calendar,Asterisk iCalendar .ics file integration.,+$(PKG_NAME)-res-calendar +libical +libneon,,res_calendar_icalendar,,))
$(eval $(call BuildAsteriskModule,res-chan-stats,statsd channel stats,Example of how to use Stasis.,+$(PKG_NAME)-res-statsd,,res_chan_stats,,))
$(eval $(call BuildAsteriskModule,res-clialiases,CLI aliases,CLI aliases.,,cli_aliases.conf,res_clialiases,,))
$(eval $(call BuildAsteriskModule,res-clioriginate,Calls via CLI,Call origination and redirection from the CLI.,,,res_clioriginate,,))
$(eval $(call BuildAsteriskModule,res-config-ldap,LDAP realtime interface,LDAP realtime interface.,+libopenldap,res_ldap.conf,res_config_ldap,,))
$(eval $(call BuildAsteriskModule,res-config-mysql,MySQL CDR backend,MySQL realtime configuration driver.,+libmysqlclient,,res_config_mysql,,))
$(eval $(call BuildAsteriskModule,res-config-sqlite3,SQLite 3 realtime config engine,SQLite3 realtime config engine.,,,res_config_sqlite3,,))
$(eval $(call BuildAsteriskModule,res-convert,File format conversion CLI command,File format conversion CLI command.,,,res_convert,,))
$(eval $(call BuildAsteriskModule,res-endpoint-stats,Endpoint statistics,Endpoint statistics.,+$(PKG_NAME)-res-statsd,,res_endpoint_stats,,))
$(eval $(call BuildAsteriskModule,res-hep,HEPv3 API,HEPv3 API.,,hep.conf,res_hep,,))
$(eval $(call BuildAsteriskModule,res-hep-pjsip,PJSIP HEPv3 Logger,PJSIP HEPv3 logger.,+$(PKG_NAME)-res-hep +$(PKG_NAME)-pjsip,,res_hep_pjsip,,))
$(eval $(call BuildAsteriskModule,res-hep-rtcp,RTCP HEPv3 Logger,RTCP HEPv3 logger.,+$(PKG_NAME)-res-hep,,res_hep_rtcp,,))
$(eval $(call BuildAsteriskModule,res-fax-spandsp,Spandsp T.38 and G.711,Spandsp G.711 and T.38 FAX technologies.,+$(PKG_NAME)-res-fax +libspandsp +libtiff,,res_fax_spandsp,,))
$(eval $(call BuildAsteriskModule,res-fax,FAX modules,Generic FAX applications.,+$(PKG_NAME)-res-timing-pthread,res_fax.conf,res_fax,,))
$(eval $(call BuildAsteriskModule,res-format-attr-celt,CELT format attribute module,CELT format attribute module.,,,res_format_attr_celt,,))
$(eval $(call BuildAsteriskModule,res-format-attr-g729,G.729 format attribute module,G.729 format attribute module.,,,res_format_attr_g729,,))
$(eval $(call BuildAsteriskModule,res-format-attr-h263,H.263 format attribute module,H.263 format attribute module.,,,res_format_attr_h263,,))
$(eval $(call BuildAsteriskModule,res-format-attr-h264,H.264 format attribute module,H.264 format attribute module.,,,res_format_attr_h264,,))
$(eval $(call BuildAsteriskModule,res-format-attr-ilbc,ILBC format attribute module,iLBC format attribute module.,,,res_format_attr_ilbc,,))
$(eval $(call BuildAsteriskModule,res-format-attr-opus,Opus format attribute module,Opus format attribute module.,,,res_format_attr_opus,,))
$(eval $(call BuildAsteriskModule,res-format-attr-silk,SILK format attribute module,SILK format attribute module.,,,res_format_attr_silk,,))
$(eval $(call BuildAsteriskModule,res-format-attr-siren14,Siren14 format attribute module,Siren14 format attribute module.,,,res_format_attr_siren14,,))
$(eval $(call BuildAsteriskModule,res-format-attr-siren7,Siren7 format attribute module,Siren7 format attribute module.,,,res_format_attr_siren7,,))
$(eval $(call BuildAsteriskModule,res-format-attr-vp8,VP8 format attribute module,VP8 format attribute module.,,,res_format_attr_vp8,,))
$(eval $(call BuildAsteriskModule,res-http-media-cache,HTTP media cache backend,HTTP media cache backend.,+$(PKG_NAME)-curl,,res_http_media_cache,,))
$(eval $(call BuildAsteriskModule,res-http-websocket,HTTP websocket support,HTTP WebSocket support.,,,res_http_websocket,,))
$(eval $(call BuildAsteriskModule,res-limit,Resource limits,Resource limits.,,,res_limit,,))
$(eval $(call BuildAsteriskModule,res-manager-devicestate,Device state topic forwarder,Manager device state topic forwarder.,,,res_manager_devicestate,,))
$(eval $(call BuildAsteriskModule,res-manager-presencestate,Presence state topic forwarder,Manager presence state topic forwarder.,,,res_manager_presencestate,,))
$(eval $(call BuildAsteriskModule,res-monitor,PBX channel monitoring,Call monitoring resource.,,,res_monitor,,))
$(eval $(call BuildAsteriskModule,res-musiconhold,MOH,Music On Hold resource.,,musiconhold.conf,res_musiconhold,,))
$(eval $(call BuildAsteriskModule,res-mutestream,Mute audio stream resources,Mute audio stream resources.,,,res_mutestream,,))
$(eval $(call BuildAsteriskModule,res-mwi-devstate,MWI device state subs,This module allows presence subscriptions to voicemail boxes. This\nallows common BLF keys to act as voicemail waiting indicators.,,,res_mwi_devstate,,))
$(eval $(call BuildAsteriskModule,res-mwi-external,Core external MWI resource,Core external MWI resource.,,,res_mwi_external,,))
$(eval $(call BuildAsteriskModule,res-mwi-external-ami,AMI for external MWI,AMI support for external MWI.,+$(PKG_NAME)-res-mwi-external,,res_mwi_external_ami,,))
$(eval $(call BuildAsteriskModule,res-parking,Phone Parking,Call parking resource.,+$(PKG_NAME)-bridge-holding,res_parking.conf,res_parking,,))
$(eval $(call BuildAsteriskModule,res-phoneprov,Phone Provisioning,HTTP phone provisioning.,,phoneprov.conf,res_phoneprov,,))
$(eval $(call BuildAsteriskModule,res-pjsip-phoneprov,PJSIP Phone Provisioning,PJSIP phone provisioning.,+$(PKG_NAME)-pjsip +$(PKG_NAME)-res-phoneprov,,res_pjsip_phoneprov_provider,,))
$(eval $(call BuildAsteriskModule,res-pjproject,Bridge PJPROJECT to Asterisk logging,PJProject log and utility support.,+libpj +libpjlib-util +libpjmedia +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsip +libpjsua +libpjsua2 +libsrtp2,pjproject.conf,res_pjproject,,))
$(eval $(call BuildAsteriskModule,res-pktccops,PktcCOPS manager for MGCP,PktcCOPS manager for MGCP.,,res_pktccops.conf,res_pktccops,,))
$(eval $(call BuildAsteriskModule,res-realtime,RealTime CLI,Realtime data lookup/rewrite.,,,res_realtime,,))
$(eval $(call BuildAsteriskModule,res-remb-modifier,REMB modifier,REMB modifier module.,,,res_remb_modifier,,))
$(eval $(call BuildAsteriskModule,res-resolver-unbound,Unbound DNS resolver,Unbound DNS resolver support.,+libunbound,resolver_unbound.conf,res_resolver_unbound,,))
$(eval $(call BuildAsteriskModule,res-rtp-asterisk,RTP stack,Asterisk RTP stack.,+libpjsip +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsua +libpjsua2,rtp.conf,res_rtp_asterisk,,))
$(eval $(call BuildAsteriskModule,res-rtp-multicast,RTP multicast engine,Multicast RTP engine.,,,res_rtp_multicast,,))
$(eval $(call BuildAsteriskModule,res-security-log,Security event logging,Security event logging.,,,res_security_log,,))
$(eval $(call BuildAsteriskModule,res-smdi,Provide SMDI,Simplified Message Desk Interface resource.,,smdi.conf,res_smdi,,))
$(eval $(call BuildAsteriskModule,res-snmp,SNMP [Sub]Agent for Asterisk,SNMP agent for Asterisk.,+libnetsnmp,res_snmp.conf,res_snmp,,))
$(eval $(call BuildAsteriskModule,res-sorcery,Sorcery data layer,Sorcery backend modules for data access intended for using realtime as\nbackend.,,sorcery.conf,res_sorcery_astdb res_sorcery_config res_sorcery_memory res_sorcery_realtime,,))
$(eval $(call BuildAsteriskModule,res-sorcery-memory-cache,Sorcery memory cache object wizard,Sorcery memory cache object wizard.,,,res_sorcery_memory_cache,,))
$(eval $(call BuildAsteriskModule,res-speech,Speech Recognition API,Generic speech recognition API.,,,res_speech,,))
$(eval $(call BuildAsteriskModule,res-srtp,SRTP Support,Secure RTP.,+libsrtp2,,res_srtp,,))
$(eval $(call BuildAsteriskModule,res-stasis,Stasis application,Stasis application support.,,,res_stasis,,))
$(eval $(call BuildAsteriskModule,res-stasis-answer,Stasis application answer,Stasis application answer support.,+$(PKG_NAME)-res-stasis,,res_stasis_answer,,))
$(eval $(call BuildAsteriskModule,res-stasis-device-state,Stasis application device state,Stasis application device state support.,+$(PKG_NAME)-res-stasis,,res_stasis_device_state,,))
$(eval $(call BuildAsteriskModule,res-stasis-mailbox,Stasis application mailbox,Stasis application mailbox support.,+$(PKG_NAME)-res-stasis +$(PKG_NAME)-res-mwi-external,,res_stasis_mailbox,,))
$(eval $(call BuildAsteriskModule,res-stasis-playback,Stasis application playback,Stasis application playback support.,+$(PKG_NAME)-res-stasis-recording,,res_stasis_playback,,))
$(eval $(call BuildAsteriskModule,res-stasis-recording,Stasis application recording,Stasis application recording support.,+$(PKG_NAME)-res-stasis,,res_stasis_recording,,))
$(eval $(call BuildAsteriskModule,res-stasis-snoop,Stasis application snoop,Stasis application snoop support.,+$(PKG_NAME)-res-stasis-recording,,res_stasis_snoop,,))
$(eval $(call BuildAsteriskModule,res-statsd,statsd client,Statsd client support.,,statsd.conf,res_statsd,,))
$(eval $(call BuildAsteriskModule,res-stun-monitor,STUN monitoring,STUN network monitor.,,res_stun_monitor.conf,res_stun_monitor,,))
$(eval $(call BuildAsteriskModule,res-timing-dahdi,DAHDI Timing Interface,DAHDI timing interface.,+$(PKG_NAME)-chan-dahdi,,res_timing_dahdi,,))
$(eval $(call BuildAsteriskModule,res-timing-pthread,pthread Timing Interface,pthread timing interface.,,,res_timing_pthread,,))
$(eval $(call BuildAsteriskModule,res-timing-timerfd,Timerfd Timing Interface,Timerfd timing interface.,,,res_timing_timerfd,,))
$(eval $(call BuildAsteriskModule,res-xmpp,XMPP client and component module,Asterisk XMPP interface.,+libiksemel +libopenssl,xmpp.conf,res_xmpp,,))
$(eval $(call BuildAsteriskModule,voicemail,Voicemail,Voicemail modules.,+$(PKG_NAME)-res-adsi +$(PKG_NAME)-res-smdi,voicemail.conf,app_voicemail,vm-*,))

################################
# AST utils
# Params:
# 1 - Utility name
# 2 - Description
# 3 - Dependencies
# 4 - Configuration files
################################
# $(eval $(call BuildAsteriskUtil,Utility,Description,Dependencies,Configuration Files))

$(eval $(call BuildAsteriskUtil,aelparse,Check extensions.ael file.,+$(PKG_NAME)-pbx-ael,))
$(eval $(call BuildAsteriskUtil,astcanary,Assures Asterisk no threads have gone missing.,,))
$(eval $(call BuildAsteriskUtil,astdb2sqlite3,Convert astdb to SQLite 3.,,))
$(eval $(call BuildAsteriskUtil,astdb2bdb,Convert astdb back to Berkeley DB 1.86.,,))
$(eval $(call BuildAsteriskUtil,check_expr,Expression checker [older version].,,))
$(eval $(call BuildAsteriskUtil,check_expr2,Expression checker [newer version].,,))
$(eval $(call BuildAsteriskUtil,conf2ael,Convert .conf to .ael.,+$(PKG_NAME)-pbx-ael,))
$(eval $(call BuildAsteriskUtil,muted,Listens for AMI events. Mutes soundcard during call.,,muted.conf))
$(eval $(call BuildAsteriskUtil,smsq,Send messages from command line.,+libpopt,))
$(eval $(call BuildAsteriskUtil,stereorize,Merge two mono WAV-files to one stereo WAV-file.,,))
$(eval $(call BuildAsteriskUtil,streamplayer,A utility for reading from a raw TCP stream [MOH source].,,))
