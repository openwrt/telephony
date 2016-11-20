#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

# TODO
#
# - try to use system xmlrpc-c once it compiles again :)

# NOTES
#
# - --disable-cpp sounds like a good idea - it sounds like we could get rid of
#   the dep on libstdcpp. Unfortunately that's not the case. The result of
#   --disable-cpp is that switch_cpp.cpp is not compiled. But there is other
#   stuff that depends on libstdcpp.
# - the FreeSWITCH build system is greedy - if it finds a software on your
#   system (or in your staging area) that it likes, it'll most likely link to
#   it. That's of course bad when you want to keep deps to a minimum (think
#   embedded device with limited storage). I've patched configure.ac to be able
#   to say no to libpng and freetype and added a workaround for libpq to this
#   Makefile. But there's more of that stuff, so in case of errors in the end
#   due to missing depends we'll need to poke around some more.
# - I won't bother with sound file packages - too big for small routers plus I
#   don't think we're gonna play many audio files on them anyway.
# - minimal configuration is available as optional package with deps. 

include $(TOPDIR)/rules.mk

PRG_NAME:=freeswitch
PKG_NAME:=$(PRG_NAME)-stable
PKG_VERSION:=1.6.12
PKG_RELEASE:=0
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

PKG_SOURCE:=$(PRG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://files.$(PRG_NAME).org/releases/$(PRG_NAME)
PKG_MD5SUM:=ae20b9887e936a889b35032f8b01ae2f

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PRG_NAME)-$(PKG_VERSION)

# configure fails without libjpeg, but it's only needed for mod_spandsp
PKG_BUILD_DEPENDS:=libjpeg

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_LICENSE:= \
	Apache-2.0 (apr, apr-util), \
	BSD-3-Clause (libsrtp), \
	GPL-3.0+ with font exception (fonts), \
	libtiff \
	LGPL-2.0+ (sofia-sip), \
	LGPL-2.1, GPL-2.0 (spandsp), \
	MPL-1.1

PKG_LICENSE_FILES:= \
	COPYING \
	libs/apr/LICENSE \
	libs/apr-util/LICENSE \
	libs/libzrtp/src/zrtp_legal.c \
	libs/sofia-sip/COPYING \
	libs/sofia-sip/COPYRIGHTS \
	libs/spandsp/COPYING \
	libs/srtp/LICENSE \
	libs/tiff-4.0.2/COPYRIGHT

FS_STABLE_MOD_AVAILABLE:= \
	alsa \
	blacklist \
	callcenter \
	cdr_csv \
	cdr_sqlite \
	commands \
	conference \
	console \
	curl \
	db \
	dialplan_asterisk \
	dialplan_xml \
	directory \
	dptools \
	easyroute \
	esf \
	esl \
	event_socket \
	expr \
	fifo \
	fsk \
	g723_1 \
	g729 \
	hash \
	httapi \
	lcr \
	local_stream \
	logfile \
	loopback \
	native_file \
	rtc \
	rtmp \
	sndfile \
	snom \
	sofia \
	spandsp \
	spy \
	syslog \
	tone_stream \
	translate \
	valet_parking \
	verto \
	voicemail \
	xml_cdr \
	xml_rpc \
	xml_scgi

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)/install/lib
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(2).so* $(1)/usr/lib
endef

define Package/$(PKG_NAME)/install/bin
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/$(2) $(1)/usr/bin
endef

define Package/$(PKG_NAME)/Configuration/install/conf
	for dir in $$$$(shell cd $(PKG_BUILD_DIR)/conf/$(2); \
		find -type d -print | sed 's|^./\?||'); \
	do \
		$(INSTALL_DIR) $(1)/etc/$(PRG_NAME)/$$$$$$$$dir; \
	done
	for file in $$$$(shell cd $(PKG_BUILD_DIR)/conf/$(2); \
		find -type f -print | sed 's|^./||'); \
	do \
		$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/$(2)/$$$$$$$$file \
				$(1)/etc/$(PRG_NAME)/$$$$$$$$file; \
	done
endef

define Package/$(PKG_NAME)/Module/install/mod
	$(INSTALL_DIR) $(1)/usr/lib/$(PRG_NAME)/mod
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/$(PRG_NAME)/mod/$(2).so \
						$(1)/usr/lib/$(PRG_NAME)/mod
endef

define Package/$(PKG_NAME)/config
	source "$(SOURCE)/Config.in"
endef

define Package/$(PKG_NAME)/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=https://www.$(PRG_NAME).org
endef

define Package/$(PKG_NAME)
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH open source telephony platform, v$(PKG_VERSION)
  MENU:=1
  USERID:=$(PRG_NAME)=372:$(PRG_NAME)=372
  DEPENDS:= \
	+FS_STABLE_WITH_LIBEDIT:libedit \
	+FS_STABLE_WITH_ODBC:unixodbc \
	+FS_STABLE_WITH_PGSQL:libpq \
	+libcurl \
	+libopenssl \
	+libpcre \
	+libpthread \
	+librt \
	+libspeex \
	+libspeexdsp \
	+libstdcpp \
	+libsqlite3 \
	+libuuid \
	+zlib
  CONFLICTS:=$(PRG_NAME)
endef

define Package/$(PKG_NAME)/description
FreeSWITCH is a scalable open source cross-platform telephony platform designed
to route and interconnect popular communication protocols using audio, video,
text or any other form of media.
endef

define Package/$(PKG_NAME)/conffiles
/etc/$(PRG_NAME)
/etc/default/$(PRG_NAME)
/etc/init.d/$(PRG_NAME)
endef

define Package/$(PKG_NAME)/install
$(call Package/$(PKG_NAME)/install/bin,$(1),$(PRG_NAME))
$(call Package/$(PKG_NAME)/install/bin,$(1),fs_cli)
$(call Package/$(PKG_NAME)/install/bin,$(1),gentls_cert)
$(call Package/$(PKG_NAME)/install/lib,$(1),lib$(PRG_NAME))
	$(INSTALL_DIR) $(1)/etc/$(PRG_NAME)
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_CONF) ./files/$(PRG_NAME).default $(1)/etc/default/$(PRG_NAME)
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/$(PRG_NAME).init $(1)/etc/init.d/$(PRG_NAME)
endef

define Package/$(PKG_NAME)/Configuration
define Package/$(PKG_NAME)-config-$(1)
$(call Package/$(PKG_NAME)/Default)
  TITLE:=$(2) configuration
  DEPENDS:=$(PKG_NAME) $(patsubst +%,+PACKAGE_$(PKG_NAME)-config-$(1):%,$(4))
  CONFLICTS:=$(5)
endef
define Package/$(PKG_NAME)-config-$(1)/description
$(3)
endef
define Package/$(PKG_NAME)-config-$(1)/conffiles
/etc/$(PRG_NAME)
endef
define Package/$(PKG_NAME)-config-$(1)/install
$(call Package/$(PKG_NAME)/Configuration/install/conf,$$(1),$(1))
endef
$$(eval $$(call BuildPackage,$(PKG_NAME)-config-$(1)))
endef

define Package/$(PKG_NAME)/Module
define Package/$(PKG_NAME)-$(1)
$(call Package/$(PKG_NAME)/Default)
  TITLE:=$(2) support
  DEPENDS:=$(PKG_NAME) $(patsubst +%,+PACKAGE_$(PKG_NAME)-$(1):%,$(4))
endef
define Package/$(PKG_NAME)-$(1)/description
$(3)
endef
define Package/$(PKG_NAME)-$(1)/install
$(call Package/$(PKG_NAME)/Module/install/mod,$$(1),$(1))
endef
$$(eval $$(call BuildPackage,$(PKG_NAME)-$(1)))
endef

# we neither need host-perl nor host-php
CONFIGURE_VARS+= \
	ac_cv_prog_PERL=false \
	ac_cv_have_perl=no \
	ac_cv_prog_PHP=false \
	ac_cv_have_php=no \
	ac_cv_prog_PHP_CONFIG=false \
	ac_cv_have_php_config=no

# build breaks with -Werror enabled
CONFIGURE_VARS+= \
	ac_cv_gcc_supports_w_no_unused_result=no

# even without --with-core-pgsql-support libpq will be used if installed
# (by apr-util), so we need to put the brakes on
ifeq ($(CONFIG_FS_STABLE_WITH_PGSQL),y)
else
CONFIGURE_VARS+= \
	ac_cv_lib_pq_PQsendQueryPrepared=no
endif

CONFIGURE_ARGS+= \
	--build=$(GNU_HOST_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--target=$(GNU_TARGET_NAME) \
	--prefix=/usr/share/$(PRG_NAME) \
	--bindir=/usr/bin \
	--libdir=/usr/lib \
	--srcdir=$(PKG_BUILD_DIR) \
	--sysconfdir=/etc \
	--disable-debug \
	--disable-libvpx \
	--disable-libyuv \
	--disable-static \
	--disable-system-xmlrpc-c \
	--enable-fhs \
	--with-cachedir=/tmp/$(PRG_NAME)/cache \
	--with-certsdir=/etc/$(PRG_NAME)/tls \
	--with-dbdir=/tmp/$(PRG_NAME)/db \
	--with-htdocsdir=/usr/share/$(PRG_NAME)/htdocs \
	--with-imagesdir=/usr/share/$(PRG_NAME)/images \
	--with-fontsdir=/usr/share/$(PRG_NAME)/fonts \
	--with-grammardir=/usr/share/$(PRG_NAME)/grammar \
	--with-logfiledir=/tmp/$(PRG_NAME)/log \
	--with-modinstdir=/usr/lib/$(PRG_NAME)/mod \
	--with-recordingsdir=/var/run/$(PRG_NAME)/recordings \
	--with-rundir=/var/run/$(PRG_NAME) \
	--with-scriptdir=/usr/share/$(PRG_NAME)/scripts \
	--with-soundsdir=/usr/share/$(PRG_NAME)/sounds \
	--with-storagedir=/var/run/$(PRG_NAME)/storage \
	--without-erlang \
	--without-freetype \
	--without-png \
	--without-python \
	$(call autoconf_bool,CONFIG_FS_STABLE_WITH_LIBEDIT,core-libedit-support) \
	$(call autoconf_bool,CONFIG_FS_STABLE_WITH_ODBC,core-odbc-support) \
	$(call autoconf_bool,CONFIG_FS_STABLE_WITH_SRTP,srtp) \
	$(call autoconf_bool,CONFIG_FS_STABLE_WITH_ZRTP,zrtp) \
	$(if $(CONFIG_FS_STABLE_WITH_ODBC),--with-odbc-lib="$(STAGING_DIR)/usr/lib") \
	$(if $(CONFIG_FS_STABLE_WITH_ODBC),--with-odbc="$(STAGING_DIR)/usr") \
	$(if $(CONFIG_FS_STABLE_WITH_PGSQL),--enable-core-pgsql-support)

define Build/Prepare
	$(call Build/Prepare/Default)
	$(SED) '/^#/!s/^/#/' $(PKG_BUILD_DIR)/modules.conf
	$(foreach m,$(FS_STABLE_MOD_AVAILABLE),
		$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod_$(m)),
		$(SED) '/mod_$(m)/s/^#//' $(PKG_BUILD_DIR)/modules.conf))
endef

$(eval $(call BuildPackage,$(PKG_NAME)))

################################
# FreeSWITCH modules
# Params:
# 1 - Package subname
# 2 - Package title
# 3 - Module description
# 4 - Module dependencies
################################

$(eval $(call Package/$(PKG_NAME)/Module,mod_commands,API command,A plethora of API interface commands.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_alsa,ALSA,Sound card endpoint.,+alsa-lib))
$(eval $(call Package/$(PKG_NAME)/Module,mod_blacklist,Blacklist,Blacklist module.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_callcenter,Call center,Call queuing application that can be used for call center needs.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_conference,Conference room,Conference room module.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_curl,cURL,Allows scripts to make HTTP requests and receive responses as plain text or JSON.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_db,Database,Database key/value store functionality for group dialing and for use as a limit backend.,+libdb47))
$(eval $(call Package/$(PKG_NAME)/Module,mod_directory,Directory,Dial by name directory.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_dptools,Dialplan tools,The Dialplan Tools provide a number of apps and utilities for the dialplan.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_easyroute,DID routing,A simple DID routing engine that uses a database lookup to determine how to route an incoming call.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_esf,SIP multicast paging,Holds the multi cast paging application for SIP.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_esl,Remote ESL command,Allows to generate remote ESL commands.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_expr,Expression evaluation,Brian Allen Vanderburgs expression evaluation library.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_fifo,FIFO,FIFO module.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_fsk,FSK decoder,Frequency-Shift Keying data transfer.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_hash,Hash table,Hashtable key/value store functionality and limit backend.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_httapi,HT-TAPI,HT-TAPI Hypertext Telephony API.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_lcr,LCR,Implements Least Cost Routing.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_sndfile,Soundfile,Adds sound format support via libsndfile.,+libsndfile))
$(eval $(call Package/$(PKG_NAME)/Module,mod_snom,SNOM,Controlling softkeys on Snom phones.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_spandsp,Spandsp,Spandsp tone and DTMF detectors. A combination of mod_fax and mod_voipcodecs and mod_t38gateway.,+libjpeg +liblzma))
$(eval $(call Package/$(PKG_NAME)/Module,mod_spy,Spy,User spy module.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_valet_parking,Parking,Allows calls to be parked and picked up easily.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_voicemail,Voice mail,Full-featured voicemail module.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_g723_1,G.723.1 codec,G.723.1 codec.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_g729,G.729 codec,G.729 codec.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_dialplan_asterisk,Asterisk dialplan,Allows you to create dialplans the old-fashioned way.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_dialplan_xml,XML dialplan,Allows you to program dialplans in XML format.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_loopback,Loopback,A loopback channel driver to make an outbound call as an inbound call.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_rtc,Media streaming,mod_rtc supports media streaming used by WebRTC and mod_verto.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_rtmp,RTMP,Real Time Media Protocol endpoint for FreeSWITCH.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_sofia,Sofia SIP,SIP module.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_verto,Verto,Verto RTC is a FreeSWITCH endpoint that implements a subset of a JSON-RPC connection designed for use over secure websockets. mod_verto is the signaling protocol. It depends on mod_rtc for secure media streaming services.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_cdr_csv,CDR CSV,CSV call detail record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_cdr_sqlite,CDR SQLite,SQLite CDR module.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_event_socket,Event socket,Sends events via a single socket. Needed for fs_cli to be able to connect to FreeSWITCH.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_local_stream,Local stream,Multiple channels connected to same looped file stream.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_native_file,Native file,File interface for codec specific file formats.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_tone_stream,Tone stream,Tone generation stream.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_translate,Number translation,Formats numbers into a specified format using regular expressions.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_console,Console configuration,Allows control over what messages get logged to the console. A bit messy as the settings do not take hold immediately after starting FreeSWITCH.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_logfile,File logger,File logger.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_syslog,Syslog logger,Syslog logger.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_xml_cdr,XML CDR,XML-based call detail record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_xml_rpc,XML RPC,XML Remote Procedure Calls. Issue commands from your web application.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_xml_scgi,XML SCGI,Simple Common Gateway Interface.,))

################################
# FreeSWITCH configuration
# Params:
# 1 - Package subname
# 2 - Package title
# 3 - Package description
# 4 - Package dependencies
# 5 - Package conflicts
################################

$(eval $(call Package/$(PKG_NAME)/Configuration,minimal,Minimal,The FreeSwitch minimal configuration aims to be a starting point for configuring a new system. It still has a lot of dependencies so maybe you are better off without it.,+freeswitch-stable-mod_console +freeswitch-stable-mod_logfile +freeswitch-stable-mod_xml_rpc +freeswitch-stable-mod_cdr_csv +freeswitch-stable-mod_event_socket +freeswitch-stable-mod_sofia +freeswitch-stable-mod_loopback +freeswitch-stable-mod_commands +freeswitch-stable-mod_conference +freeswitch-stable-mod_db +freeswitch-stable-mod_sndfile +freeswitch-stable-mod_dptools +freeswitch-stable-mod_expr +freeswitch-stable-mod_hash +freeswitch-stable-mod_esf +freeswitch-stable-mod_dialplan_xml +freeswitch-stable-mod_native_file,))
