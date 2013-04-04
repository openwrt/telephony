#
# Copyright (C) 2009-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
#
include $(TOPDIR)/rules.mk


PKG_NAME:=freeswitch
PKG_DISTNAME:=$(PKG_NAME)_git
PKG_VERSION:=1.3.17


#
# The latest FS git hash in PKG_SOURCE_VERSION can be obtained from http://fisheye.freeswitch.org
#
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://git.$(PKG_NAME).org/$(PKG_NAME).git
FS_DEFAULT_HEAD:=6af84a870c21836e20077f27a85d94fd382a02be
FS_LATEST_HEAD:=$(if $(DUMP),$(FS_DEFAULT_HEAD),$(shell git ls-remote $(PKG_SOURCE_URL) HEAD | cut -f1))
PKG_SOURCE_VERSION:=$(if $(CONFIG_FS_SOFIA_WITH_PULL_CURRENT),$(FS_LATEST_HEAD),$(FS_DEFAULT_HEAD))
PKG_SOURCE_VERSION_SHORT:=$(shell echo $(PKG_SOURCE_VERSION)|cut -b -7)
PKG_RELEASE:=$(PKG_SOURCE_VERSION_SHORT)
PKG_SOURCE_SUBDIR:=$(PKG_DISTNAME)
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR)-$(PKG_SOURCE_VERSION_SHORT).tar.bz2
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)


PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1


FS_MOD_AVAILABLE:= \
	abstraction \
	alsa \
	amr \
	amrwb \
	avmd \
	blacklist \
	bv \
	callcenter \
	cdr-csv \
	cdr-pg-csv \
	cdr-sqlite \
	celt \
	cepstral \
	cidlookup \
	cluechoo \
	codec2 \
	commands \
	conference \
	console \
	curl \
	dahdi-codec \
	db \
	dialplan-asterisk \
	dialplan-directory \
	dialplan-xml \
	dingaling \
	directory \
	distributor \
	dptools \
	easyroute \
	enum \
	erlang-event \
	esf \
	event-multicast \
	event-socket \
	event-zmq \
	expr \
	fifo \
	file-string \
	flite \
	fsk \
	fsv \
	g723-1 \
	g729 \
	gsmopen \
	h26x \
	h323 \
	hash \
	html5 \
	httapi \
	http-cache \
	ilbc \
	isac \
	java \
	json-cdr \
	lcr \
	local-stream \
	logfile \
	loopback \
	lua \
	managed \
	mp4 \
	mp4v \
	native-file \
	nibblebill \
	openzap \
	opus \
	oreka \
	portaudio \
	portaudio-stream \
	posix-timer \
	radius-cdr \
	redis \
	rss \
	rtmp \
	sangoma-codec \
	say-de \
	say-en \
	say-es \
	say-fa \
	say-fr \
	say-hu \
	say-it \
	say-nl \
	say-pt \
	say-ru \
	say-th \
	say-zh \
	shell-stream \
	silk \
	siren \
	skel \
	skinny \
	skypopen \
	sms \
	snapshot \
	snipe-hunt \
	sndfile \
	snmp \
	snom \
	sofia \
	sonar \
	spandsp \
	speex \
	spidermonkey \
	spidermonkey-core-db \
	spidermonkey-curl \
	spidermonkey-odbc \
	spidermonkey-socket \
	spidermonkey-teletone \
	spy \
	stress \
	syslog \
	timerfd \
	tone-stream \
	tts-commandline \
	unimrcp \
	valet-parking \
	vmd \
	voicemail \
	voicemail-ivr \
	vp8 \
	xml-cdr \
	xml-curl \
	xml-rpc \
	xml-scgi \
	yaml \


PKG_CONFIG_DEPENDS:= \
	CONFIG_FS_SOFIA_WITH_BUILTIN_ZRTP \
	CONFIG_FS_SOFIA_WITH_IPV6 \
	CONFIG_FS_SOFIA_WITH_MYSQL \
	CONFIG_FS_SOFIA_WITH_ODBC \
	CONFIG_FS_SOFIA_WITH_OPT \
	CONFIG_FS_SOFIA_WITH_PULL_CURRENT \
	CONFIG_FS_SOFIA_WITH_SCTP \
	$(patsubst %,CONFIG_PACKAGE_$(PKG_NAME)-mod-%,$(FS_MOD_AVAILABLE)) \


include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk


TAR_OPTIONS+= --strip-components=1 -C $(PKG_BUILD_DIR)


define Package/$(PKG_NAME)/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  URL:=http://www.$(PKG_NAME).org/
  MAINTAINER:=Mazilo <openwrt.forum.mazilo@recursor.net>
endef


define Package/$(PKG_NAME)
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH open source telephony platform ($(PKG_SOURCE_VERSION_SHORT))
  DEPENDS:=+libcurl +libiconv-full +libjpeg +libncurses +libpq +libpthread +librt +libstdcpp
  MENU:=1
endef


define Package/$(PKG_NAME)/description
  FreeSWITCH is an open source telephony platform designed to
  facilitate the creation of voice and chat driven products scaling
  from a soft-phone up to a soft-switch.  See http://wiki.$(PKG_NAME).org
endef


define Package/$(PKG_NAME)/config
    config FS_SOFIA_WITH_PULL_CURRENT
    depends on DEVEL
    depends on PACKAGE_$(PKG_NAME)
    bool "Pull the latest git HEAD - $(PKG_SOURCE_VERSION_SHORT) (Press < Help > for more information)"
    default n
    help
	This existing git HEAD ($(FS_DEFAULT_HEAD)) is probably outdated. 
	Enable this option for the latest git HEAD ($(FS_LATEST_HEAD)). 
	Enable this option ONLY if you know what you are doing. It may and/or may not be cleanly 
	compiled and may require some intervension to create new patches. If you take this route
	and come up with some patches, please contemplate to contribute or send in your patches.

    config FS_SOFIA_WITH_IPV6
    depends on PACKAGE_$(PKG_NAME)
    bool "Compile with IPV6 support"
    default y
    help
        Compile $(PKG_NAME) with IPV6 Support.

    config FS_SOFIA_WITH_OPT
    depends on PACKAGE_$(PKG_NAME)
    bool "Compile with optimization"
    default y
    help
        Compile $(PKG_NAME) with optimization enabled.

    config FS_SOFIA_WITH_BUILTIN_ZRTP
    depends on PACKAGE_$(PKG_NAME)
    bool "Compile with built-in ZRTP support"
    default y
    help
        Compile $(PKG_NAME)-mod-sofia with ZRTP Support.
endef


define Package/$(PKG_NAME)-mod-sofia/config
    config FS_SOFIA_WITH_MYSQL
    depends on PACKAGE_$(PKG_NAME)-mod-sofia
    bool "Compile with MySQL"
    default n
    select PACKAGE_libmysqlclient
    help
        Compile $(PKG_NAME) with MySQL.

    config FS_SOFIA_WITH_ODBC
    depends on PACKAGE_$(PKG_NAME)-mod-sofia
    depends on PACKAGE_sqliteodbc
    depends on PACKAGE_unixodbc_svn
    bool "Compile with ODBC support (Requires unixodbc_svn NOT YET AVAILABLE)"
    default n
    help
        Compile $(PKG_NAME)-mod-sofia with ODBC Support. Since both sqliteodbc and unixodbc_svn packages are not yet available on OpenWRT, $(PKG_NAME)-mod-sofia CAN NOT be compiled with ODBC support.

    config FS_SOFIA_WITH_SCTP
    depends on PACKAGE_$(PKG_NAME)-mod-sofia
    depends on PACKAGE_sctp
    bool "Compile with SCTP (Stream Control Transfer Protocol) support"
    default y
    help
        Compile $(PKG_NAME)-mod-sofia with SCTP support.
endef


define Package/$(PKG_NAME)-example-config
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH example config (commented)
  DEPENDS:= $(PKG_NAME)
endef


define Package/$(PKG_NAME)-example-config/description
  The default configuration included with FreeSWITCH. It is not intended to be
  a final product, and is thus moved to /usr/share/$(PKG_NAME)/examples/conf to
  be an example of how FreeSWITCH can be configured.
endef


define Package/$(PKG_NAME)-config-upstream-defaults
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH upstream config
  DEPENDS:= $(PKG_NAME)
endef


define Package/$(PKG_NAME)-config-upstream-defaults/description
  The default configuration included with FreeSWITCH. It is not intended to be
  a final product, and but is included for those who don't want to use the
  OpenWRT configuration and/or want to try things as prepared by upstream.
endef


define Package/$(PKG_NAME)-config-minimal
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH minimal config
  DEPENDS:= $(PKG_NAME)
endef


define Package/$(PKG_NAME)-config-minimal/description
  A minimal configuration of FreeSWITCH for OpenWRT devices.  Is what the UCI
  configuration began with.
endef


define Package/$(PKG_NAME)-collection-upstream-defaults
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FS upstream def sample conf
  DEPENDS:= $(PKG_NAME) \
		+$(PKG_NAME)-config-upstream-defaults \
		+$(PKG_NAME)-mod-callcenter \
		+$(PKG_NAME)-mod-codec2 \
		+$(PKG_NAME)-mod-commands \
		+$(PKG_NAME)-mod-conference \
		+$(PKG_NAME)-mod-curl \
		+$(PKG_NAME)-mod-dialplan-xml \
		+$(PKG_NAME)-mod-dingaling \
		+$(PKG_NAME)-mod-dptools \
		+$(PKG_NAME)-mod-event-socket \
		+$(PKG_NAME)-mod-g723-1 \
		+$(PKG_NAME)-mod-g729 \
		+$(PKG_NAME)-mod-hash \
		+$(PKG_NAME)-mod-http-cache \
		+$(PKG_NAME)-mod-ilbc \
		+$(PKG_NAME)-mod-local-stream \
		+$(PKG_NAME)-mod-lua \
		+$(PKG_NAME)-mod-native-file \
		+$(PKG_NAME)-mod-sndfile \
		+$(PKG_NAME)-mod-sofia \
		+$(PKG_NAME)-mod-spandsp \
		+$(PKG_NAME)-mod-speex \
		+$(PKG_NAME)-mod-syslog \
		+$(PKG_NAME)-mod-tone-stream \
		+$(PKG_NAME)-mod-xml-curl \
		+$(PKG_NAME)-mod-xml-rpc \
		+$(PKG_NAME)-tools
endef


define Package/$(PKG_NAME)-collection-minimal
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH minimal package collection
  DEFAULT:=y
  DEPENDS:= $(PKG_NAME) \
		+$(PKG_NAME)-config-minimal \
		+$(PKG_NAME)-mod-codec2 \
		+$(PKG_NAME)-mod-commands \
		+$(PKG_NAME)-mod-dialplan-xml \
		+$(PKG_NAME)-mod-dptools \
		+$(PKG_NAME)-mod-event-socket \
		+$(PKG_NAME)-mod-hash \
		+$(PKG_NAME)-mod-local-stream \
		+$(PKG_NAME)-mod-sndfile \
		+$(PKG_NAME)-mod-sofia \
		+$(PKG_NAME)-mod-syslog \
		+$(PKG_NAME)-mod-tone-stream \
		+$(PKG_NAME)-tools
endef


define Package/$(PKG_NAME)-sounds-en-08KHz
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH 8KHz english sounds
  DEPENDS:= $(PKG_NAME)
endef


define Package/$(PKG_NAME)-sounds-en-16KHz
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH 16KHz english sounds
  DEPENDS:= +$(PKG_NAME)-sounds-en-08KHz
endef


define Package/$(PKG_NAME)-sounds-en-32KHz
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH 32KHz english sounds
  DEPENDS:= +$(PKG_NAME)-sounds-en-16KHz
endef


define Package/$(PKG_NAME)-sounds-en-48KHz
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH 48KHz english sounds
  DEPENDS:= +$(PKG_NAME)-sounds-en-32KHz
endef


define Package/$(PKG_NAME)-sounds-moh-08KHz
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH 8KHz music-on-hold sounds
  DEPENDS:= $(PKG_NAME)
endef


define Package/$(PKG_NAME)-sounds-moh-16KHz
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH 16KHz music-on-hold sounds
  DEPENDS:= +$(PKG_NAME)-sounds-moh-08KHz
endef


define Package/$(PKG_NAME)-sounds-moh-32KHz
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH 32KHz music-on-hold sounds
  DEPENDS:= +$(PKG_NAME)-sounds-moh-16KHz
endef


define Package/$(PKG_NAME)-sounds-moh-48KHz
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH 48KHz music-on-hold sounds
  DEPENDS:= +$(PKG_NAME)-sounds-moh-32KHz
endef


define Package/$(PKG_NAME)-tools
$(call Package/$(PKG_NAME)/Default)
  TITLE:=FreeSWITCH control tools
  DEPENDS:= $(PKG_NAME)
endef


define Download/files
 define Download/$(1)
  FILE:=$(2)
  URL:=$(if $(4),$(4),http://files.$(PKG_NAME).org)/$(5)
  MD5SUM:=$(3)
 endef
 define Prepare/$(1)
  $(LN) $(DL_DIR)/$(2) $(PKG_BUILD_DIR)/$(6)
 endef
 $$(eval $$(call Download,$(1)))
endef


MAKE_INSTALL_TARGETS:=install


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-mod-celt),)
 $(eval $(call Download/files,celt,celt-0.10.0.tar.gz,a656f6176e9be84027c0e51ceedd710f,,downloads/libs/,libs/))
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-mod-curl),)
 $(eval $(call Download/files,json-cdr,json-c-0.9.tar.gz,4653b3b9c568bb9c782178abfaac128d,,downloads/libs/,libs/))
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-mod-event-zmq),)
 $(eval $(call Download/files,event-zmq,zeromq-2.1.9.tar.gz,94c5e0262a79c5f82bc0b178c1f8a33d,http://download.zeromq.org http://download.zeromq.org/historic,,libs/))
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-mod-flite),)
 $(eval $(call Download/files,flite,flite-1.5.4-current.tar.bz2,f3a2d88b1059f6f4ff3c20a8169bc0f4,,downloads/libs/,libs/))
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-mod-opus),)
 $(eval $(call Download/files,opus,opus-1.0.2.tar.gz,c503ad05a59ddb44deab96204401be03,,downloads/libs/,libs/))
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-sounds-en-08KHz),)
 $(eval $(call Download/files,sounds-en-08KHz,$(PKG_NAME)-sounds-en-us-callie-8000-1.0.24.tar.gz,6c0a8ec292e444dff10b652644f4fc54,,,))
	MAKE_INSTALL_TARGETS+= sounds-install
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-sounds-en-16KHz),)
 $(eval $(call Download/files,sounds-en-16KHz,$(PKG_NAME)-sounds-en-us-callie-16000-1.0.24.tar.gz,e9b5c1cdd393660d0cdf7de6b7e03c45,,,))
	MAKE_INSTALL_TARGETS+= hd-sounds-install
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-sounds-en-32KHz),)
 $(eval $(call Download/files,sounds-en-32KHz,$(PKG_NAME)-sounds-en-us-callie-32000-1.0.24.tar.gz,fa110675de07ca5f6d85646f3093b0ce,,,))
	MAKE_INSTALL_TARGETS+= uhd-sounds-install
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-sounds-en-48KHz),)
 $(eval $(call Download/files,sounds-en-48KHz,$(PKG_NAME)-sounds-en-us-callie-48000-1.0.24.tar.gz,813ea6eeae5545bb6e11664189691f8b,,,))
	MAKE_INSTALL_TARGETS+= cd-sounds-install
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-sounds-moh-08KHz),)
 $(eval $(call Download/files,sounds-moh-08KHz,$(PKG_NAME)-sounds-music-8000-1.0.8.tar.gz,f63ef3cc3507af079ae5c7b8b8a01e42,,,))
	MAKE_INSTALL_TARGETS+= moh-install
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-sounds-moh-16KHz),)
 $(eval $(call Download/files,sounds-moh-16KHz,$(PKG_NAME)-sounds-music-16000-1.0.8.tar.gz,7fd0ca9a9e3878783baa39b8187743bf,,,))
	MAKE_INSTALL_TARGETS+= hd-moh-install
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-sounds-moh-32KHz),)
 $(eval $(call Download/files,sounds-moh-32KHz,$(PKG_NAME)-sounds-music-32000-1.0.8.tar.gz,7e03932ea81b8d0bf6d686f838b060b4,,,))
	MAKE_INSTALL_TARGETS+= uhd-moh-install
endif


ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-sounds-moh-48KHz),)
 $(eval $(call Download/files,sounds-moh-48KHz,$(PKG_NAME)-sounds-music-48000-1.0.8.tar.gz,d06cd2a80379f224affab21f5180e4c6,,,))
	MAKE_INSTALL_TARGETS+= cd-moh-install
endif


#
# XXX: -fgnu89-inline is not supported on all compiler versions, so only enable it on avr32 where it solves build issues
#
ifneq ($(CONFIG_avr32),)
  TARGET_CFLAGS += -fgnu89-inline
  TARGET_CXXFLAGS += -fgnu89-inline
endif


ifneq ($(CONFIG_USE_EGLIBC),)
  ifeq ($(CONFIG_EGLIBC_OPTION_EGLIBC_UTMP),)
    TARGET_CFLAGS += -DNO_GETLOGIN
  endif
endif


FS_TARGET_CFLAGS:= $(TARGET_CFLAGS) -DLUA_USE_LINUX $(FPIC) -std=gnu99 -Wno-format
FS_TARGET_CXXFLAGS:= $(TARGET_CXXFLAGS) -DLUA_USE_LINUX $(FPIC) -Wno-format
FS_TARGET_CPPFLAGS:= -I. -I./lua $(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-erlang-event),-I$(STAGING_DIR_HOST)/lib/erlang/lib/erl_interface-3.6/include) $(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-json-cdr),-Wno-error) $(TARGET_CPPFLAGS)


CONFIGURE_ARGS+= \
	--host=$(GNU_TARGET_NAME) \
	--build=$(GNU_HOST_NAME) \
	--prefix="/usr/share/$(PKG_NAME)" \
	--bindir="/usr/bin" \
	--libdir="/usr/lib" \
	--srcdir="$(PKG_BUILD_DIR)" \
	--sysconfdir="/etc/$(PKG_NAME)" \
	--with-modinstdir="/usr/lib/$(PKG_NAME)" \
	--with-random="/dev/urandom" \
	$(if $(CONFIG_FS_SOFIA_WITH_MYSQL),--with-mysql,--without-mysql) \
	$(call autoconf_bool,CONFIG_FS_SOFIA_WITH_IPV6,ipv6) \
	$(call autoconf_bool,CONFIG_FS_SOFIA_WITH_OPT,optimization) \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-celt),--with-ogg="$(STAGING_DIR)/usr",--without-iogg) \
	$(if ($(CONFIG_PACKAGE_$(PKG_NAME)-mod-curl)|$(CONFIG_PACKAGE_$(PKG_NAME)-mod-xml-cdr)|$(CONFIG_PACKAGE_$(PKG_NAME)-mod-xml-curl)),--with-libcurl="$(STAGING_DIR)/usr",--without-libcurl) \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-java),--with-java="$(STAGING_DIR)/usr",--without-java) \
	$(call autoconf_bool,CONFIG_PACKAGE_$(PKG_NAME)-mod-spandsp,builtin-tiff) \
	$(call autoconf_bool,CONFIG_PACKAGE_$(PKG_NAME)-mod-timerfd,timerfd-wrapper) \
	$(call autoconf_bool,CONFIG_FS_SOFIA_WITH_BUILTIN_ZRTP,zrtp) \
	$(call autoconf_bool,CONFIG_FS_SOFIA_WITH_ODBC,core-odbc-support) \
	$(if $(CONFIG_FS_SOFIA_WITH_ODBC),--with-odbc="$(STAGING_DIR)/usr") \
	$(if $(CONFIG_FS_SOFIA_WITH_ODBC),--with-odbc-lib="$(STAGING_DIR)/usr/lib") \


CONFIGURE_VARS+= \
	config_TARGET_CC="$(TOOLCHAIN_DIR)/bin/$(TARGET_CC)" \
	config_TARGET_CFLAGS="$(FS_TARGET_CPPFLAGS) $(FS_TARGET_CFLAGS)" \
	config_TARGET_CXX="$(TOOLCHAIN_DIR)/bin/$(TARGET_CXX)" \
	config_TARGET_CXXFLAGS="$(FS_TARGET_CPPFLAGS) $(FS_TARGET_CXXFLAGS)" \
	config_TARGET_CPPFLAGS="$(FS_TARGET_CPPFLAGS)" \
	config_TARGET_READLINE_INC="$(FS_TARGET_CPPFLAGS)" \
	config_TARGET_READLINE_LIBS="$(TARGET_LDFLAGS) -lreadline -lncurses" \
	config_TARGET_LIBS="$(TARGET_LDFLAGS) -lpthread -ldl" \
	config_BUILD_CC="$(HOSTCC)" \
	config_BUILD_CFLAGS="$(HOST_CFLAGS)" \
	CC_FOR_BUILD="$(HOSTCC)" \
	BUILDTOOL_CC="$(HOSTCC)" \
	BUILDTOOL_CCLD="$(HOSTCC)" \
	LDFLAGS="$$$$LDFLAGS" \
	LDFLAGS_FOR_BUILD="$(HOST_LDFLAGS)" \
	CC="$(TOOLCHAIN_DIR)/bin/$(TARGET_CC)" \
	CXX="$(TOOLCHAIN_DIR)/bin/$(TARGET_CXX)" \
	AR="$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)ar" \
	RANLIB="$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)ranlib" \
	CFLAGS="$(FS_TARGET_CPPFLAGS) $(FS_TARGET_CFLAGS)" \
	CXXFLAGS="$(FS_TARGET_CPPFLAGS) $(FS_TARGET_CXXFLAGS)" \
	CPPFLAGS="$(FS_TARGET_CPPFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS) -Wl,-rpath-link=\"$(STAGING_DIR)/usr/lib\"" \
	PATH="$(PATH):$(STAGING_DIR)" \
	HOST_CC="/usr/bin/cc" \
	HOST_CXX="/usr/bin/g++" \
	CROSS_COMPILE="1" \
	PKG_CONFIG="$(STAGING_DIR_HOST)/bin/pkg-config" \
	PKG_CONFIG_PATH="$(STAGING_DIR_HOST)/lib/pkgconfig" \
	ax_cv_c_compiler_vendor="gnu" \
	ac_cv_dev_urandom="yes" \
	ac_cv_file_dbd_apr_dbd_mysql_c="no" \
	ac_cv_file__dev_random="no" \
	ac_cv_file__dev_urandom="yes" \
	ac_cv_file___dev_urandom_="yes" \
	ac_cv_func_mmap_fixed_mapped="yes" \
	ac_cv_func_pthread_rwlock_init="yes" \
	ac_cv_struct_rlimit="yes" \
	apr_cv_mutex_recursive="yes" \
	apr_cv_process_shared_works="no" \
	apr_cv_tcp_nodelay_with_cork="yes" \
	apr_cv_type_rwlock_t="yes" \
	$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-perl),ac_cv_path_PERL="yes",) \
	libzmq_cv_cxx_werror_flag="" \


define Build/Prepare
	$(call Build/Prepare/Default)
	$(call Prepare/celt)
	$(call Prepare/event-zmq)
	$(call Prepare/flite)
	$(call Prepare/json-cdr)
	$(call Prepare/opus)
	$(call Prepare/sounds-en-08KHz)
	$(call Prepare/sounds-en-16KHz)
	$(call Prepare/sounds-en-32KHz)
	$(call Prepare/sounds-en-48KHz)
	$(call Prepare/sounds-moh-08KHz)
	$(call Prepare/sounds-moh-16KHz)
	$(call Prepare/sounds-moh-32KHz)
	$(call Prepare/sounds-moh-48KHz)
endef


define Build/Configure
	if [ -d $(PKG_BUILD_DIR)/libs/libcodec2/src ]; then \
		(cd $(PKG_BUILD_DIR)/libs/libcodec2/src; $(HOSTCC) -c generate_codebook.c; $(HOSTCC) -o generate_codebook generate_codebook.o -lm) \
	fi
	(cd $(PKG_BUILD_DIR); $(AM_TOOL_PATHS) ./bootstrap.sh)
	$(call Build/Configure/Default,)
	$(foreach m,$(FS_MOD_AVAILABLE),
		$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-$(m)),
			$(SED) 's|^[ #]*\([^#]*/mod_$(subst -,_,$(m))\)$$$$|\1|g' $(PKG_BUILD_DIR)/modules.conf
		,
			$(SED) 's|^\([^#]*/mod_$(subst -,_,$(m))\)$$$$|#\1|g' $(PKG_BUILD_DIR)/modules.conf
		)
	)
endef


define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		AR="$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)ar" \
		RANLIB="$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)ranlib" \
		CC="$(TOOLCHAIN_DIR)/bin/$(TARGET_CC)" \
		CXX="$(TOOLCHAIN_DIR)/bin/$(TARGET_CXX)" \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		LDFLAGS_FOR_BUILD="$(HOST_LDFLAGS)" \
		all $(MAKE_INSTALL_TARGETS)
	$(SED) 's|^\([ \t]*\)\(.*\)"mod_console"\(.*\)$$$$|\1<!-- \2"mod_console"\3 -->|' $(PKG_INSTALL_DIR)/etc/$(PKG_NAME)/autoload_configs/modules.conf.xml
	$(SED) 's|^\([ \t]*\)<!-- *\(.*\)"mod_syslog"\(.*\) *-->\(.*\)$$$$|\1\2"mod_syslog"\3\4|' $(PKG_INSTALL_DIR)/etc/$(PKG_NAME)/autoload_configs/modules.conf.xml
endef


define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/$(PKG_NAME)
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/include/* $(1)/usr/include/$(PKG_NAME)/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib$(PKG_NAME).{a,so*} $(1)/usr/lib/
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/default
	$(INSTALL_DIR) $(1)/etc/$(PKG_NAME)
	$(INSTALL_DIR) $(1)/etc/$(PKG_NAME)/scripts
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(INSTALL_BIN) ./files/$(PKG_NAME).init $(1)/etc/init.d/$(PKG_NAME)
	$(INSTALL_DATA) ./files/$(PKG_NAME).config $(1)/etc/config/$(PKG_NAME)
	$(INSTALL_DATA) ./files/$(PKG_NAME).default $(1)/etc/default/$(PKG_NAME)
	$(INSTALL_DATA) ./files/$(PKG_NAME).hotplug $(1)/etc/hotplug.d/iface/90-$(PKG_NAME)
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/$(PKG_NAME) $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib$(PKG_NAME)* $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/$(PKG_NAME).pc $(1)/usr/lib/pkgconfig/
	$(if $(1)/usr/lib/lib$(PKG_NAME).la,sed -i -e "s#-lcurl -lz\(.*\)/usr/lib/libexpat.la\(.*\)$(TOOLCHAIN_DIR)/$(REAL_GNU_TARGET_NAME)\(.*\)#-L/usr/lib -lcurl -lz /usr/lib/libexpat.la\2/usr\3#g" $(1)/usr/lib/lib$(PKG_NAME).la)
endef


define Package/$(PKG_NAME)-collection-upstream-defaults/install
	$(INSTALL_DIR) $(1)/etc/$(PKG_NAME)
endef


define Package/$(PKG_NAME)-example-config/install
	$(INSTALL_DIR) $(1)/usr/share/$(PKG_NAME)/examples/conf
	$(CP) $(PKG_INSTALL_DIR)/etc/$(PKG_NAME)/* $(1)/usr/share/$(PKG_NAME)/examples/conf/
endef


define Package/$(PKG_NAME)-config-upstream-defaults/install
	$(INSTALL_DIR) $(1)/etc/$(PKG_NAME)
	$(CP) $(PKG_INSTALL_DIR)/etc/$(PKG_NAME) $(1)/etc
endef


define Package/$(PKG_NAME)-collection-minimal/install
	$(INSTALL_DIR) $(1)/etc/$(PKG_NAME)
endef


define Package/$(PKG_NAME)-collection-uci-minimal/install
	$(INSTALL_DIR) $(1)/etc/$(PKG_NAME)
endef


define Package/$(PKG_NAME)-config-minimal/install
	$(INSTALL_DIR) $(1)/etc/$(PKG_NAME)/autoload_configs

	#
	# Copying dialplan directory jingle_profiles sip_profiles $(PKG_NAME).xml
	# fur_elise.ttml mime.types tetris.ttml tones.conf vars.xml
	#
	$(foreach f,dialplan directory jingle_profiles sip_profiles $(PKG_NAME).xml fur_elise.ttml mime.types tetris.ttml tones.conf vars.xml,$(if $(PKG_BUILD_DIR)/conf/vanilla/$(f),$(CP) $(PKG_BUILD_DIR)/conf/vanilla/$(f) $(1)/etc/$(PKG_NAME);))

	#
	# Copying acl ivr modules post_load_modules switch timezones
	#
	$(foreach f,acl ivr modules post_load_modules switch timezones,$(if $(PKG_BUILD_DIR)/conf/vanilla/autoload_configs/$(f).conf.xml,$(CP) $(PKG_BUILD_DIR)/conf/vanilla/autoload_configs/$(f).conf.xml $(1)/etc/$(PKG_NAME)/autoload_configs;))
endef


define Package/$(PKG_NAME)-sounds-en-08KHz/install
	#
	# sounds-en-8KHz
	#
	for dir in `(cd $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/en/us/callie;ls)`; \
	do \
		[ -d $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/8000 ] || $(INSTALL_DIR) $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/8000; \
		$(CP) $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/8000/* $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/8000; \
	done
endef


define Package/$(PKG_NAME)-sounds-en-16KHz/install
	#
	# sounds-en-16KHz
	#
	for dir in `(cd $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/en/us/callie;ls)`; \
	do \
		[ -d $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/16000 ] || $(INSTALL_DIR) $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/16000; \
		$(CP) $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/16000/* $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/16000; \
	done
endef


define Package/$(PKG_NAME)-sounds-en-32KHz/install
	#
	# sounds-en-32KHz
	#
	for dir in `(cd $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/en/us/callie;ls)`; \
	do \
		[ -d $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/32000 ] || $(INSTALL_DIR) $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/32000; \
		$(CP) $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/32000/* $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/32000; \
	done
endef


define Package/$(PKG_NAME)-sounds-en-48KHz/install
	#
	# sounds-en-48KHz
	#
	for dir in `(cd $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/en/us/callie;ls)`; \
	do \
		[ -d $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/48000 ] || $(INSTALL_DIR) $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/48000; \
		$(CP) $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/48000/* $(1)/usr/share/$(PKG_NAME)/sounds/en/us/callie/$$$${dir}/48000; \
	done
endef


define Package/$(PKG_NAME)-sounds-moh-08KHz/install
	#
	# sounds-moh-8KHz
	#
	[ -d $(1)/usr/share/$(PKG_NAME)/sounds/music/8000 ] || $(INSTALL_DIR) $(1)/usr/share/$(PKG_NAME)/sounds/music/8000;
	$(CP) $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/music/8000 $(1)/usr/share/$(PKG_NAME)/sounds/music;
endef


define Package/$(PKG_NAME)-sounds-moh-16KHz/install
	#
	# sounds-moh-16KHz
	#
	[ -d $(1)/usr/share/$(PKG_NAME)/sounds/music/16000 ] || $(INSTALL_DIR) $(1)/usr/share/$(PKG_NAME)/sounds/music/16000;
	$(CP) $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/music/16000 $(1)/usr/share/$(PKG_NAME)/sounds/music;
endef


define Package/$(PKG_NAME)-sounds-moh-32KHz/install
	#
	# sounds-moh-32KHz
	#
	[ -d $(1)/usr/share/$(PKG_NAME)/sounds/music/32000 ] || $(INSTALL_DIR) $(1)/usr/share/$(PKG_NAME)/sounds/music/32000;
	$(CP) $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/music/32000 $(1)/usr/share/$(PKG_NAME)/sounds/music;
endef


define Package/$(PKG_NAME)-sounds-moh-48KHz/install
	#
	# sounds-moh-48KHz
	#
	[ -d $(1)/usr/share/$(PKG_NAME)/sounds/music/48000 ] || $(INSTALL_DIR) $(1)/usr/share/$(PKG_NAME)/sounds/music/48000;
	$(CP) $(PKG_INSTALL_DIR)/usr/share/$(PKG_NAME)/sounds/music/48000 $(1)/usr/share/$(PKG_NAME)/sounds/music;
endef


define Package/$(PKG_NAME)-tools/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/fs_cli $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/fs_encode $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/fs_ivrd $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/fsxs $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/gentls_cert $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/tone2wav $(1)/usr/bin/
endef


#
# 1. Name
# 2. Title
# 3. Package configuration files
# 4. Inter module depends
# 5. Extra depends
#
define BuildLib
  define Package/$(PKG_NAME)-$(1)
    $$(call Package/$(PKG_NAME)/Default)
    TITLE:= FS $(2) library and pkgconfig files
    DEPENDS:= $(PKG_NAME) $(foreach l,$(4),+$(PKG_NAME)-$(l)) $(5)
  endef

  define Package/$(PKG_NAME)-$(1)/install
	[ -d "$$(1)/usr/lib/pkgconfig" ] || $(INSTALL_DIR) $$(1)/usr/lib/pkgconfig

	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/$(patsubst lib%,%,$(3)).pc $$(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(1)* $$(1)/usr/lib/
	$(if $$(1)/usr/lib/$(1).la,sed -i -e "s#\(^.*\)=' \(.*\)-lm\(.*\)#\1=' -L/usr/lib -L/usr/lib/libiconv-full/lib -L/usr/lib/libintl-full/lib -lm\3#g" $$(1)/usr/lib/$(1).la)
  endef

  $$(eval $$(call BuildPackage,$(PKG_NAME)-$(1)))
endef


#
# 1. Name
# 2. Title
# 3. Selection on module configuration file
# 4. Files (module files include different names)
# 5. Files (supporting files include different names)
# 6. Inter module depends
# 7. Extra depends
#
define BuildPlugin
  define Package/$(PKG_NAME)-mod-$(1)
    $$(call Package/$(PKG_NAME)/Default)
    TITLE:= FS $(2) module
    DEPENDS:= $(PKG_NAME) $(foreach m,$(6),+$(PKG_NAME)-mod-$(m)) $(7)
  endef

  define Package/$(PKG_NAME)-mod-$(1)/install
	[ -z "mod_$(subst -,_,$(1))" ] || $(INSTALL_DIR) $$(1)/usr/lib/$(PKG_NAME)

	for f in $$$$(realpath $$$$(wildcard $(PKG_INSTALL_DIR)/usr/lib/$(PKG_NAME)/mod_$(subst -,_,$(1)).*)) $$$$(wildcard $(PKG_INSTALL_DIR)/usr/lib/$(PKG_NAME)/$(4)_*); \
	do \
		$(CP) $$$$$$$${f} $$(1)/usr/lib/$(PKG_NAME)/; \
	done

	#
	# mod_$(subst -,_,$(1)): $(5)
	#
	$(foreach f,$(5),[ -d $(dir $$(1)/usr/${f}) ] || $(INSTALL_DIR) $(dir $$(1)/usr/${f});$(CP) $(PKG_INSTALL_DIR)/usr/${f} $$(1)/usr;)

	#
	# mod_$(subst -,_,$(1)): Clean installed library control files from referencig to OpenWRT PATH.
	#
	for f in `ls $$(1)/usr/lib/$(PKG_NAME)/*.la`; \
	do \
		sed -i -e "s#' \(.*\)/usr/lib/libexpat.la\(.*\)$(TOOLCHAIN_DIR)/$(REAL_GNU_TARGET_NAME)\(.*\)#' -L/usr/lib -L/usr/lib/libiconv-full/lib -L/usr/lib/libintl-full/lib /usr/lib/lib$(PKG_NAME).la /usr/lib/libexpat.la\2/usr\3#g;s#' \(.*\)/usr/lib/libintl-full/lib#' -L/usr/lib -L/usr/lib/libiconv-full/lib -L/usr/lib/libintl-full/lib#g;s#-L\.\.##g;s#$(PKG_BUILD_DIR)\(.*\)/usr/lib/libtiff.la\(.*\)#/usr/lib/libtiff.la\2#g" $$$$$$$${f}; \
	done

	#
	# 1. mod_$(subst -,_,$(1)) XML configuration files from: $$$$(patsubst $(PKG_BUILD_DIR)/%,%,$$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/conf/$(3)/autoload_configs/$(subst -,_,$(1)).conf.xml)))
	#
	$$$$(if $$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/conf/$(3)/autoload_configs/$(subst -,_,$(1)).conf.xml)),[ -d $$(1)/etc/$(PKG_NAME)/autoload_configs ] || $(INSTALL_DIR) $$(1)/etc/$(PKG_NAME)/autoload_configs;$(CP) $$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/conf/$(3)/autoload_configs/$(subst -,_,$(1)).conf.xml)) $$(1)/etc/$(PKG_NAME)/autoload_configs)

	#
	# 2. mod_$(subst -,_,$(1)) XML configuration files from: $$$$(patsubst $(PKG_BUILD_DIR)/%,%,$$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/$(3)/$(1)/*/$(subst -,_,$(1)).conf.xml)))
	#
	$$$$(if $$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/$(3)/$(1)/*/$(subst -,_,$(1)).conf.xml)),[ -d $$(1)/etc/$(PKG_NAME)/autoload_configs ] || $(INSTALL_DIR) $$(1)/etc/$(PKG_NAME)/autoload_configs;$(CP) $$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/$(3)/$(1)/*/$(subst -,_,$(1)).conf.xml)) $$(1)/etc/$(PKG_NAME)/autoload_configs)

	#
	# 3. mod_$(subst -,_,$(1)) XML configuration files from: $$$$(patsubst $(PKG_BUILD_DIR)/%,%,$$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/src/$(3)/*/mod_$(subst -,_,$(1))/conf/autoload_configs/$(subst -,_,$(1)).conf.xml)))
	#
	$$$$(if $$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/src/$(3)/*/mod_$(subst -,_,$(1))/conf/autoload_configs/$(subst -,_,$(1)).conf.xml)),[ -d $$(1)/etc/$(PKG_NAME)/autoload_configs ] || $(INSTALL_DIR) $$(1)/etc/$(PKG_NAME)/autoload_configs;$(CP) $$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/src/$(3)/*/mod_$(subst -,_,$(1))/conf/autoload_configs/$(subst -,_,$(1)).conf.xml)) $$(1)/etc/$(PKG_NAME)/autoload_configs)

	#
	# 4. mod_$(subst -,_,$(1)) XML configuration files from: $$$$(patsubst $(PKG_BUILD_DIR)/%,%,$$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/src/$(3)/*/mod_$(subst -,_,$(1))/conf*/$(subst -,_,$(1)).conf.xml)))
	#
	$$$$(if $$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/src/$(3)/*/mod_$(subst -,_,$(1))/conf*/$(subst -,_,$(1)).conf.xml)),[ -d $$(1)/etc/$(PKG_NAME)/autoload_configs ] || $(INSTALL_DIR) $$(1)/etc/$(PKG_NAME)/autoload_configs;$(CP) $$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/src/$(3)/*/mod_$(subst -,_,$(1))/conf*/$(subst -,_,$(1)).conf.xml)) $$(1)/etc/$(PKG_NAME)/autoload_configs)

	#
	# 5. mod_$(subst -,_,$(1)) XML configuration files from: $$$$(patsubst $(PKG_BUILD_DIR)/%,%,$$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/src/$(3)/*/mod_$(subst -,_,$(1))/$(subst -,_,$(1)).conf.xml)))
	#
	$$$$(if $$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/src/$(3)/*/mod_$(subst -,_,$(1))/$(subst -,_,$(1)).conf.xml)),[ -d $$(1)/etc/$(PKG_NAME)/autoload_configs ] || $(INSTALL_DIR) $$(1)/etc/$(PKG_NAME)/autoload_configs;$(CP) $$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/src/$(3)/*/mod_$(subst -,_,$(1))/$(subst -,_,$(1)).conf.xml)) $$(1)/etc/$(PKG_NAME)/autoload_configs)

	#
	# 6. Additional configuration files for mod_$(subst -,_,$(1)) from: $$$$(patsubst $(PKG_BUILD_DIR)/%,%,$$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/conf/$(3)/$(1)/*.$(1))))
	#
	$$$$(if $$$$(firstword $$$$(wildcard $(PKG_BUILD_DIR)/conf/$(3)/$(1)/*.$(1))),[ -d $$(1)/etc/$(PKG_NAME)/$(1) ] || $(INSTALL_DIR) $$(1)/etc/$(PKG_NAME)/$(1);$(CP) $(PKG_BUILD_DIR)/conf/$(3)/$(1) $$(1)/etc/$(PKG_NAME))
  endef

  define Package/$(PKG_NAME)-mod-$(1)/postinst
#!/bin/sh
sed -i -e 's|^\([ \t]*\)<!-- *\(.*\)"mod_$(subst -,_,$(1))"\(.*\) *-->\(.*\)$$$$|\1\2"mod_$(subst -,_,$(1))"\3\4|' $$$${IPKG_INSTROOT}/etc/$(PKG_NAME)/autoload_configs/modules.conf.xml
  endef

  define Package/$(PKG_NAME)-mod-$(1)/prerm
#!/bin/sh
sed -i -e 's|^\([ \t]*\)\(.*\)"mod_$(subst -,_,$(1))"\(.*\)$$$$|\1<!-- \2"mod_$(subst -,_,$(1))"\3 -->|' $$$${IPKG_INSTROOT}/etc/$(PKG_NAME)/autoload_configs/modules.conf.xml
  endef

  $$(eval $$(call BuildPackage,$(PKG_NAME)-mod-$(1)))
endef


$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-collection-upstream-defaults))
$(eval $(call BuildPackage,$(PKG_NAME)-collection-minimal))
$(eval $(call BuildPackage,$(PKG_NAME)-sounds-en-08KHz))
$(eval $(call BuildPackage,$(PKG_NAME)-sounds-en-16KHz))
$(eval $(call BuildPackage,$(PKG_NAME)-sounds-en-32KHz))
$(eval $(call BuildPackage,$(PKG_NAME)-sounds-en-48KHz))
$(eval $(call BuildPackage,$(PKG_NAME)-sounds-moh-08KHz))
$(eval $(call BuildPackage,$(PKG_NAME)-sounds-moh-16KHz))
$(eval $(call BuildPackage,$(PKG_NAME)-sounds-moh-32KHz))
$(eval $(call BuildPackage,$(PKG_NAME)-sounds-moh-48KHz))
$(eval $(call BuildPackage,$(PKG_NAME)-tools))
$(eval $(call BuildPackage,$(PKG_NAME)-example-config))
$(eval $(call BuildPackage,$(PKG_NAME)-config-upstream-defaults))
$(eval $(call BuildPackage,$(PKG_NAME)-config-minimal))


#
# $(eval $(call BuildLib,Name,Title,Package Configuration Files,Inter Depends,Extra Depends))
#
$(eval $(call BuildLib,libopenzap,OpenZAP,openzap,,))


#
# $(eval $(call BuildPlugin,Name,Title,Selection on module Conf File,Files,Inter Depends,Extra Depends))
#
$(eval $(call BuildPlugin,abstraction,An Abstraction To API Call,vanilla,,,,))
$(eval $(call BuildPlugin,alsa,Alsa Endpoint,vanilla,,,,+alsa-lib))
$(eval $(call BuildPlugin,amr,Adaptive Multi-Rate On Bandwidth Codec,vanilla,,,,))
$(eval $(call BuildPlugin,amrwb,Wide Band AMR,vanilla,,,,))
$(eval $(call BuildPlugin,avmd,Advanced Voice Mail Detection,vanilla,,,,))
$(eval $(call BuildPlugin,blacklist,Blacklist,vanilla,,,,))
$(eval $(call BuildPlugin,bv,BroadVoice 16/32-bit Audio Codec,vanilla,,,,))
$(eval $(call BuildPlugin,callcenter,Call Center,vanilla,,,,))
$(eval $(call BuildPlugin,cdr-csv,CSV-CDR Handler,mod,,,,)) # ~/conf
$(eval $(call BuildPlugin,cdr-pg-csv,Postgress CDR Handler,vanilla,,,,+coreutils +libpq))
$(eval $(call BuildPlugin,cdr-sqlite,SQLite3 CDR Handler,vanilla,,,,+libsqlite3))
$(eval $(call BuildPlugin,celt,CELT Ultra-Low Delay Codec,vanilla,,,,+libogg))
$(eval $(call BuildPlugin,cepstral,Cepstral Interface,vanilla,,,,@BROKEN)) # needs <swift.h>
$(eval $(call BuildPlugin,cidlookup,Data Query For CID->NAME Services,mod,,,,+libcurl)) # ~/conf
$(eval $(call BuildPlugin,cluechoo,Framework Demo,vanilla,,,,))
$(eval $(call BuildPlugin,codec2,CoDec 2,,,,,))
$(eval $(call BuildPlugin,commands,API Commands,vanilla,,,,))
$(eval $(call BuildPlugin,conference,Conference Room,vanilla,,,,))
$(eval $(call BuildPlugin,console,Console Logger,vanilla,,,,))
$(eval $(call BuildPlugin,curl,HTTP Request,vanilla,,,,+libcurl))
$(eval $(call BuildPlugin,dahdi-codec,DAHDI Codecs,vanilla,,,,))
$(eval $(call BuildPlugin,db,Database Backend,vanilla,,,,))
$(eval $(call BuildPlugin,dialplan-asterisk,Asterisk Dialplan Parser,vanilla,,,,))
$(eval $(call BuildPlugin,dialplan-directory,Dialplan Directory,vanilla,,,,))
$(eval $(call BuildPlugin,dialplan-xml,Dialplan-XML Interface,vanilla,,,,))
$(eval $(call BuildPlugin,dingaling,Jabber Interface,vanilla,,,,+libgcrypt +libopenssl))
$(eval $(call BuildPlugin,directory,Search By Name Directory IVR,vanilla,,,,))
$(eval $(call BuildPlugin,distributor,Simple Robin-Round Load to Gateway,vanilla,,,,))
$(eval $(call BuildPlugin,dptools,Dialplan Tools,vanilla,,,,))
$(eval $(call BuildPlugin,easyroute,Simple DID Routing,vanilla,,,,))
$(eval $(call BuildPlugin,enum,ENUM Routing,,,,,))
$(eval $(call BuildPlugin,erlang-event,Erlang Event Handler,vanilla,,,,+erlang))
$(eval $(call BuildPlugin,esf,Extra SIP Functionality,vanilla,,,,))
$(eval $(call BuildPlugin,event-multicast,Multicast Event Handler,vanilla,,,,))
$(eval $(call BuildPlugin,event-socket,Socket Event Handler,vanilla,,,,))
$(eval $(call BuildPlugin,event-zmq,Socket Event Handler By Zero MQ,vanilla,,,,+libuuid))
$(eval $(call BuildPlugin,expr,Expression Evaluation,vanilla,,,,))
$(eval $(call BuildPlugin,fifo,FIFO,vanilla,,,,))
$(eval $(call BuildPlugin,file-string,Streaming Multiple Sound Files Sequentially,vanilla,,,,@OBSOLETE)) # merged into dptools
$(eval $(call BuildPlugin,flite,Festival TTS,vanilla,,,,@(!(armeb||avr32)||BROKEN)))
$(eval $(call BuildPlugin,fsk,Bell-202 1200-Baud FSK Decoder,vanilla,,,,))
$(eval $(call BuildPlugin,fsv,Video Player / Recorder,vanilla,,,,))
$(eval $(call BuildPlugin,g723-1,G.723.1 Codec,vanilla,,,,))
$(eval $(call BuildPlugin,g729,G.729 Codec,vanilla,,,,))
$(eval $(call BuildPlugin,gsmopen,GSM Modem compatible Endpoint,mod,,,,+alsa-lib @BROKEN)) # needs gsmlib
$(eval $(call BuildPlugin,h26x,H26X Linear Codec,vanilla,,,,))
$(eval $(call BuildPlugin,h323,H323 Endpoint,mod,,,,@BROKEN)) # Req. H323Plus v1.24.x or newer
$(eval $(call BuildPlugin,hash,API For Manipulating A Hash Table,vanilla,,,,))
$(eval $(call BuildPlugin,html5,HTML5 Endpoint Module,vanilla,,,,))
$(eval $(call BuildPlugin,httapi,HT Telephony API and HTTP Caching,mod,,,,)) # ~/conf
$(eval $(call BuildPlugin,http-cache,HTTP GET With Caching,mod,,,,+libcurl)) # ~/conf
$(eval $(call BuildPlugin,ilbc,ILBC Codec,vanilla,,,,))
$(eval $(call BuildPlugin,isac,iSAC Codec,vanilla,,,,))
$(eval $(call BuildPlugin,java,Java Language Interface,vanilla,,,,@BROKEN)) # needs java
$(eval $(call BuildPlugin,json-cdr,JSon-CDR Interface,mod,,,,+libcurl))
$(eval $(call BuildPlugin,lcr,Least Cost Routing,vanilla,,,,))
$(eval $(call BuildPlugin,local-stream,Multi-Channel On Same Stream,vanilla,,,,))
$(eval $(call BuildPlugin,logfile,File Logger,vanilla,,,,))
$(eval $(call BuildPlugin,loopback,Loopback to Dialplan Endpoint,vanilla,,,,))
$(eval $(call BuildPlugin,lua,LUA Language Interface,vanilla,,,,))
$(eval $(call BuildPlugin,managed,Media Switching Software Library,vanilla,,,,+glib2 @BROKEN)) # needs Mono
$(eval $(call BuildPlugin,mp4,MP4 File Format Support For Video,vanilla,,,,@BROKEN)) # needs libmp4v2
$(eval $(call BuildPlugin,mp4v,MP4 CoDec Support For Video,vanilla,,,,))
$(eval $(call BuildPlugin,native-file,WAV Format Sound Player,vanilla,,,,))
$(eval $(call BuildPlugin,nibblebill,Credit / Debit Billing,vanilla,,,,))
$(eval $(call BuildPlugin,oreka,Media Recording with Oreka,vanilla,,,,))
$(eval $(call BuildPlugin,openzap,Zaptel (Superseded by FreeTDM),libs,ozmod,,,+$(PKG_NAME)-libopenzap +libpcap))
$(eval $(call BuildPlugin,opus,Opus CoDec,vanilla,,,,))
$(eval $(call BuildPlugin,portaudio,Portaudio To Sound Card Interface,vanilla,,,,+alsa-lib))
$(eval $(call BuildPlugin,portaudio-stream,Portaudio Streaming Interface,vanilla,,,,+alsa-lib))
$(eval $(call BuildPlugin,posix-timer,POSIX Compliant Soft Timer,vanilla,,,,))
$(eval $(call BuildPlugin,radius-cdr,Radius-CDR interface,vanilla,,,,+freeradius2 @BROKEN)) # fails in freeradius-client
$(eval $(call BuildPlugin,redis,Redis Limited Backend,vanilla,,,,))
$(eval $(call BuildPlugin,rss,RRS Feeds via TTS,vanilla,,,,))
$(eval $(call BuildPlugin,rtmp,RTMP Protocol Handler,vanilla,,,,))
$(eval $(call BuildPlugin,sangoma-codec,Sangoma Codec,vanilla,,,,@BROKEN)) # Req. Sangoma CoDec source
$(eval $(call BuildPlugin,say-de,German Say,vanilla,,,,))
$(eval $(call BuildPlugin,say-en,English Say,vanilla,,,,))
$(eval $(call BuildPlugin,say-es,Spanish Say,vanilla,,,,))
$(eval $(call BuildPlugin,say-fa,Persian Say,vanilla,,,,))
$(eval $(call BuildPlugin,say-fr,French Say,vanilla,,,,))
$(eval $(call BuildPlugin,say-hu,Hungarian Say,vanilla,,,,))
$(eval $(call BuildPlugin,say-it,Italian Say,vanilla,,,,))
$(eval $(call BuildPlugin,say-nl,Dutch Say,vanilla,,,,))
$(eval $(call BuildPlugin,say-pt,Portugeese Say,vanilla,,,,))
$(eval $(call BuildPlugin,say-ru,Russian Say,vanilla,,,,))
$(eval $(call BuildPlugin,say-th,Thai Say,vanilla,,,,))
$(eval $(call BuildPlugin,say-zh,Chineese Say,vanilla,,,,))
$(eval $(call BuildPlugin,shell-stream,Streaming Audio Through CLI,vanilla,,,,))
$(eval $(call BuildPlugin,silk,Skype(TM) SILK Codec Module,vanilla,,,,))
$(eval $(call BuildPlugin,siren,G.722.1 Codec,vanilla,,,,))
$(eval $(call BuildPlugin,skel,Template For New Module,vanilla,,,,))
$(eval $(call BuildPlugin,skinny,Skinny Call Control Protocol (SCCP),vanilla,,,,))
$(eval $(call BuildPlugin,skypopen,Skype Compatible Endpoint,mod,,,,@FEATURE_drawing-backend_libX11))
$(eval $(call BuildPlugin,sms,SMS,vanilla,,,,))
$(eval $(call BuildPlugin,snapshot,Record Audio Snapshot to File,vanilla,,,,))
$(eval $(call BuildPlugin,sndfile,Multi-Format Sound File,vanilla,,,,))
$(eval $(call BuildPlugin,snipe-hunt,Snipe Hunt (Simple Example Module),vanilla,,,,))
$(eval $(call BuildPlugin,snmp,SNMP AgentX Subagent,vanilla,,,,+libnetsnmp))
$(eval $(call BuildPlugin,snom,SNOM specific features,vanilla,,,,))
$(eval $(call BuildPlugin,sofia,SOFIA SIP,mod,,,,)) # ~/conf
$(eval $(call BuildPlugin,sonar,Sonar Ping Timer,vanilla,,,,))
$(eval $(call BuildPlugin,spandsp,Span DSP,mod,,,,+libjpeg)) # ~/conf
$(eval $(call BuildPlugin,speex,Speex codec,mod,,,,))
$(eval $(call BuildPlugin,spidermonkey,JavaScript,vanilla,,,,@BROKEN)) # fails in js
$(eval $(call BuildPlugin,spidermonkey-core_db,JavaScript DB,vanilla,,,,@BROKEN))
$(eval $(call BuildPlugin,spidermonkey-curl,JavaScript Curl,vanilla,,,,@BROKEN))
$(eval $(call BuildPlugin,spidermonkey-odbc,JavaScript ODBC,vanilla,,,,@BROKEN))
$(eval $(call BuildPlugin,spidermonkey-socket,JavaScript Socket,vanilla,,,,@BROKEN))
$(eval $(call BuildPlugin,spidermonkey-teletone,JavaScript Teletone,vanilla,,,,@BROKEN))
$(eval $(call BuildPlugin,spy,User Spy,vanilla,,,,))
$(eval $(call BuildPlugin,stress,Voice Stress Detection,vanilla,,,,))
$(eval $(call BuildPlugin,syslog,SysLog logger,vanilla,,,,))
$(eval $(call BuildPlugin,timerfd,Linux Kernel timerfd API,vanilla,,,,))
$(eval $(call BuildPlugin,tone-stream,Tone Generation Stream,vanilla,,,,))
$(eval $(call BuildPlugin,tts-commandline,ASR TTS Command Interface,vanilla,,,,))
$(eval $(call BuildPlugin,unimrcp,UniMRCP (MRCP Client),vanilla,,,,@BROKEN))
$(eval $(call BuildPlugin,valet-parking,Valet Parking Application,vanilla,,,,))
$(eval $(call BuildPlugin,vmd,VoiceMail Beep Detection,vanilla,,,,))
$(eval $(call BuildPlugin,voicemail,VoiceMail,vanilla,,,,))
$(eval $(call BuildPlugin,voicemail-ivr,VoiceMail IVR,vanilla,,,,))
$(eval $(call BuildPlugin,vp8,VP8 Video Codec,vanilla,,,,))
$(eval $(call BuildPlugin,xml-cdr,XML-CDR Handler,vanilla,,,,+libcurl))
$(eval $(call BuildPlugin,xml-curl,XML-Curl Gateway,vanilla,,,,+libcurl))
$(eval $(call BuildPlugin,xml-rpc,XML-RPC Interface,vanilla,,,,))
$(eval $(call BuildPlugin,xml-scgi,SCGI XML Gateway,vanilla,,,,))
$(eval $(call BuildPlugin,yaml,YAML langunage,vanilla,,,,))
