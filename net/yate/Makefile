#
# Copyright (C) 2006-2018 OpenWrt.org
# Copyright (C) 2006-2011 SMBPhone
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=yate
PKG_VERSION:=6.1.0-1
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://yate.null.ro/tarballs/yate6/
PKG_HASH:=ed88519c8e2f63eec0d699bc6ed8831854af9b32b654b3d7e7c2697b528aa377
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

# Yate currently does not compile with FORTIFY_SOURCE enabled
PKG_FORTIFY_SOURCE:=0

PKG_CONFIG_DEPENDS:= \
	CONFIG_PACKAGE_$(PKG_NAME)-mod-zapcard \
	CONFIG_PACKAGE_$(PKG_NAME)-mod-ilbcwebrtc \
	CONFIG_PACKAGE_$(PKG_NAME)-mod-isaccodec \
	CONFIG_PACKAGE_$(PKG_NAME)-mod-pgsqldb \
	CONFIG_PACKAGE_$(PKG_NAME)-mod-mysqldb \
	CONFIG_PACKAGE_$(PKG_NAME)-mod-faxchan \
	CONFIG_PACKAGE_$(PKG_NAME)-mod-openssl \
	CONFIG_PACKAGE_$(PKG_NAME)-mod-zlibcompress \
	CONFIG_SOFT_FLOAT

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk
# Needed for yate-mod-mysqldb to find iconv
include $(INCLUDE_DIR)/nls.mk

define Package/$(PKG_NAME)/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=http://yate.null.ro/
endef

define Package/$(PKG_NAME)
  $(call Package/yate/Default)
  DEPENDS:=+libpthread $(CXX_DEPENDS)
  TITLE:=Yet Another Telephony Engine
  MENU:=1
endef

define Package/$(PKG_NAME)/conffiles
/etc/yate/yate.conf
/etc/init.d/yate
endef

define Package/$(PKG_NAME)/Default/description
  Is a next-generation telephony engine focused on the VoIP and PSTN. It does
  SIP, H.323, IAX, PSTN, and more.
endef

define Package/$(PKG_NAME)-scripts-perl
  $(call Package/yate/Default)
  DEPENDS += $(PKG_NAME) \
	  +PACKAGE_$(PKG_NAME)-scripts-perl:$(PKG_NAME)-mod-extmodule \
	  +PACKAGE_$(PKG_NAME)-scripts-perl:perlbase-data \
	  @!arc
  TITLE:= Perl module for Yate
endef

define Package/$(PKG_NAME)-sounds
  $(call Package/yate/Default)
  DEPENDS += $(PKG_NAME)
  TITLE := Sounds for Yate
endef

define Package/$(PKG_NAME)-collection-basic
  $(call Package/yate/Default)
  DEPENDS += $(PKG_NAME) \
	+PACKAGE_$(PKG_NAME)-collection-basic:$(PKG_NAME)-sounds \
	+PACKAGE_$(PKG_NAME)-collection-basic:$(PKG_NAME)-mod-dumbchan \
	+PACKAGE_$(PKG_NAME)-collection-basic:$(PKG_NAME)-mod-regfile \
	+PACKAGE_$(PKG_NAME)-collection-basic:$(PKG_NAME)-mod-regexroute \
	+PACKAGE_$(PKG_NAME)-collection-basic:$(PKG_NAME)-mod-rmanager \
	+PACKAGE_$(PKG_NAME)-collection-basic:$(PKG_NAME)-mod-tonegen \
	+PACKAGE_$(PKG_NAME)-collection-basic:$(PKG_NAME)-mod-yrtpchan \
	+PACKAGE_$(PKG_NAME)-collection-basic:$(PKG_NAME)-mod-ysipchan
   TITLE := Basic Yate Server
endef

# Otherwise yate ignores CPPFLAGS
TARGET_CFLAGS += $(TARGET_CPPFLAGS)

CONFIGURE_ARGS+= \
	$(if $(CONFIG_x86_64),--enable-sse2) \
	--disable-sctp \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-zapcard),,--disable-dahdi --disable-zaptel) \
	--disable-wpcard \
	--disable-tdmcard \
	--disable-wanpipe \
	--enable-ilbc \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-ilbcwebrtc),--enable-ilbc-webrtc,--disable-ilbc-webrtc) \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-pgsqldb),--with-libpq="$(STAGING_DIR)/usr",--without-libpq) \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-mysqldb),--with-mysql=yes,--with-mysql=no) \
	--without-wphwec \
	--without-libgsm \
	--without-amrnb \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-faxchan),--with-spandsp="$(STAGING_DIR)/usr/include",--without-spandsp) \
	--without-pwlib \
	--without-openh323 \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-openssl),--with-openssl,--without-openssl) \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-zlibcompress),--with-zlib="$(STAGING_DIR)/usr",--without-zlib) \
	--without-libqt4 \
	--without-qtstatic \
	--without-coredumper \
	--without-doxygen \
	--without-kdoc

# The regexp implementation of musl 1.1.19 is not fully compatible with yate
CONFIGURE_ARGS+= \
	--enable-internalregex

ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-mod-isaccodec),)
CONFIGURE_ARGS+=$(if $(CONFIG_SOFT_FLOAT),--disable-isac-float --enable-isac-fixed,--disable-isac-fixed --enable-isac-float)
else
CONFIGURE_ARGS+= \
	--disable-isac-fixed \
	--disable-isac-float
endif

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib
	
	for yatelib in "" asn sig mgcp jabber script; do \
		$(CP) $(PKG_INSTALL_DIR)/usr/lib/libyate$$$${yatelib}.so* $(1)/usr/lib ;\
	done
	
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/yate $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/$(PKG_NAME)
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/yate/yate.conf $(1)/etc/$(PKG_NAME)/yate.conf
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/yate.init $(1)/etc/init.d/yate
endef

define Package/$(PKG_NAME)-scripts-perl/install
	$(INSTALL_DIR) $(1)/usr/share/yate/scripts
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/yate/scripts/Yate.pm $(1)/usr/share/yate/scripts/
	$(INSTALL_BIN) ./files/banbrutes.pl $(1)/usr/share/yate/scripts/
endef

define Package/$(PKG_NAME)-sounds/install
	$(INSTALL_DIR) $(1)/usr/share/yate/sounds
	$(CP) $(PKG_INSTALL_DIR)/usr/share/yate/sounds/ $(1)/usr/share/yate/
endef

define Package/$(PKG_NAME)-collection-basic/install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(STAGING_DIR)/usr/include/
	$(INSTALL_DIR) $(STAGING_DIR)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(STAGING_DIR)/usr/lib/
endef

define BuildPlugin
  define Package/$(PKG_NAME)-mod-$(subst _,-,$(1))
    $(call Package/yate/Default)
    DEPENDS:= $(PKG_NAME) $(patsubst +%,+PACKAGE_$(PKG_NAME)-mod-$(subst _,-,$(1)):%,$(4))
    TITLE:=$(3)
  endef

  define Package/$(PKG_NAME)-mod-$(subst _,-,$(1))/conffiles
$(if $(6),/etc/yate/$(1).conf)
  endef
  
  define Package/$(PKG_NAME)-mod-$(subst _,-,$(1))/description
    $(3) module for $(PKG_NAME)
  endef
  
  define Package/$(PKG_NAME)-mod-$(subst _,-,$(1))/install
	$$(INSTALL_DIR) $$(1)/usr/lib/yate/$(2)
	$$(INSTALL_BIN) $$(PKG_INSTALL_DIR)/usr/lib/yate/$(2)/$(1).yate $$(1)/usr/lib/yate/$(2)/$(1).yate
	if [ -f $$(PKG_INSTALL_DIR)/etc/yate/$(1).conf ]; then \
		$$(INSTALL_DIR) $$(1)/etc/yate ;\
		$$(INSTALL_CONF) $$(PKG_INSTALL_DIR)/etc/yate/$(1).conf $$(1)/etc/yate/ ;\
	fi
	$(if $(5),$(foreach extra_file,$(5),\
		$(INSTALL_DIR) $$(1)$(dir $(extra_file)) ; \
		$(CP) $(PKG_INSTALL_DIR)$(extra_file) $$(1)$(extra_file) ; \
	),)
  endef

  $$(eval $$(call BuildPackage,$(PKG_NAME)-mod-$(subst _,-,$(1))))
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-collection-basic))
$(eval $(call BuildPackage,$(PKG_NAME)-scripts-perl))
$(eval $(call BuildPackage,$(PKG_NAME)-sounds))

############################
# 1: plugin
# 2: client, server or empty
# 3: description
# 4: depends
# 5: extra files
# 6: has a config sample (y)
# ##########################
$(eval $(call BuildPlugin,accfile,server,SIP or H.323 client (from file),,,y))
$(eval $(call BuildPlugin,alsachan,client,ALSA Sound Channel,+alsa-lib))
$(eval $(call BuildPlugin,amrnbcodec,,AMR-NB Codec,@BROKEN)) # Missing amr-nb library
$(eval $(call BuildPlugin,analog,server,Analog (e.g. POTS) Channel,,,y))
$(eval $(call BuildPlugin,analogdetect,server,Analog Data Detector,))
$(eval $(call BuildPlugin,analyzer,,Test Call Generator and AQ Analyzer,))
$(eval $(call BuildPlugin,cache,server,CNAM and LNP memory caches,,,y))
$(eval $(call BuildPlugin,callcounters,server,Count Active Call Legs,,,y))
$(eval $(call BuildPlugin,callfork,,Call Forker,,,y))
$(eval $(call BuildPlugin,callgen,,Call Generator,))
$(eval $(call BuildPlugin,camel_map,sig,MAP/CAMEL TCAP <-> XML translators,,,y))
$(eval $(call BuildPlugin,ccongestion,server,Accept Status from Installed Engine Monitors,,,y))
$(eval $(call BuildPlugin,cdrbuild,,Call Detail Record Builder,,,y))
$(eval $(call BuildPlugin,cdrcombine,,Call Detail Records per call instead of per call leg,))
$(eval $(call BuildPlugin,cdrfile,,Call Detail Record to File,,,y))
$(eval $(call BuildPlugin,ciscosm,server,SS7 Support,,,y))
$(eval $(call BuildPlugin,clustering,server,Clustering Server Support,,,y))
$(eval $(call BuildPlugin,conference,,Conference Room Mixer,))
$(eval $(call BuildPlugin,cpuload,server,Monitor CPU load and Inform Yate,,,y))
$(eval $(call BuildPlugin,dbpbx,server,PBX IVR and Multi-routing from Database,,,y))
$(eval $(call BuildPlugin,dbwave,server,Wav Media for DB Storage,+$(PKG_NAME)-mod-wavefile))
$(eval $(call BuildPlugin,dumbchan,,Dummy Channel,))
$(eval $(call BuildPlugin,enumroute,,ENUM Routing,,,y))
$(eval $(call BuildPlugin,eventlogs,server,Write events and alarms to log files,,,y))
$(eval $(call BuildPlugin,extmodule,,External Module Handler,,/usr/share/yate/scripts/echo.sh,y))
$(eval $(call BuildPlugin,faxchan,,Spandsp Fax Channel,+libspandsp))
$(eval $(call BuildPlugin,fileinfo,,File Info Holder,,,y))
$(eval $(call BuildPlugin,filetransfer,,File Transfer Driver,,,y))
$(eval $(call BuildPlugin,gvoice,,Google Voice support,,,y))
$(eval $(call BuildPlugin,heartbeat,server,Linux-HA compatible heartbeat,,,y))
$(eval $(call BuildPlugin,ilbccodec,,iLBC Codec,))
$(eval $(call BuildPlugin,ilbcwebrtc,,iLBC Codec from the WebRTC project,))
$(eval $(call BuildPlugin,isaccodec,,internet Speech Audio Codec,))
$(eval $(call BuildPlugin,isupmangler,sig,ISUP parameter mangling in a STP,,,y))
$(eval $(call BuildPlugin,jabberclient,client,Jabber Client,,,y))
$(eval $(call BuildPlugin,jabberserver,jabber,Jabber Server,,,y))
$(eval $(call BuildPlugin,javascript,,Routing using the embedded Javascript language,,,y))
$(eval $(call BuildPlugin,jbfeatures,jabber,Jabber Server Features,,,y))
$(eval $(call BuildPlugin,lateroute,server,Last Chance Routing,,,y))
$(eval $(call BuildPlugin,mgcpca,server,Media Gateway Control Protocol Agent,,,y))
$(eval $(call BuildPlugin,mgcpgw,server,Media Gateway Control Protocol Gateway,,,y))
$(eval $(call BuildPlugin,moh,,On Hold (music) Generator,,,y))
$(eval $(call BuildPlugin,monitoring,server,Monitoring/gathering Information,,,y))
$(eval $(call BuildPlugin,mrcpspeech,server,MRCP v2 Voice/Tone Detector and Synthesizer,))
$(eval $(call BuildPlugin,msgsniff,,Sample Message Sniffer,))
$(eval $(call BuildPlugin,mux,,Data Multiplexor,,,y))
$(eval $(call BuildPlugin,mysqldb,server,MySQL Backend DB,+libmysqlclient-r,,y))
$(eval $(call BuildPlugin,openssl,,Encrypted transport (OpenSSL),+libopenssl,,y))
$(eval $(call BuildPlugin,osschan,client,OSS Sound Channel,))
$(eval $(call BuildPlugin,park,server,Call Parking,))
$(eval $(call BuildPlugin,pbx,,PBX Message Handlers,))
$(eval $(call BuildPlugin,pbxassist,server,Full featured PBX and IVR,,,y))
$(eval $(call BuildPlugin,pgsqldb,server,PostgrestSQL Backend DB,+libpq))
$(eval $(call BuildPlugin,presence,server,Presence,,,y))
$(eval $(call BuildPlugin,queues,server,Call Distribution and Queues from Database,,,y))
$(eval $(call BuildPlugin,queuesnotify,server,Notify when queued call status changes,,,y))
$(eval $(call BuildPlugin,regexroute,,Regular Expression Based Routing,,,y))
$(eval $(call BuildPlugin,regfile,server,Registration based on users in file,,,y))
$(eval $(call BuildPlugin,register,server,Call Detail Record to a database,,,y))
$(eval $(call BuildPlugin,rmanager,,Yate Remote Management,,,y))
$(eval $(call BuildPlugin,sigtransport,server,SIGTRAN (SS7 over IP) connection provider,,,y))
$(eval $(call BuildPlugin,sip_cnam_lnp,sip,Query CNAM and LNP databases using SIP INVITE,,,y))
$(eval $(call BuildPlugin,sipfeatures,server,SIP Features (SUBSCRIBE/NOTIFY),,,y))
$(eval $(call BuildPlugin,sqlitedb,server,SQLite Support,+libsqlite3,,y))
$(eval $(call BuildPlugin,ss7_lnp_ansi,sig,Query LNP Databases,,,y))
$(eval $(call BuildPlugin,subscription,server,Subcription handler and presence notifier,,,y))
$(eval $(call BuildPlugin,tdmcard,server,TDM Cards Signalling and Data Driver,@BROKEN)) # Missing TDM libraries
$(eval $(call BuildPlugin,tonedetect,,Detectors for Various Tones,))
$(eval $(call BuildPlugin,tonegen,,Tones Generator,,,y))
$(eval $(call BuildPlugin,users,server,Users,,,y))
$(eval $(call BuildPlugin,wavefile,,Wav file Record and Playback,))
$(eval $(call BuildPlugin,wpcard,server,Wanpipe PRI cards Signalling and Data Driver,@BROKEN)) # Mising wanpipe and PRI libraries
$(eval $(call BuildPlugin,yiaxchan,,IAX Channel,,,y))
$(eval $(call BuildPlugin,yjinglechan,,Jingle Channel,,,y))
$(eval $(call BuildPlugin,yradius,server,RADIUS Client,,,y))
$(eval $(call BuildPlugin,yrtpchan,,RTP Channel and Other Data Helper,,,y))
$(eval $(call BuildPlugin,ysigchan,server,SS7/ISDN Protocols - Yate Signalling Library,,,y))
$(eval $(call BuildPlugin,ysipchan,,SIP Channel,,,y))
$(eval $(call BuildPlugin,ysnmpagent,server,SNMP Protocol Agent,,/usr/share/yate/data/NULL-TEAM-MIB.txt /usr/share/yate/data/snmp_mib.conf /usr/share/yate/data/YATE-MIB.txt,y))
$(eval $(call BuildPlugin,ysockschan,,SOCKS Channel,,,y))
$(eval $(call BuildPlugin,ystunchan,,STUN Support,,,y))
$(eval $(call BuildPlugin,zapcard,server,Zaptel PRI/TDM/FXS/FXO cards,@!aarch64 +kmod-dahdi,,y))
$(eval $(call BuildPlugin,zlibcompress,,Zlib Compression,+zlib,,y))

