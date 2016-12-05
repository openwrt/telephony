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

include $(TOPDIR)/rules.mk

PRG_NAME:=freeswitch
PKG_NAME:=$(PRG_NAME)-stable
PKG_VERSION:=1.6.13
PKG_RELEASE:=1
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

PKG_SOURCE:=$(PRG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://files.$(PRG_NAME).org/releases/$(PRG_NAME)
PKG_MD5SUM:=64a8a14fc5df92893d956868f144042891cc3e2d096bbf56241fec706635a8b7

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PRG_NAME)-$(PKG_VERSION)

# configure fails without libjpeg, but it's only needed for mod_spandsp
PKG_BUILD_DEPENDS:=libjpeg

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_LICENSE:= \
	AGPL-3.0 \
	Apache-2.0 \
	BSD-2-Clause \
	BSD-3-Clause \
	BSD-4-Clause \
	BSD-like \
	Beerware \
	GPL-1.0+ \
	GPL-2.0 \
	GPL-2.0+ \
	GPL-3.0 \
	ISC \
	LGPL-2.0+ \
	LGPL-2.1 \
	LGPL-2.1+ \
	MIT/X11 (BSD like) \
	MPL-1.1 \
	OpenLDAP \
	RSA-MD \
	zlib-acknowledgement

PKG_LICENSE_FILES:=debian/copyright

FS_STABLE_MOD_AVAILABLE:= \
	abstraction \
	alsa \
	avmd \
	blacklist \
	callcenter \
	cdr_csv \
	cdr_sqlite \
	cidlookup \
	commands \
	conference \
	console \
	curl \
	db \
	dialplan_asterisk \
	dialplan_xml \
	dingaling \
	directory \
	distributor \
	dptools \
	easyroute \
	enum \
	esf \
	esl \
	event_multicast \
	event_socket \
	expr \
	fifo \
	format_cdr \
	fsk \
	g723_1 \
	g729 \
	hash \
	httapi \
	http_cache \
	json_cdr \
	lcr \
	local_stream \
	logfile \
	loopback \
	native_file \
	rtc \
	rtmp \
	say_de \
	say_en \
	say_es \
	say_es_ar \
	say_fa \
	say_fr \
	say_he \
	say_hr \
	say_hu \
	say_it \
	say_ja \
	say_nl \
	say_pl \
	say_pt \
	say_ru \
	say_sv \
	say_th \
	say_zh \
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

define Package/$(PKG_NAME)/Example/install/example
	for dir in $$$$(shell cd $(PKG_BUILD_DIR)/conf/$(2); \
		find -type d -print | sed 's|^./\?||'); \
	do \
		$(INSTALL_DIR) \
			$(1)/usr/share/$(PRG_NAME)/conf/$(2)/$$$$$$$$dir; \
	done
	for file in $$$$(shell cd $(PKG_BUILD_DIR)/conf/$(2); \
		find -type f -print | sed 's|^./||'); \
	do \
		$(INSTALL_DATA) $(PKG_BUILD_DIR)/conf/$(2)/$$$$$$$$file \
			$(1)/usr/share/$(PRG_NAME)/conf/$(2)/$$$$$$$$file; \
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
	$(INSTALL_DIR) $(1)/etc/$(PRG_NAME)/tls
	$(INSTALL_DIR) $(1)/usr/share/$(PRG_NAME)/fonts
	$(INSTALL_DIR) $(1)/usr/share/$(PRG_NAME)/grammar
	$(INSTALL_DIR) $(1)/usr/share/$(PRG_NAME)/htdocs
	$(INSTALL_DIR) $(1)/usr/share/$(PRG_NAME)/images
	$(INSTALL_DIR) $(1)/usr/share/$(PRG_NAME)/scripts
	$(INSTALL_DIR) $(1)/usr/share/$(PRG_NAME)/sounds
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_CONF) ./files/$(PRG_NAME).default $(1)/etc/default/$(PRG_NAME)
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/$(PRG_NAME).init $(1)/etc/init.d/$(PRG_NAME)
endef

define Package/$(PKG_NAME)/Example
define Package/$(PKG_NAME)-example-$(1)
$(call Package/$(PKG_NAME)/Default)
  TITLE:=Example configuration
  DEPENDS:=$(PKG_NAME)
  PKGARCH:=all
endef
define Package/$(PKG_NAME)-example-$(1)/description
This package does not install any configuration for FreeSWITCH into
/etc/freeswitch. The system administrator is completely responsible for that
directory. If you install one of the example configuration packages, it will
install the corresponding sample configuration to /usr/share/freeswitch/conf
where you can take a look at it.
endef
define Package/$(PKG_NAME)-example-$(1)/install
$(call Package/$(PKG_NAME)/Example/install/example,$$(1),$(1))
endef
$$(eval $$(call BuildPackage,$(PKG_NAME)-example-$(1)))
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

# The autoconf variables in this block are OK for both musl and glibc
CONFIGURE_VARS+= \
	ac_cv_file__dev_ptmx=yes \
	ac_cv_file__dev_urandom=yes \
	ac_cv_file_dbd_apr_dbd_mysql_c=no \
	ac_cv_func_pthread_rwlock_init=yes \
	ac_cv_func_sem_open=yes \
	ac_cv_have_working_memmove=yes \
	ac_cv_negative_eai=yes \
	ac_cv_o_nonblock_inherited=no \
	ac_cv_struct_rlimit=yes \
	apr_cv_epoll=yes \
	apr_cv_gai_addrconfig=yes \
	apr_cv_mutex_recursive=yes \
	apr_cv_process_shared_works=yes \
	apr_cv_pthreads_lib=-lpthread \
	apr_cv_tcp_nodelay_with_cork=yes \
	apr_cv_type_rwlock_t=yes

# http://www.openwall.com/lists/musl/2016/11/26/1
# _Don't_ remove quotes below!
ifeq ($(CONFIG_LIBC),"musl")
CONFIGURE_VARS+= \
	apr_cv_mutex_robust_shared=no
else
CONFIGURE_VARS+= \
	apr_cv_mutex_robust_shared=yes
endif

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
	--with-fontsdir=/usr/share/$(PRG_NAME)/fonts \
	--with-grammardir=/usr/share/$(PRG_NAME)/grammar \
	--with-htdocsdir=/usr/share/$(PRG_NAME)/htdocs \
	--with-imagesdir=/usr/share/$(PRG_NAME)/images \
	--with-logfiledir=/tmp/$(PRG_NAME)/log \
	--with-modinstdir=/usr/lib/$(PRG_NAME)/mod \
	--with-recordingsdir=/tmp/$(PRG_NAME)/recordings \
	--with-rundir=/var/run/$(PRG_NAME) \
	--with-scriptdir=/usr/share/$(PRG_NAME)/scripts \
	--with-soundsdir=/usr/share/$(PRG_NAME)/sounds \
	--with-storagedir=/tmp/$(PRG_NAME)/storage \
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

$(eval $(call Package/$(PKG_NAME)/Module,mod_abstraction,API abstraction,This module provides a way to create new API functions via regex.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_alsa,ALSA,ALSA endpoint module.,+alsa-lib))
$(eval $(call Package/$(PKG_NAME)/Module,mod_avmd,Advanced voicemail detection,This module attempts to determine when a voicemail system has answered the call.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_blacklist,Blacklist helper,This module provides tools to blacklist callers.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_callcenter,Call center,This module implements Automated Call Distribution queues.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_cdr_csv,CDR CSV,CSV Call Detail Record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_cdr_sqlite,CDR SQLite,SQLite Call Detail Record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_cidlookup,Caller ID name lookup,This module provides an API for querying caller ID name and location data.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_commands,Command module,This module provides miscellaneous API commands.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_conference,Conference,This module provides multi-party conferencing.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_console,Console configuration,Allows control over what messages get logged to the console.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_curl,cURL,This module provides an API for making HTTP requests with cURL.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_db,DB,This module implements a simple db API with group support. Also can be used as a limit db backend.,+libdb47))
$(eval $(call Package/$(PKG_NAME)/Module,mod_dialplan_asterisk,Asterisk dialplan,Asterisk extensions.conf style dialplan parser.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_dialplan_xml,XML dialplan,Standard FreeSWITCH XML dialplan support.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_dingaling,Generic XMPP,Allows FreeSWITCH to be used as a client for XMPP Servers.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_directory,Dial-by-name directory,This module implements a dial-by-name directory IVR.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_distributor,Load distributor,This module implements a mechanism for performing load balancing.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_dptools,Dialplan tools,This module implements basic dialplan tools.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_easyroute,DID routing,This module does destination lookup based on DID.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_enum,ENUM routing,This module implements ENUM support.,+libldns))
$(eval $(call Package/$(PKG_NAME)/Module,mod_esf,Multicast,This module adds multi-cast support.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_esl,Single ESL,This module adds an API for generating one-off ESL requests.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_event_multicast,Multicast Event,Multicast Event System for FreeSWITCH.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_event_socket,Event socket,Sends events via a single socket. Needed for fs_cli.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_expr,Expr,This module adds expr support for expression evaluation.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_fifo,FIFO,This module adds a first-in first-out queue system.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_format_cdr,Multiformat CDR,A superset of mod_json_cdr and mod_xml_cdr.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_fsk,FSK,This module adds frequency-shift keying support which can be used to send and receive caller ID.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_g723_1,G.723.1 passthrough,G.723.1 codec passthrough.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_g729,G.729 passthrough,G.729 codec passthrough.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_hash,Hash,This module provides a key-value in-memory datastore. Usable as a limit backend.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_httapi,HT-TAPI,This module provides an API for controlling the switch by responding to HTTP requests.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_http_cache,HTTP GET with caching,This module provides an API for making HTTP GET requests where the result is cached.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_json_cdr,JSON CDR,JSON-based call detail record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_lcr,LCR,This module adds a facility for least-cost routing.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_local_stream,Local stream,Connects multiple channels to a looped stream.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_logfile,File logger,Logs FreeSWITCH output to a file.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_loopback,Loopback,A loopback channel driver.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_native_file,Native file,Plays files that are already encoded in the right format.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_rtc,Media streaming,Media streaming as used by WebRTC and mod_verto.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_rtmp,RTMP,RTMP endpoint support. Allows FreeSWITCH to be used from RTMP clients.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_de,Say for German,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_en,Say for English,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_es,Say for Spanish,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_es_ar,Say for Spanish in Argentina,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_fa,Say for Persian,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_fr,Say for French,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_he,Say for Hebrew,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_hr,Say for Croatian,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_hu,Say for Hungarian,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_it,Say for Italian,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_ja,Say for Japanese,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_nl,Say for Dutch,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_pl,Say for Polish,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_pt,Say for Portuguese,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_ru,Say for Russian,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_sv,Say for Swedish,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_th,Say for Thai,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_say_zh,Say for Chinese dialects,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_sndfile,Soundfile,Adds sound format support via libsndfile.,+libsndfile))
$(eval $(call Package/$(PKG_NAME)/Module,mod_snom,SNOM,This module implements features specific to SNOM phones.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_sofia,Sofia SIP,SIP module.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_spandsp,SpanDSP,This module implements SpanDSP fax. It includes DSP and codec functionality.,+libjpeg +liblzma))
$(eval $(call Package/$(PKG_NAME)/Module,mod_spy,User Spy,This module adds the ability to monitor the audio of a channel.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_syslog,Syslog logger,Logs FreeSWITCH output to the syslog.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_tone_stream,Tone stream,Tone generation stream.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_translate,Number translation,This module implements number translation.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_valet_parking,Valet parking,This module implements the valet call parking strategy.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_verto,Verto,Verto signaling protocol.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_voicemail,Voicemail,This module provides a voicemail system.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_xml_cdr,XML CDR,XML Call Detail Record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_xml_rpc,XML RPC,Allows using the webapi to control FreeSWITCH.,))
$(eval $(call Package/$(PKG_NAME)/Module,mod_xml_scgi,XML SCGI,SCGI XML Gateway.,))

################################
# FreeSWITCH example configs
# Params:
# 1 - Package subname
################################

$(eval $(call Package/$(PKG_NAME)/Example,curl))
$(eval $(call Package/$(PKG_NAME)/Example,insideout))
$(eval $(call Package/$(PKG_NAME)/Example,minimal))
$(eval $(call Package/$(PKG_NAME)/Example,rayo))
$(eval $(call Package/$(PKG_NAME)/Example,sbc))
$(eval $(call Package/$(PKG_NAME)/Example,softphone))
$(eval $(call Package/$(PKG_NAME)/Example,testing))
$(eval $(call Package/$(PKG_NAME)/Example,vanilla))
