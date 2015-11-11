#
# Copyright (C) 2015 OpenWrt.org
# Copyright (C) 2015 Cesnet, z.s.p.o.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asterisk18
PKG_VERSION:=1.8.32.3
PKG_RELEASE:=4

PKG_SOURCE:=asterisk-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://downloads.asterisk.org/pub/telephony/asterisk/releases/
PKG_MD5SUM:=f13f126e7730710223f2fbbc8832966f

PKG_BUILD_DIR=$(BUILD_DIR)/asterisk-$(PKG_VERSION)

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING LICENSE
PKG_MAINTAINER:=Jiri Slachta <slachta@cesnet.cz>

include $(INCLUDE_DIR)/package.mk

define Package/asterisk18/install/module
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/asterisk/modules/*$(2).so* $(1)/usr/lib/asterisk/modules/
endef

define Package/asterisk18/install/conffile
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(CP) $(PKG_INSTALL_DIR)/etc/asterisk/*$(2)* $(1)/etc/asterisk/
endef

define Package/asterisk18/install/lib
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/$(2).so* $(1)/usr/lib/
endef

define Package/asterisk18/install/sbin
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/$(2) $(1)/usr/sbin/
endef

define Package/asterisk18/install/sounds
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/sounds/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/asterisk/sounds/en/$(2) $(1)/usr/lib/asterisk/sounds/
endef

define BuildAsterisk18Module
  define Package/asterisk18-$(1)
  $$(call Package/asterisk18/Default)
    TITLE:=$(2) support
    DEPENDS:= asterisk18 $(patsubst +%,+PACKAGE_asterisk18-$(1):%,$(4))
  endef

  define Package/asterisk18-$(1)/conffiles
$(5)
  endef

  define Package/asterisk18-$(1)/description
This package provides support for '$(3)' in Asterisk.
  endef

  define Package/asterisk18-$(1)/install
$(foreach c,$(6),$(call Package/asterisk18/install/conffile,$$(1),$(c));)
$(foreach m,$(7),$(call Package/asterisk18/install/module,$$(1),$(m));)
$(foreach s,$(8),$(call Package/asterisk18/install/sounds,$$(1),$(s));)
$(foreach b,$(9),$(call Package/asterisk18/install/sbin,$$(1),$(b));)
  endef

  $$(eval $$(call BuildPackage,asterisk18-$(1)))
endef

define Package/asterisk18/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=http://www.asterisk.org/
endef

define Package/asterisk18/Default/description
 Asterisk is a complete PBX in software. It provides all of the features
 you would expect from a PBX and more. Asterisk does voice over IP in three
 protocols, and can interoperate with almost all standards-based telephony
 equipment using relatively inexpensive hardware.
endef

define Package/asterisk18
$(call Package/asterisk18/Default)
  TITLE:=Complete open source PBX, v1.8.x
  MENU:=1
  DEPENDS:=+libopenssl +libncurses +libpopt +libpthread +zlib @!TARGET_avr32
endef

define Package/asterisk18/description
$(call Package/asterisk18/Default/description)
endef

define Package/asterisk18/conffiles
/etc/asterisk/cel.conf
/etc/asterisk/asterisk.conf
/etc/asterisk/modules.conf
/etc/asterisk/extensions.conf
/etc/asterisk/sip.conf
/etc/asterisk/sip_notify.conf
/etc/asterisk/features.conf
/etc/asterisk/indications.conf
/etc/asterisk/logger.conf
/etc/asterisk/manager.conf
/etc/asterisk/rtp.conf
/etc/init.d/asterisk
endef

AST_CFG_FILES:=\
	asterisk.conf cel.conf ccss.conf extensions.conf features.conf indications.conf logger.conf manager.conf \
	modules.conf sip.conf sip_notify.conf rtp.conf users.conf
AST_EMB_MODULES:=\
	app_dial app_echo app_macro app_playback codec_ulaw codec_gsm format_gsm format_pcm format_wav format_wav_gsm \
	func_strings func_timeout func_callerid func_logic chan_sip pbx_config res_rtp_asterisk res_rtp_multicast

define Package/asterisk18/install
$(call Package/asterisk18/install/sbin,$(1),asterisk)
$(foreach m,$(AST_CFG_FILES),$(call Package/asterisk18/install/conffile,$(1),$(m));)
$(foreach m,$(AST_EMB_MODULES),$(call Package/asterisk18/install/module,$(1),$(m));)
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/asterisk.init $(1)/etc/init.d/asterisk
endef

define Package/asterisk18-sounds
$(call Package/asterisk18/Default)
  TITLE:=Sounds support
  DEPENDS:=asterisk18
endef

define Package/asterisk18-sounds/description
This package provides sound-files for Asterisk-1.8.x.
endef

define Package/asterisk18-sounds/install
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/sounds/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/asterisk/sounds/en/* $(1)/usr/lib/asterisk/sounds/
	rm -f $(1)/usr/lib/asterisk/sounds/vm-*
	rm -f $(1)/usr/lib/asterisk/sounds/conf-*
endef

ifneq ($(SDK)$(CONFIG_PACKAGE_asterisk18-chan-dahdi),)
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

ifneq ($(SDK)$(CONFIG_PACKAGE_asterisk18-chan-gtalk),)
  CONFIGURE_ARGS+= \
	--with-iksemel="$(STAGING_DIR)/usr"
  SITE_VARS+= \
	ac_cv_lib_iksemel_iks_start_sasl=yes
else
  CONFIGURE_ARGS+= \
	--without-iksemel
endif

ifneq ($(SDK)$(CONFIG_PACKAGE_asterisk18-curl),)
  CONFIGURE_ARGS+= \
	--with-libcurl="$(STAGING_DIR)/usr"
else
  CONFIGURE_ARGS+= \
	--without-libcurl
endif

ifneq ($(SDK)$(CONFIG_PACKAGE_asterisk18-mysql),)
  CONFIGURE_ARGS+= \
	--with-mysqlclient="$(STAGING_DIR)/usr"
else
  CONFIGURE_ARGS+= \
	--without-mysqlclient
endif

ifneq ($(SDK)$(CONFIG_PACKAGE_asterisk18-pbx-lua),)
  CONFIGURE_ARGS+= \
	--with-lua="$(STAGING_DIR)/usr"
  TARGET_LDFLAGS+=-ldl -lcrypt
else
  CONFIGURE_ARGS+= \
	--without-lua
endif

ifneq ($(SDK)$(CONFIG_PACKAGE_asterisk18-pgsql),)
  CONFIGURE_ARGS+= \
	--with-postgres="$(STAGING_DIR)/usr"
else
  CONFIGURE_ARGS+= \
	--without-postgres
endif

ifneq ($(SDK)$(CONFIG_PACKAGE_asterisk18-res-fax-spandsp),)
  CONFIGURE_ARGS+= \
	--with-spandsp="$(STAGING_DIR)/usr"
else
  CONFIGURE_ARGS+= \
	--without-spandsp
endif

ifneq ($(SDK)$(CONFIG_PACKAGE_asterisk18-res-srtp),)
  CONFIGURE_ARGS+= \
	--with-srtp="$(STAGING_DIR)/usr"
else
  CONFIGURE_ARGS+= \
	--without-srtp
endif

EXTRA_CFLAGS+= $(TARGET_CPPFLAGS)
EXTRA_LDFLAGS+= $(TARGET_LDFLAGS)
CONFIGURE_ARGS+= \
	--without-curses \
	--with-gsm=internal \
	--without-bluetooth \
	--without-cap \
	--without-gtk2 \
	--without-isdnnet \
	--without-misdn \
	--without-nbs \
	--with-ncurses="$(STAGING_DIR)/usr" \
	--without-neon \
	--without-neon29 \
	--without-netsnmp \
	--without-newt \
	--without-ogg \
	--without-osptk \
	--with-popt="$(STAGING_DIR)/usr" \
	--without-radius \
	--without-sdl \
	--without-suppserv \
	--without-tds \
	--without-termcap \
	--without-tinfo \
	--without-vorbis \
	--without-vpb \
	--with-z="$(STAGING_DIR)/usr" \
	--with-sounds-cache="$(DL_DIR)" \
	--disable-xmldoc

define Build/Prepare
	$(call Build/Prepare/Default)
ifneq ($(CONFIG_TARGET_lantiq),)
ifneq ($(CONFIG_TARGET_lantiq_xrx200),y)
	$(CP) ./src-lantiq/* $(PKG_BUILD_DIR)/
endif
endif
endef

define Build/Configure
	$(call Build/Configure/Default,,$(SITE_VARS))
endef

define Build/Compile
	$(MAKE) -C "$(PKG_BUILD_DIR)" \
		include/asterisk/version.h \
		include/asterisk/buildopts.h defaults.h \
		makeopts.embed_rules
	ASTCFLAGS="$(EXTRA_CFLAGS) -DLOW_MEMORY" \
	ASTLDFLAGS="$(EXTRA_LDFLAGS)" \
	$(MAKE) -C "$(PKG_BUILD_DIR)" \
		ASTVARLIBDIR="/usr/lib/asterisk" \
		ASTDATADIR="/usr/lib/asterisk" \
		ASTKEYDIR="/usr/lib/asterisk" \
		ASTDBDIR="/usr/lib/asterisk" \
		NOISY_BUILD="1" \
		DEBUG="" \
		OPTIMIZE="" \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install samples
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/asterisk-1.8/include/asterisk/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/asterisk/*.h $(1)/usr/include/asterisk-1.8/include/asterisk/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/asterisk.h $(1)/usr/include/asterisk-1.8/include/
endef

$(eval $(call BuildPackage,asterisk18))
$(eval $(call BuildPackage,asterisk18-sounds))

################################
# AST modules
# Params:
# 1 - Package subname
# 2 - Package title
# 3 - Module description
# 4 - Module dependencies
# 5 - Full path to multiple conffiles
# 6 - conf files
# 7 - module files
# 8 - sound files
# 9 - binary files
################################

$(eval $(call BuildAsterisk18Module,app-alarmreceiver,Alarm receiver,Central Station Alarm receiver for Ademco Contact ID,,,,app_alarmreceiver,))
$(eval $(call BuildAsterisk18Module,app-authenticate,Authenticate commands,Execute arbitrary authenticate commands,,,,app_authenticate,))
$(eval $(call BuildAsterisk18Module,app-dahdiras,Execute an ISDN RAS,support for executing an ISDN RAS using DAHDI,+asterisk18-chan-dahdi,,,app_dahdiras,))
$(eval $(call BuildAsterisk18Module,app-directed_pickup,Directed call pickup,support for directed call pickup,,,,app_directed_pickup,))
$(eval $(call BuildAsterisk18Module,app-disa,Direct Inward System Access,Direct Inward System Access,,,,app_disa,))
$(eval $(call BuildAsterisk18Module,app-exec,Exec application,support for application execution,,,,app_exec,))
$(eval $(call BuildAsterisk18Module,app-chanisavail,Channel availability check,support for checking if a channel is available,,,,app_chanisavail,))
$(eval $(call BuildAsterisk18Module,app-chanspy,Channel listen in,support for listening in on any channel,,,,app_chanspy,))
$(eval $(call BuildAsterisk18Module,app-minivm,Minimal voicemail system,a voicemail system in small building blocks working together based on the Comedian Mail voicemail,,/etc/asterisk/extensions_minivm.conf /etc/asterisk/minivm.conf,extensions_minivm.conf minivm.conf,app_minivm,))
$(eval $(call BuildAsterisk18Module,app-mixmonitor,Record a call and mix the audio,record a call and mix the audio during the recording,,,,app_mixmonitor,))
$(eval $(call BuildAsterisk18Module,app-originate,Originate a call,originating an outbound call and connecting it to a specified extension or application,,,,app_originate,))
$(eval $(call BuildAsterisk18Module,app-playtones,Playtones application,play a tone list,,,,app_playtones,))
$(eval $(call BuildAsterisk18Module,app-read,Variable read,a trivial application to read a variable,,,,app_read,))
$(eval $(call BuildAsterisk18Module,app-readexten,Extension to variable,a trivial application to read an extension into a variable,,,,app_readexten,))
$(eval $(call BuildAsterisk18Module,app-record,Record sound file,to record a sound file,,,,app_record,))
$(eval $(call BuildAsterisk18Module,app-sayunixtime,Say Unix time,an application to say Unix time,,,,app_sayunixtime,))
$(eval $(call BuildAsterisk18Module,app-senddtmf,Send DTMF digits,Sends arbitrary DTMF digits,,,,app_senddtmf,))
$(eval $(call BuildAsterisk18Module,app-setcallerid,Set callerid,Support for setting callerid,,,,app_setcallerid,))
$(eval $(call BuildAsterisk18Module,app-sms,SMS,SMS support (ETSI ES 201 912 protocol 1),+libpopt +libstdcpp,,,app_sms,,smsq))
$(eval $(call BuildAsterisk18Module,app-stack,Stack applications, stack applications Gosub Return etc., +asterisk18-res-agi,,,app_stack,))
$(eval $(call BuildAsterisk18Module,app-system,System exec,support for executing system commands,,,,app_system,))
$(eval $(call BuildAsterisk18Module,app-talkdetect,File playback with audio detect,for file playback with audio detect,,,,app_talkdetect,))
$(eval $(call BuildAsterisk18Module,app-verbose,Verbose logging,Verbose logging application,,,,app_verbose,))
$(eval $(call BuildAsterisk18Module,app-waituntil,Sleep,support sleeping until the given epoch,,,,app_waituntil,))
$(eval $(call BuildAsterisk18Module,app-while,While loop,a while loop implementation,,,,app_while,))
$(eval $(call BuildAsterisk18Module,cdr-csv,Provides CDR CSV,Call Detail Record with CSV support,,,,cdr_csv,))
$(eval $(call BuildAsterisk18Module,cdr,Provides CDR,Call Detail Record,,/etc/asterisk/cdr.conf /etc/asterisk/cdr_custom.conf /etc/asterisk/cdr_manager.conf /etc/asterisk/cdr_syslog.conf,cdr cdr_custom cdr_manager cdr_syslog,app_cdr app_forkcdr cdr_custom cdr_manager cdr_syslog func_cdr,))
$(eval $(call BuildAsterisk18Module,codec-a-mu,Alaw to ulaw translation,translation between alaw and ulaw codecs,,,,codec_a_mu,))
$(eval $(call BuildAsterisk18Module,codec-alaw,Signed linear to alaw translation,translation between signed linear and alaw codecs,,,,codec_alaw,))
$(eval $(call BuildAsterisk18Module,codec-dahdi,DAHDI codec,DAHDI native transcoding support,+asterisk18-chan-dahdi,,,codec_dahdi,))
$(eval $(call BuildAsterisk18Module,codec-g722,G.722,a high bit rate 48/56/64Kbps ITU standard codec,,,,codec_g722,))
$(eval $(call BuildAsterisk18Module,codec-g726,Signed linear to G.726 translation,translation between signed linear and ITU G.726-32kbps codecs,,,,codec_g726,))
$(eval $(call BuildAsterisk18Module,curl,CURL,CURL support,+libcurl,,,func_curl res_curl,))
$(eval $(call BuildAsterisk18Module,format-g726,G.726,support for headerless G.726 16/24/32/40kbps data format,,,,format_g726,))
$(eval $(call BuildAsterisk18Module,format-g729,G.729,support for raw headerless G729 data,,,,format_g729,))
$(eval $(call BuildAsterisk18Module,format-sln,Raw slinear format,support for raw slinear format,,,,format_sln,))
$(eval $(call BuildAsterisk18Module,format-sln16,Raw slinear 16 format,support for raw slinear 16 format,,,,format_sln16,))
$(eval $(call BuildAsterisk18Module,func-base64,base64 support,support of base64 function,,,,func_base64,))
$(eval $(call BuildAsterisk18Module,func-blacklist,Blacklist on callerid,looking up the callerid number and see if it is blacklisted,,,,func_blacklist,))
$(eval $(call BuildAsterisk18Module,func-cut,CUT function,CUT function,,,,func_cut,))
$(eval $(call BuildAsterisk18Module,func-db,Database interaction,functions for interaction with the database,,,,func_db app_db,))
$(eval $(call BuildAsterisk18Module,func-devstate,Blinky lights control,functions for manually controlled blinky lights,,,,func_devstate,))
$(eval $(call BuildAsterisk18Module,func-enum,ENUM,ENUM,,/etc/asterisk/enum.conf,enum.conf,func_enum,))
$(eval $(call BuildAsterisk18Module,func-env,Environment functions,Environment dialplan functions,,,,func_env,))
$(eval $(call BuildAsterisk18Module,func-extstate,Hinted extension state,retrieving the state of a hinted extension for dialplan control,,,,func_extstate,))
$(eval $(call BuildAsterisk18Module,func-global,Global variable,global variable dialplan functions,,,,func_global,))
$(eval $(call BuildAsterisk18Module,func-groupcount,Group count,for counting number of channels in the specified group,,,,func_groupcount,))
$(eval $(call BuildAsterisk18Module,func-channel,Channel info,Channel info dialplan function,,,,func_channel,))
$(eval $(call BuildAsterisk18Module,func-math,Math functions,Math functions,,,,func_math,))
$(eval $(call BuildAsterisk18Module,func-module,Simple module check function,Simple module check function,,,,func_module,))
$(eval $(call BuildAsterisk18Module,func-shell,Shell,support for shell execution,,,,func_shell,))
$(eval $(call BuildAsterisk18Module,func-uri,URI encoding and decoding,Encodes and decodes URI-safe strings,,,,func_uri,))
$(eval $(call BuildAsterisk18Module,func-vmcount,vmcount dialplan,a vmcount dialplan function,,,,func_vmcount,))
$(eval $(call BuildAsterisk18Module,chan-agent,Agents proxy channel,An implementation of agents proxy channel,,,,chan_agent,))
$(eval $(call BuildAsterisk18Module,chan-dahdi,DAHDI channel,DAHDI channel support,+dahdi-tools-libtonezone +kmod-dahdi +libpri,/etc/asterisk/chan_dahdi.conf,chan_dahdi.conf,chan_dahdi,))
$(eval $(call BuildAsterisk18Module,chan-gtalk,GTalk,An implementation of chan_gtalk and res_jabber for GTalk support,+libiksemel,/etc/asterisk/gtalk.conf /etc/asterisk/jabber.conf,gtalk.conf jabber.conf,chan_gtalk res_jabber,))
$(eval $(call BuildAsterisk18Module,chan-iax2,IAX2 channel,An implementation of IAX2 channel,+asterisk18-res-timing-timerfd,/etc/asterisk/iax.conf /etc/asterisk/iaxprov.conf,iax.conf iaxprov.conf,chan_iax2,))
$(eval $(call BuildAsterisk18Module,chan-lantiq,Lantiq TAPI channel,An implementation of Lantiq TAPI channel,@TARGET_lantiq @!TARGET_lantiq_xrx200 +kmod-ltq-vmmc,/etc/asterisk/lantiq.conf,lantiq.conf,chan_lantiq,))
$(eval $(call BuildAsterisk18Module,chan-local,Local proxy channel,An implementation of local proxy channel,,,,chan_local,))
$(eval $(call BuildAsterisk18Module,chan-mgcp,MGCP channel,the channel chan_mgcp,,/etc/asterisk/mgcp.conf,mgcp.conf,chan_mgcp,))
$(eval $(call BuildAsterisk18Module,chan-ooh323,ooH323 channel,the channel chan_ooh323,,/etc/asterisk/ooh323.conf,ooh323.conf,chan_ooh323,))
$(eval $(call BuildAsterisk18Module,chan-skinny,Skinny channel,the channel chan_skinny,,/etc/asterisk/skinny.conf,skinny.conf,chan_skinny,))
$(eval $(call BuildAsterisk18Module,mysql,MySQL,MySQL support,+libmysqlclient,/etc/asterisk/res_config_mysql.conf,res_config_mysql.conf,res_config_mysql,))
$(eval $(call BuildAsterisk18Module,odbc,ODBC,ODBC support,+libpthread +libc +unixodbc,/etc/asterisk/cdr_adaptive_odbc.conf /etc/asterisk/cdr_odbc.conf /etc/asterisk/cel_odbc.conf /etc/asterisk/func_odbc.conf /etc/asterisk/res_odbc.conf,cdr_adaptive_odbc cdr_odbc cel_odbc func_odbc res_odbc,cdr_adaptive_odbc cdr_odbc cel_odbc func_odbc res_config_odbc res_odbc,))
$(eval $(call BuildAsterisk18Module,pbx-ael,Asterisk Extension Logic,support for symbolic Asterisk Extension Logic,,,extensions.ael,pbx_ael,))
$(eval $(call BuildAsterisk18Module,pbx-dundi,Dundi,provides Dundi Lookup service for Asterisk,,/etc/asterisk/dundi.conf,dundi.conf,pbx_dundi,))
$(eval $(call BuildAsterisk18Module,pbx-lua,Lua,provides Lua resources for Asterisk,+libpthread +libc +liblua,/etc/asterisk/extensions.lua,extensions.lua,pbx_lua,))
$(eval $(call BuildAsterisk18Module,pbx-spool,Call Spool,Outgoing call spool support,,,,pbx_spool,))
$(eval $(call BuildAsterisk18Module,pgsql,PostgreSQL,PostgreSQL support,+libpq,/etc/asterisk/cel_pgsql.conf /etc/asterisk/cdr_pgsql.conf /etc/asterisk/res_pgsql.conf,cel_pgsql.conf cdr_pgsql.conf res_pgsql.conf,cel_pgsql cdr_pgsql res_config_pgsql,))
$(eval $(call BuildAsterisk18Module,res-ael-share,Shareable AEL code,support for shareable AEL code mainly between internal and external modules,,,,res_ael_share,))
$(eval $(call BuildAsterisk18Module,res-agi,Asterisk Gateway Interface,support for the Asterisk Gateway Interface extension,,,,res_agi,))
$(eval $(call BuildAsterisk18Module,res-clioriginate,Calls via CLI,Originate calls via the CLI,,,,res_clioriginate,))
$(eval $(call BuildAsterisk18Module,res-crypto,Provides Crypto,Cryptographic Signature capability,,,,res_crypto,))
$(eval $(call BuildAsterisk18Module,res-fax-spandsp,Spandsp T.38 and G.711,Spandsp T.38 and G.711 FAX Resource,+asterisk18-res-fax +libspandsp +libtiff,,,res_fax_spandsp,))
$(eval $(call BuildAsterisk18Module,res-fax,FAX modules,Generic FAX resource for FAX technology resource modules,+asterisk18-res-timing-pthread,/etc/asterisk/res_fax.conf /etc/asterisk/udptl.conf,udptl.conf res_fax.conf,res_fax,))
$(eval $(call BuildAsterisk18Module,res-monitor,Provides Monitor,Cryptographic Signature capability,,,,res_monitor,))
$(eval $(call BuildAsterisk18Module,res-musiconhold,MOH,Music On Hold support,,/etc/asterisk/musiconhold.conf,musiconhold.conf,res_musiconhold,))
$(eval $(call BuildAsterisk18Module,res-phoneprov,Phone Provisioning,Phone provisioning application for the asterisk internal http server,,/etc/asterisk/phoneprov.conf,phoneprov.conf,res_phoneprov,))
$(eval $(call BuildAsterisk18Module,res-pktccops,Provide PacketCable COPS,simple client/server model for supporting policy control over QoS signaling protocols,,/etc/asterisk/res_pktccops.conf,res_pktccops.conf,res_pktccops,))
$(eval $(call BuildAsterisk18Module,res-smdi,Provide SMDI,Simple Message Desk Interface capability,,/etc/asterisk/smdi.conf,smdi.conf,res_smdi,))
$(eval $(call BuildAsterisk18Module,res-srtp,SRTP,Secure RTP,+libsrtp,,,res_srtp,))
$(eval $(call BuildAsterisk18Module,res-timing-dahdi,DAHDI Timing Interface,,+asterisk18-chan-dahdi,,,res_timing_dahdi,))
$(eval $(call BuildAsterisk18Module,res-timing-pthread,pthread Timing Interface,,,,,res_timing_pthread,))
$(eval $(call BuildAsterisk18Module,res-timing-timerfd,Timerfd Timing Interface,,,,,res_timing_timerfd,))
$(eval $(call BuildAsterisk18Module,voicemail,Voicemail,voicemail related modules,,/etc/asterisk/voicemail.conf,voicemail.conf,*voicemail res_adsi res_smdi,vm-*))

