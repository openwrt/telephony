#
# Copyright (C) 2017 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=freeswitch
PKG_VERSION:=1.10.12
PKG_RELEASE:=2
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

PKG_SOURCE:=freeswitch-$(PKG_VERSION).-release.tar.xz
PKG_SOURCE_URL:=https://files.freeswitch.org/releases/freeswitch
PKG_HASH:=e324e4ae063e692c42b93031157329bae339ea007e611d3535333deaed85aa47

PKG_CPE_ID:=cpe:/a:freeswitch:freeswitch

PKG_BUILD_DIR:=$(BUILD_DIR)/freeswitch-$(PKG_VERSION).-release

PKG_BUILD_DEPENDS:=perl/host

PKG_FIXUP:=autoreconf

PKG_BUILD_PARALLEL:=1
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

FS_DATA_DIR:=/usr/share/freeswitch

FS_BIN_DIR:=/usr/bin
FS_EXAMPLES_DIR:=$(FS_DATA_DIR)/examples
FS_FONTS_DIR:=$(FS_DATA_DIR)/fonts
FS_GRAMMAR_DIR:=$(FS_DATA_DIR)/grammar
FS_HTDOCS_DIR:=$(FS_DATA_DIR)/htdocs
FS_IMAGES_DIR:=$(FS_DATA_DIR)/images
FS_INCLUDES_DIR:=/usr/include/freeswitch
FS_LANG_DIR:=$(FS_DATA_DIR)/lang
FS_LIB_DIR:=/usr/lib
FS_MOD_DIR:=$(FS_LIB_DIR)/freeswitch/mod
FS_PKGCONFIG_DIR:=$(FS_LIB_DIR)/pkgconfig
FS_SCRIPTS_DIR:=$(FS_DATA_DIR)/scripts
FS_SOUNDS_DIR:=$(FS_DATA_DIR)/sounds
FS_SYSCONF_DIR:=/etc
FS_TLS_DIR:=$(FS_SYSCONF_DIR)/freeswitch/tls
FS_TZ_DIR:=$(FS_DATA_DIR)/tz

FS_MOD_AVAILABLE:= \
	abstraction \
	alsa \
	amr \
	amrwb \
	av \
	avmd \
	b64 \
	basic \
	bert \
	blacklist \
	callcenter \
	cdr_csv \
	cdr_mongodb \
	cdr_pg_csv \
	cdr_sqlite \
	cidlookup \
	clearmode \
	cluechoo \
	commands \
	conference \
	console \
	curl \
	dahdi_codec \
	db \
	dialplan_asterisk \
	dialplan_directory \
	dialplan_xml \
	directory \
	distributor \
	dptools \
	easyroute \
	enum \
	erlang_event \
	esf \
	esl \
	event_multicast \
	event_socket \
	event_test \
	event_zmq \
	expr \
	fail2ban \
	fifo \
	format_cdr \
	fsk \
	fsv \
	g723_1 \
	g729 \
	graylog2 \
	gsmopen \
	h26x \
	hash \
	hiredis \
	httapi \
	http_cache \
	isac \
	json_cdr \
	lcr \
	ldap \
	local_stream \
	logfile \
	loopback \
	lua \
	mariadb \
	mp4v \
	native_file \
	nibblebill \
	odbc_cdr \
	opus \
	opusfile \
	oreka \
	perl \
	pgsql \
	png \
	pocketsphinx \
	portaudio \
	portaudio_stream \
	posix_timer \
	prefix \
	python3 \
	radius_cdr \
	random \
	raven \
	rayo \
	redis \
	rss \
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
	shell_stream \
	shout \
	signalwire \
	skinny \
	sms \
	snapshot \
	sndfile \
	snmp \
	snom \
	sofia \
	sonar \
	spandsp \
	spy \
	ssml \
	stress \
	syslog \
	theora \
	tone_stream \
	translate \
	tts_commandline \
	valet_parking \
	verto \
	video_filter \
	vmd \
	voicemail \
	voicemail_ivr \
	xml_cdr \
	xml_curl \
	xml_ldap \
	xml_rpc \
	xml_scgi \
	yaml \
	yuv

PKG_CONFIG_DEPENDS:= \
	$(patsubst %,CONFIG_PACKAGE_freeswitch-mod-%,$(subst _,-,$(FS_MOD_AVAILABLE))) \
	CONFIG_FS_WITH_DEBUG \
	CONFIG_FS_WITH_FREETYPE \
	CONFIG_FS_WITH_LIBYUV \
	CONFIG_FS_WITH_ODBC \
	CONFIG_FS_WITH_PNG \
	CONFIG_FS_WITH_SRTP \
	CONFIG_FS_WITH_VPX \
	CONFIG_LIBC \
	CONFIG_PACKAGE_freeswitch-misc-perl-esl \
	CONFIG_PACKAGE_freeswitch-misc-python3-esl \
	CONFIG_SOFT_FLOAT

include $(INCLUDE_DIR)/package.mk
# iconv support
include $(INCLUDE_DIR)/nls.mk

FS_PERL_FEED:=$(TOPDIR)/feeds/packages/lang/perl

include $(TOPDIR)/feeds/packages/lang/python/python3-version.mk
include $(FS_PERL_FEED)/perlver.mk

PERL_SITELIB:=/usr/lib/perl$(PERL_MAJOR)/$(PERL_VERSION2)

FS_PERL_LIBS:=$(shell grep "^libs=" \
	$(FS_PERL_FEED)/files/base.config | \
			sed "s/^libs=//;s/'//g")

FS_PYTHON3_SITE_DIR:=$(FS_LIB_DIR)/python$(PYTHON3_VERSION)/site-packages

define Download/files
define Download/$(1)
  FILE:=$(2)
  URL:=$(3)
  HASH:=$(4)
  VERSION:=$(5)
  SUBDIR:=$(6)
  MIRROR_HASH:=$(7)
  PROTO:=$(8)
endef
$$(eval $$(call Download,$(1)))
endef

define Package/freeswitch/enable/plugin
	$(SED) '/$(1)$$$$/s/^#//' $(PKG_BUILD_DIR)/modules.conf
endef

define Package/freeswitch/install/bin
	$(INSTALL_DIR) $(1)$(FS_BIN_DIR)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)$(FS_BIN_DIR)/$(2) \
					$(1)$(FS_BIN_DIR)
endef

define Package/freeswitch/install/dir
	if [ -d $(2) ]; then $(INSTALL_DIR) $(1); fi
	for dir in $$$$(shell [ -d $(2) ] && cd $(2) && $(FIND) -type d -print | sed 's|^./\?||'); \
	do \
		$(INSTALL_DIR) $(1)/$$$$$$$$dir; \
	done
	for file in $$$$(shell [ -d $(2) ] && cd $(2) && $(FIND) -type f -print | sed 's|^./||'); \
	do \
		$(INSTALL_DATA) $(2)/$$$$$$$$file $(1)/$$$$$$$$file; \
	done
endef

define Package/freeswitch/install/lib
	$(INSTALL_DIR) $(1)$(FS_LIB_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(FS_LIB_DIR)/$(2).so.* \
					$(1)$(FS_LIB_DIR)
endef

define Package/freeswitch/install/mod
	$(INSTALL_DIR) $(1)$(FS_MOD_DIR)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)$(FS_MOD_DIR)/mod_$(2).so \
						$(1)$(FS_MOD_DIR)
endef

define Package/freeswitch/config
	source "$(SOURCE)/Config.in"
endef

define Package/freeswitch/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=https://www.freeswitch.org
endef

# Note: shadow deps are a bit strange; you need to select shadow-utils
# package first for shadow-su to be selected, even though the
# shadow-utils package later becomes a no-op.
define Package/freeswitch
$(call Package/freeswitch/Default)
  TITLE:=Open source telephony platform, v$(PKG_VERSION)
  MENU:=1
  USERID:=freeswitch=372:freeswitch=372
  DEPENDS:= \
	  $(ICONV_DEPENDS) \
	  +libstdcpp \
	  +!BUSYBOX_DEFAULT_SU:shadow-utils \
	  +!BUSYBOX_DEFAULT_SU:shadow-su \
	  +@OPENSSL_WITH_DEPRECATED \
	  +FS_WITH_FREETYPE:libfreetype \
	  +FS_WITH_ODBC:unixodbc \
	  +FS_WITH_PNG:libpng \
	  +libcurl \
	  +libedit \
	  +libopenssl \
	  +libpcre2 \
	  +libpthread \
	  +librt \
	  +libspandsp3 \
	  +libspeex \
	  +libspeexdsp \
	  +libsqlite3 \
	  +libuuid \
	  +sofia-sip \
	  +zlib
endef

define Package/freeswitch/description
FreeSWITCH is a scalable open source cross-platform telephony platform
designed to route and interconnect popular communication protocols
using audio, video, text or any other form of media.
endef

define Package/freeswitch/conffiles
$(FS_SYSCONF_DIR)/freeswitch
$(FS_SYSCONF_DIR)/config/freeswitch
$(FS_SYSCONF_DIR)/init.d/freeswitch
endef

define Package/freeswitch/install
$(call Package/freeswitch/install/bin,$(1),freeswitch)
$(call Package/freeswitch/install/lib,$(1),libfreeswitch)
	$(INSTALL_DIR) $(1)$(FS_FONTS_DIR)
	$(INSTALL_DIR) $(1)$(FS_GRAMMAR_DIR)
	$(INSTALL_DIR) $(1)$(FS_HTDOCS_DIR)
	$(INSTALL_DIR) $(1)$(FS_IMAGES_DIR)
	$(INSTALL_DIR) $(1)$(FS_SCRIPTS_DIR)
	$(INSTALL_DIR) $(1)$(FS_SOUNDS_DIR)
	$(INSTALL_DIR) $(1)$(FS_SYSCONF_DIR)/config
	$(INSTALL_DIR) $(1)$(FS_SYSCONF_DIR)/hotplug.d/iface
	$(INSTALL_DIR) $(1)$(FS_SYSCONF_DIR)/init.d
	$(INSTALL_DIR) $(1)$(FS_TLS_DIR)
	$(INSTALL_BIN) ./files/freeswitch.init \
		$(1)$(FS_SYSCONF_DIR)/init.d/freeswitch
	$(INSTALL_BIN) ./files/freeswitch.hotplug \
		$(1)$(FS_SYSCONF_DIR)/hotplug.d/iface/90-freeswitch
	$(INSTALL_CONF) ./files/freeswitch.conf \
		$(1)$(FS_SYSCONF_DIR)/config/freeswitch
endef

define Package/freeswitch/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  echo
  echo "o-------------------------------------------------------------------o"
  echo "| FreeSWITCH note                                                   |"
  echo "o-------------------------------------------------------------------o"
  echo "| Edit /etc/config/freeswitch to change basic init configuration.   |"
  echo "|                                                                   |"
  echo "| Also visit the Wiki at:                                           |"
  echo "| https://openwrt.org/docs/guide-user/services/voip/freeswitch      |"
  echo "o-------------------------------------------------------------=^_^=-o"
  echo
fi
exit 0
endef

define Package/freeswitch-misc-perl-esl
$(call Package/freeswitch/Default)
  TITLE:=Perl ESL
  DEPENDS:=freeswitch \
	  +PACKAGE_freeswitch-misc-perl-esl:perlbase-autoloader \
	  +PACKAGE_freeswitch-misc-perl-esl:perlbase-data \
	  +PACKAGE_freeswitch-misc-perl-esl:perlbase-dynaloader \
	  @PERL_THREADS
endef

define Package/freeswitch-misc-perl-esl/description
This package contains the Perl binding for FreeSWITCH's Event Socket
Library (ESL).
endef

define Package/freeswitch-misc-perl-esl/install
	$(INSTALL_DIR) $(1)$(PERL_SITELIB)/ESL
	$(INSTALL_DIR) $(1)$(PERL_SITELIB)/auto/ESL
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)$(PERL_SITELIB)/ESL.so \
					$(1)$(PERL_SITELIB)/auto/ESL
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)$(PERL_SITELIB)/ESL.pm \
					$(1)$(PERL_SITELIB)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)$(PERL_SITELIB)/ESL/Dispatch.pm \
					$(1)$(PERL_SITELIB)/ESL
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)$(PERL_SITELIB)/ESL/IVR.pm \
					$(1)$(PERL_SITELIB)/ESL
endef

define Package/freeswitch-misc-python3-esl
$(call Package/freeswitch/Default)
  TITLE:=Python3 ESL
  DEPENDS:=freeswitch +PACKAGE_freeswitch-misc-python3-esl:python3-light
endef

define Package/freeswitch-misc-python3-esl/description
This package contains the Python3 binding for FreeSWITCH's Event Socket
Library (ESL).
endef

define Package/freeswitch-misc-python3-esl/install
	$(INSTALL_DIR) $(1)$(FS_PYTHON3_SITE_DIR)
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)$(FS_PYTHON3_SITE_DIR)/_ESL.so \
					$(1)$(FS_PYTHON3_SITE_DIR)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)$(FS_PYTHON3_SITE_DIR)/ESL.py \
					$(1)$(FS_PYTHON3_SITE_DIR)
endef

define Package/freeswitch-misc-timezones
$(call Package/freeswitch/Default)
  TITLE:=Timezones file
  DEPENDS:=freeswitch
  PKGARCH:=all
endef

define Package/freeswitch-misc-timezones/description
This package includes a timezones file for FreeSWITCH.
endef

define Package/freeswitch-misc-timezones/install
	$(INSTALL_DIR) $(1)$(FS_TZ_DIR)
	$(INSTALL_DATA) \
	$(PKG_BUILD_DIR)/conf/vanilla/autoload_configs/timezones.conf.xml \
						$(1)$(FS_TZ_DIR)
endef

define Package/freeswitch/Example
define Package/freeswitch-example-$(subst _,-,$(1))
$(call Package/freeswitch/Default)
  TITLE:=Example configuration
  DEPENDS:=freeswitch
  PKGARCH:=all
endef
define Package/freeswitch-example-$(subst _,-,$(1))/description
This package does not install any configuration for FreeSWITCH into
/etc/freeswitch. The system administrator is completely responsible
for that directory. If you install one of the example configuration
packages, it will install the corresponding sample configuration to
/usr/share/freeswitch/examples where you can take a look at it.
endef
define Package/freeswitch-example-$(subst _,-,$(1))/install
$(call Package/freeswitch/install/dir,$$(1)$(FS_EXAMPLES_DIR)/$(1),$(PKG_BUILD_DIR)/conf/$(1))
endef
$$(eval $$(call BuildPackage,freeswitch-example-$(subst _,-,$(1))))
endef

define Package/freeswitch/Language
define Package/freeswitch-lang-$(subst _,-,$(1))
$(call Package/freeswitch/Default)
  TITLE:=$(2) language files
  DEPENDS:=freeswitch
  PKGARCH:=all
endef
define Package/freeswitch-lang-$(subst _,-,$(1))/description
This package includes the $(2) language files for FreeSWITCH.
endef
define Package/freeswitch-lang-$(subst _,-,$(1))/install
$(call Package/freeswitch/install/dir,$$(1)$(FS_LANG_DIR)/$(1),$(PKG_BUILD_DIR)/conf/vanilla/lang/$(1))
endef
$$(eval $$(call BuildPackage,freeswitch-lang-$(subst _,-,$(1))))
endef

# The next package generator is for miscellaneous files that only
# require being copied from PKG_INSTALL_DIR to the ipkg.
define Package/freeswitch/Misc
define Package/freeswitch-$(subst _,-,$(1))
$(call Package/freeswitch/Default)
  TITLE:=$(2)
  DEPENDS:=freeswitch
  ifeq ($(6),y)
  PKGARCH:=all
  endif
endef
define Package/freeswitch-$(subst _,-,$(1))/description
$(subst \n,$(newline),$(3))
endef
define Package/freeswitch-$(subst _,-,$(1))/install
$(call Package/freeswitch/install/dir,$$(1)$(5),$(PKG_INSTALL_DIR)$(4))
endef
$$(eval $$(call BuildPackage,freeswitch-$(subst _,-,$(1))))
endef

define Package/freeswitch/Module
define Package/freeswitch-mod-$(subst _,-,$(1))
$(call Package/freeswitch/Default)
  TITLE:=$(2) module
  DEPENDS:=freeswitch $(patsubst +%,+PACKAGE_freeswitch-mod-$(subst _,-,$(1)):%,$(4))
endef
define Package/freeswitch-mod-$(subst _,-,$(1))/description
$(subst \n,$(newline),$(3))
endef
define Package/freeswitch-mod-$(subst _,-,$(1))/install
$(call Package/freeswitch/install/mod,$$(1),$(1))
ifeq ($(CONFIG_FS_WITH_MODCONF),y)
$(call Package/freeswitch/install/dir,$$(1)$(FS_EXAMPLES_DIR)/mod_$(1),$(PKG_BUILD_DIR)/src/mod/*/mod_$(1)/conf)
endif
ifeq ($(1),perl)
	$(INSTALL_DIR) $$(1)$(PERL_SITELIB)/auto/freeswitch
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/perl/freeswitch.so \
					$$(1)$(PERL_SITELIB)/auto/freeswitch
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/perl/freeswitch.pm \
							$$(1)$(PERL_SITELIB)
endif
ifeq ($(1),python3)
	$(INSTALL_DIR) $$(1)$(FS_PYTHON3_SITE_DIR)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)$(FS_PYTHON3_SITE_DIR)/freeswitch.py \
					$$(1)$(FS_PYTHON3_SITE_DIR)
endif
endef
$$(eval $$(call BuildPackage,freeswitch-mod-$(subst _,-,$(1))))
endef

define Package/freeswitch/Util
define Package/freeswitch-util-$(subst _,-,$(1))
$(call Package/freeswitch/Default)
  TITLE:=$(2) utility
  DEPENDS:=freeswitch $(patsubst +%,+PACKAGE_freeswitch-util-$(subst _,-,$(1)):%,$(4))
  ifeq ($(5),y)
  PKGARCH:=all
  endif
endef
define Package/freeswitch-util-$(subst _,-,$(1))/description
$(subst \n,$(newline),$(3))
endef
define Package/freeswitch-util-$(subst _,-,$(1))/install
$(call Package/freeswitch/install/bin,$$(1),$(1))
endef
$$(eval $$(call BuildPackage,freeswitch-util-$(subst _,-,$(1))))
endef

CONFIGURE_ARGS+= \
	--srcdir=$(PKG_BUILD_DIR) \
	--disable-dependency-tracking \
	--disable-static \
	--disable-system-xmlrpc-c \
	--enable-core-libedit-support \
	--enable-fhs \
	--with-cachedir=/tmp/freeswitch/cache \
	--with-dbdir=/tmp/freeswitch/db \
	--with-imagesdir=$(FS_IMAGES_DIR) \
	--with-logfiledir=/tmp/freeswitch/log \
	--with-python=no \
	--with-recordingsdir=/tmp/freeswitch/recordings \
	--with-storagedir=/tmp/freeswitch/storage \
	$(call autoconf_bool,CONFIG_FS_WITH_DEBUG,debug) \
	$(call autoconf_bool,CONFIG_FS_WITH_LIBYUV,libyuv) \
	$(call autoconf_bool,CONFIG_FS_WITH_ODBC,core-odbc-support) \
	$(call autoconf_bool,CONFIG_FS_WITH_SRTP,srtp) \
	$(call autoconf_bool,CONFIG_FS_WITH_VPX,libvpx) \
	$(if $(CONFIG_FS_WITH_FREETYPE),,--without-freetype) \
	$(if $(CONFIG_FS_WITH_ODBC),--with-odbc-lib="$(STAGING_DIR)$(FS_LIB_DIR)") \
	$(if $(CONFIG_FS_WITH_ODBC),--with-odbc="$(STAGING_DIR)/usr") \
	$(if $(CONFIG_FS_WITH_PNG),,--without-png)

ifneq ($(CONFIG_PACKAGE_freeswitch-misc-python3-esl)$(CONFIG_PACKAGE_freeswitch-mod-python3),)
CONFIGURE_ARGS+= \
	--with-python3=$(STAGING_DIR_HOST)/bin/python3
else
CONFIGURE_ARGS+= \
	--with-python3=no
endif

ifeq ($(CONFIG_PACKAGE_freeswitch-mod-erlang-event),)
CONFIGURE_ARGS+= \
	--with-erlang=no
endif

# FreeSWITCH dropped postgresql support from the core. postgresql
# support is now available via mod_pgsql. We still need to pass
# '--without-pgsql', otherwise apr-util links to libpq and we still
# would have the core link to it.
CONFIGURE_ARGS+= \
	--without-pgsql

# Don't want host-php
CONFIGURE_VARS+= \
	ac_cv_have_php=no \
	ac_cv_have_php_config=no \
	ac_cv_prog_PHP=false \
	ac_cv_prog_PHP_CONFIG=false

# The autoconf variables in this block are OK for both musl and glibc
CONFIGURE_VARS+= \
	ac_cv_dev_urandom=yes \
	ac_cv_file__dev_ptmx=yes \
	ac_cv_file__dev_urandom=yes \
	ac_cv_file_dbd_apr_dbd_mysql_c=no \
	ac_cv_free_null=yes \
	ac_cv_func_mmap_fixed_mapped=yes \
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

# fs_cli
CONFIGURE_VARS+= \
	disable_cc=yes

# Regarding apr_cv_mutex_robust_shared=no see
# http://www.openwall.com/lists/musl/2016/11/26/1
ifeq ($(call qstrip,$(CONFIG_LIBC)),musl)
CONFIGURE_VARS+= \
	apr_cv_mutex_robust_shared=no \
	ac_cv_strerror_r_rc_int=yes
else
CONFIGURE_VARS+= \
	apr_cv_mutex_robust_shared=yes
endif

ifneq ($(CONFIG_PACKAGE_freeswitch-misc-perl-esl)$(CONFIG_PACKAGE_freeswitch-mod-perl),)
CONFIGURE_VARS+= \
	PERL="$(STAGING_DIR_HOSTPKG)/usr/bin/perl$(PERL_VERSION)" \
	PERL_CFLAGS="-D_LARGEFILE_SOURCE $(if $(CONFIG_USE_MUSL),-D_LARGEFILE64_SOURCE) -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_GNU_SOURCE -I$(STAGING_DIR)$(PERL_SITELIB)/CORE" \
	PERL_INC="-I$(STAGING_DIR)$(PERL_SITELIB)/CORE" \
	PERL_LDFLAGS="-Wl,-rpath,$(PERL_SITELIB)/CORE -L$(STAGING_DIR)$(PERL_SITELIB)/CORE -lperl" \
	PERL_LIBDIR="-L$(PERL_SITELIB)/CORE" \
	PERL_LIBS="$(FS_PERL_LIBS) $(EXTRA_LIBDIRS:%=-L%) $(EXTRA_LIBS:%=-l%)" \
	PERL_SITEDIR="$(PERL_SITELIB)"
else
CONFIGURE_VARS+= \
	ac_cv_have_perl=no \
	ac_cv_prog_PERL=false
endif

ifneq ($(CONFIG_PACKAGE_freeswitch-misc-python3-esl)$(CONFIG_PACKAGE_freeswitch-mod-python3),)
CONFIGURE_VARS+= \
	PYTHON3_CFLAGS="-I$(STAGING_DIR)/usr/include/python$(PYTHON3_VERSION)" \
	PYTHON3_LDFLAGS="-lpython$(PYTHON3_VERSION)" \
	PYTHON3_LIB="python$(PYTHON3_VERSION)" \
	PYTHON3_LIBDIR="$(FS_LIB_DIR)" \
	PYTHON3_SITE_DIR="$(FS_PYTHON3_SITE_DIR)"
endif

# mod_radius_cdr runs configure in libs/freeradius-client. Let
# freeradius-client know /dev/urandom is available on target devices.
MAKE_VARS+= \
	ac_cv_dev_urandom=yes

# Make sphinxbase use fixed point math when soft float support is
# enabled on target devices.
ifeq ($(CONFIG_SOFT_FLOAT),y)
MAKE_VARS+= \
	FS_USE_FIXED_POINT="--enable-fixed"
endif

# Some common URLs
FS_LIBS_URL:=https://files.freeswitch.org/downloads/libs
FS_SPHINX_URL:=@SF/cmusphinx

# mod_event_zmq
FS_ZEROMQ_FILE:=zeromq-2.1.9.tar.gz
FS_ZEROMQ_HASH:=f3542f756687e622beef3a75c8e027fe2d95d4654350cbca4c070ffc58d9ace0
FS_ZEROMQ_URL:=http://download.zeromq.org

# mod_pocketsphinx
FS_POCKETSPHINX_FILE:=pocketsphinx-0.8.tar.gz
FS_POCKETSPHINX_HASH:=874c4c083d91c8ff26a2aec250b689e537912ff728923c141c4dac48662cce7a

FS_SPHINXBASE_FILE:=sphinxbase-0.8.tar.gz
FS_SPHINXBASE_HASH:=55708944872bab1015b8ae07b379bf463764f469163a8fd114cbb16c5e486ca8

FS_SPHINXMODEL_FILE:=communicator_semi_6000_20080321.tar.gz
FS_SPHINXMODEL_HASH:=dbb5e9fb85000a7cb97d6958a3ef8d77532dc55fc730ac6979705e8645cb0c18

# mod_radius_cdr
FS_FREERADIUS_CLIENT_FILE:=freeradius-client-1.1.7.tar.gz
FS_FREERADIUS_CLIENT_HASH:=eada2861b8f4928e3ac6b5bbfe11e92cd6cdcacfce40cae1085e77c1b6add0e9

ifneq ($(CONFIG_PACKAGE_freeswitch-mod-event-zmq),)
$(eval $(call Download/files,zmq,$(FS_ZEROMQ_FILE),$(FS_ZEROMQ_URL),$(FS_ZEROMQ_HASH)))
endif

ifneq ($(CONFIG_PACKAGE_freeswitch-mod-pocketsphinx)$(CONFIG_PACKAGE_freeswitch-misc-grammar),)
$(eval $(call Download/files,pocketsphinx,$(FS_POCKETSPHINX_FILE),$(FS_SPHINX_URL),$(FS_POCKETSPHINX_HASH)))
$(eval $(call Download/files,sphinxbase,$(FS_SPHINXBASE_FILE),$(FS_SPHINX_URL),$(FS_SPHINXBASE_HASH)))
$(eval $(call Download/files,communicator,$(FS_SPHINXMODEL_FILE),$(FS_LIBS_URL),$(FS_SPHINXMODEL_HASH)))
endif

ifneq ($(CONFIG_PACKAGE_freeswitch-mod-radius-cdr),)
$(eval $(call Download/files,freeradius-client,$(FS_FREERADIUS_CLIENT_FILE),$(FS_LIBS_URL),$(FS_FREERADIUS_CLIENT_HASH)))
endif

define Build/Prepare
	$(call Build/Prepare/Default)

	echo '#applications/mod_random' >> $(PKG_BUILD_DIR)/modules.conf
	echo '#codecs/mod_yuv' >> $(PKG_BUILD_DIR)/modules.conf
	echo '#event_handlers/mod_event_test' >> $(PKG_BUILD_DIR)/modules.conf
endef

define Build/Configure
	$(SED) '/^#/!s/^/#/' $(PKG_BUILD_DIR)/modules.conf
	$(foreach m,$(FS_MOD_AVAILABLE),
		$(if $(CONFIG_PACKAGE_freeswitch-mod-$(subst _,-,$(m))),
		$(call Package/freeswitch/enable/plugin,mod_$(m))))

# Some of the dependencies that necessitate below hacks are documented in
# src/mod/Makefile.am.

# Hack for misc-grammar - needs mod_pocketsphinx to provide grammar files
ifneq ($(CONFIG_PACKAGE_freeswitch-misc-grammar),)
	$(call Package/freeswitch/enable/plugin,mod_pocketsphinx)
endif

# Hack for mod_gsmopen - it has a build-time dep on mod_spandsp
ifneq ($(CONFIG_PACKAGE_freeswitch-mod-gsmopen),)
	$(call Package/freeswitch/enable/plugin,mod_spandsp)
endif

# Hack for mod_ssml - it has a build-time dep on mod_rayo.
ifneq ($(CONFIG_PACKAGE_freeswitch-mod-ssml),)
	$(call Package/freeswitch/enable/plugin,mod_rayo)
endif

	$(call Build/Configure/Default)
endef

define Build/Compile
# Copy some source files if certain modules are selected
ifneq ($(CONFIG_PACKAGE_freeswitch-mod-event-zmq),)
	$(CP) $(DL_DIR)/$(FS_ZEROMQ_FILE) $(PKG_BUILD_DIR)/libs
endif

ifneq ($(CONFIG_PACKAGE_freeswitch-mod-pocketsphinx)$(CONFIG_PACKAGE_freeswitch-misc-grammar),)
	$(CP) $(DL_DIR)/$(FS_POCKETSPHINX_FILE) $(PKG_BUILD_DIR)/libs
	$(CP) $(DL_DIR)/$(FS_SPHINXBASE_FILE) $(PKG_BUILD_DIR)/libs
	$(CP) $(DL_DIR)/$(FS_SPHINXMODEL_FILE) $(PKG_BUILD_DIR)/libs
endif

ifneq ($(CONFIG_PACKAGE_freeswitch-mod-radius-cdr),)
	$(CP) $(DL_DIR)/$(FS_FREERADIUS_CLIENT_FILE) $(PKG_BUILD_DIR)/libs
endif

	$(call Build/Compile/Default)

ifneq ($(CONFIG_PACKAGE_freeswitch-misc-perl-esl),)
	$(call Build/Compile/Default,-C $(PKG_BUILD_DIR)/libs/esl perlmod)
endif
ifneq ($(CONFIG_PACKAGE_freeswitch-misc-python3-esl),)
	$(call Build/Compile/Default,-C $(PKG_BUILD_DIR)/libs/esl py3mod)
endif
endef

define Build/Install
	$(call Build/Install/Default)
ifneq ($(CONFIG_PACKAGE_freeswitch-misc-perl-esl),)
	$(call Build/Compile/Default,-C $(PKG_BUILD_DIR)/libs/esl DESTDIR=$(PKG_INSTALL_DIR) perlmod-install)
endif
ifneq ($(CONFIG_PACKAGE_freeswitch-misc-python3-esl),)
	$(call Build/Install/Default,-C $(PKG_BUILD_DIR)/libs/esl py3mod-install)
endif
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)$(FS_INCLUDES_DIR) $(1)$(FS_LIB_DIR) \
						$(1)$(FS_PKGCONFIG_DIR)
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)$(FS_INCLUDES_DIR)/*.h \
						$(1)$(FS_INCLUDES_DIR)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)$(FS_PKGCONFIG_DIR)/freeswitch.pc \
						$(1)$(FS_PKGCONFIG_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(FS_LIB_DIR)/libfreeswitch.so* \
						$(1)$(FS_LIB_DIR)
endef

$(eval $(call BuildPackage,freeswitch))
$(eval $(call BuildPackage,freeswitch-misc-perl-esl))
$(eval $(call BuildPackage,freeswitch-misc-python3-esl))
$(eval $(call BuildPackage,freeswitch-misc-timezones))

################################
# FreeSWITCH example configs
# Params:
# 1 - Package subname
################################

$(eval $(call Package/freeswitch/Example,curl))
$(eval $(call Package/freeswitch/Example,insideout))
$(eval $(call Package/freeswitch/Example,minimal))
$(eval $(call Package/freeswitch/Example,rayo))
$(eval $(call Package/freeswitch/Example,sbc))
$(eval $(call Package/freeswitch/Example,softphone))
$(eval $(call Package/freeswitch/Example,testing))
$(eval $(call Package/freeswitch/Example,vanilla))

################################
# FreeSWITCH language files
# Params:
# 1 - Language code
# 2 - Language
################################

$(eval $(call Package/freeswitch/Language,de,German))
$(eval $(call Package/freeswitch/Language,en,English))
$(eval $(call Package/freeswitch/Language,es,Spanish))
$(eval $(call Package/freeswitch/Language,fr,French))
$(eval $(call Package/freeswitch/Language,he,Hebrew))
$(eval $(call Package/freeswitch/Language,pt,Portuguese))
$(eval $(call Package/freeswitch/Language,ru,Russian))
$(eval $(call Package/freeswitch/Language,sv,Swedish))

################################
# FreeSWITCH misc packages
# Params:
# 1 - Package subname
# 2 - Package title
# 3 - Package description
# 4 - Source dir relative to
#     PKG_INSTALL_DIR
# 5 - Dest dir relative to ipkg
# 6 - Arch independent files
################################

$(eval $(call Package/freeswitch/Misc,misc-fonts,Fonts,This package includes the fonts bundled with FreeSWITCH.,$(FS_FONTS_DIR),$(FS_FONTS_DIR),y))
$(eval $(call Package/freeswitch/Misc,misc-grammar,Grammar,This package contains grammar files. mod_pocketsphinx would be a\npotential user.,$(FS_GRAMMAR_DIR),$(FS_GRAMMAR_DIR),y))
$(eval $(call Package/freeswitch/Misc,misc-images,Images,This package includes the images bundled with FreeSWITCH.,$(FS_IMAGES_DIR),$(FS_IMAGES_DIR),y))

################################
# FreeSWITCH modules
# Params:
# 1 - Package subname
# 2 - Package title
# 3 - Module description
# 4 - Module dependencies
################################

$(eval $(call Package/freeswitch/Module,abstraction,API abstraction,This module provides a way to create new API functions via regex\nrewriting.,))
$(eval $(call Package/freeswitch/Module,alsa,ALSA endpoint,ALSA endpoint module.,+alsa-lib))
$(eval $(call Package/freeswitch/Module,amr,AMR passthrough,Passthrough AMR codec support.,))
$(eval $(call Package/freeswitch/Module,amrwb,AMR wideband passthrough,Passthrough AMR wideband codec support.,))
$(eval $(call Package/freeswitch/Module,av,AV,Video codec and format support via FFmpeg.,+libffmpeg-full @x86_64))
$(eval $(call Package/freeswitch/Module,avmd,Voicemail detection,This module attempts to determine when a voicemail system has answered\nthe call.,))
$(eval $(call Package/freeswitch/Module,b64,Base64,Transfers data Base64 encoded.,))
$(eval $(call Package/freeswitch/Module,basic,BASIC,BASIC module for FreeSWITCH.,))
$(eval $(call Package/freeswitch/Module,bert,BERT,Line testing tool.,))
$(eval $(call Package/freeswitch/Module,blacklist,Blacklist helper,This module provides tools to blacklist callers.,))
$(eval $(call Package/freeswitch/Module,callcenter,Call center,This module implements Automated Call Distribution queues.,))
$(eval $(call Package/freeswitch/Module,cdr_csv,CSV CDR,CSV Call Detail Record handler.,))
$(eval $(call Package/freeswitch/Module,cdr_mongodb,MongoDB CDR,MongoDB Call Detail Record handler.,))
$(eval $(call Package/freeswitch/Module,cdr_pg_csv,PostgreSQL CDR,PostgreSQL Call Detail Record handler.,+libpq))
$(eval $(call Package/freeswitch/Module,cdr_sqlite,SQLite CDR,SQLite Call Detail Record handler.,))
$(eval $(call Package/freeswitch/Module,cidlookup,Caller ID lookup,This module provides an API for querying caller ID name and location\ndata.,))
$(eval $(call Package/freeswitch/Module,clearmode,Clearmode,Clearmode codec passthrough support.,))
$(eval $(call Package/freeswitch/Module,cluechoo,Clue Choo,This demo module renders a Clue Choo train on the FreeSWITCH console.,+libncurses))
$(eval $(call Package/freeswitch/Module,commands,Commands,This module provides miscellaneous API commands.,))
$(eval $(call Package/freeswitch/Module,conference,Conference,This module provides multi-party conferencing.,))
$(eval $(call Package/freeswitch/Module,console,Console logger,Allows control over what messages get logged to the console.,))
$(eval $(call Package/freeswitch/Module,curl,cURL,This module provides an API for making HTTP requests with cURL.,))
$(eval $(call Package/freeswitch/Module,dahdi_codec,DAHDI codec,DAHDI codec module.,))
$(eval $(call Package/freeswitch/Module,db,DB,This module implements a simple db API with group support. Also can be\nused as a limit db backend.,))
$(eval $(call Package/freeswitch/Module,dialplan_asterisk,Asterisk dialplan,Asterisk extensions.conf style dialplan parser.,))
$(eval $(call Package/freeswitch/Module,dialplan_directory,Directory dialplan,Directory dialplan support.,))
$(eval $(call Package/freeswitch/Module,dialplan_xml,XML dialplan,Standard FreeSWITCH XML dialplan support.,))
$(eval $(call Package/freeswitch/Module,directory,Dial-by-name directory,This module implements a dial-by-name directory IVR.,))
$(eval $(call Package/freeswitch/Module,distributor,Load distributor,This module implements a mechanism for performing load balancing.,))
$(eval $(call Package/freeswitch/Module,dptools,Dialplan tools,This module implements basic dialplan tools.,))
$(eval $(call Package/freeswitch/Module,easyroute,DID routing,This module does destination lookup based on DID.,))
$(eval $(call Package/freeswitch/Module,enum,ENUM routing,This module implements ENUM support.,+libldns))
$(eval $(call Package/freeswitch/Module,erlang_event,Erlang event,Erlang event module.,+erlang))
$(eval $(call Package/freeswitch/Module,esf,Multicast,This module adds multi-cast support.,))
$(eval $(call Package/freeswitch/Module,esl,Single ESL,This module adds an API for generating one-off ESL requests.,))
$(eval $(call Package/freeswitch/Module,event_multicast,Multicast Event,Multicast Event System for FreeSWITCH.,))
$(eval $(call Package/freeswitch/Module,event_socket,Event socket,Sends events via a single socket. Needed for fs_cli.,))
$(eval $(call Package/freeswitch/Module,event_test,Event test,Event demo module.,))
$(eval $(call Package/freeswitch/Module,event_zmq,ZMQ event,ZMQ event module.,))
$(eval $(call Package/freeswitch/Module,expr,Expr,This module adds expr support for expression evaluation.,))
$(eval $(call Package/freeswitch/Module,fail2ban,Fail2ban logging,Provides support for Fail2ban logging.,))
$(eval $(call Package/freeswitch/Module,fifo,FIFO,This module adds a first-in first-out queue system.,))
$(eval $(call Package/freeswitch/Module,format_cdr,Multiformat CDR,A superset of mod_json_cdr and mod_xml_cdr.,))
$(eval $(call Package/freeswitch/Module,fsk,FSK,This module adds frequency-shift keying support which can be used to\nsend and receive caller ID.,))
$(eval $(call Package/freeswitch/Module,fsv,FSV,This module provides dialplan applications for recording and playing\nvideos.,))
$(eval $(call Package/freeswitch/Module,g723_1,G.723.1 passthrough,G.723.1 codec passthrough.,))
$(eval $(call Package/freeswitch/Module,g729,G.729 passthrough,G.729 codec passthrough.,))
$(eval $(call Package/freeswitch/Module,graylog2,Graylog2 logger,GELF logger for Graylog2 and Logstash.,))
$(eval $(call Package/freeswitch/Module,gsmopen,GSM endpoint,GSMopen is a channel driver that allows an SMS to be sent to and from\nFreeSWITCH as well as incoming and outgoing GSM voice calls.,+gsmlib +libctb +libjpeg-turbo +libtiff))
$(eval $(call Package/freeswitch/Module,h26x,H.26x passthrough,H.26x video codec passthrough.,))
$(eval $(call Package/freeswitch/Module,hash,Hash,This module provides a key-value in-memory datastore. Usable as a\nlimit backend.,))
$(eval $(call Package/freeswitch/Module,hiredis,Redis client,This module provides a mechanism to use Redis as a datastore.,+libhiredis))
$(eval $(call Package/freeswitch/Module,httapi,HT-TAPI,This module provides an API for controlling the switch by responding\nto HTTP requests.,))
$(eval $(call Package/freeswitch/Module,http_cache,HTTP GET with caching,This module provides an API for making HTTP GET requests where the\nresult is cached.,))
$(eval $(call Package/freeswitch/Module,isac,iSAC,iSAC codec support.,@arm||i386||mips||mips64||mips64el||mipsel||x86_64))
$(eval $(call Package/freeswitch/Module,json_cdr,JSON CDR,JSON-based Call Detail Record handler.,))
$(eval $(call Package/freeswitch/Module,lcr,LCR,This module adds a facility for least-cost routing.,))
$(eval $(call Package/freeswitch/Module,ldap,LDAP,LDAP module for FreeSWITCH.,+libopenldap))
$(eval $(call Package/freeswitch/Module,local_stream,Local stream,Connects multiple channels to a looped stream.,))
$(eval $(call Package/freeswitch/Module,logfile,File logger,Logs FreeSWITCH output to a file.,))
$(eval $(call Package/freeswitch/Module,loopback,Loopback,A loopback channel driver.,))
$(eval $(call Package/freeswitch/Module,lua,Lua,Lua language interface for FreeSWITCH.,+liblua))
$(eval $(call Package/freeswitch/Module,mariadb,MariaDB,Adds MariaDB support.,+libmariadb))
$(eval $(call Package/freeswitch/Module,mp4v,MP4 video passthrough,MP4 video passthrough.,))
$(eval $(call Package/freeswitch/Module,native_file,Native file,Plays files that are already encoded in the right format.,))
$(eval $(call Package/freeswitch/Module,nibblebill,Nibblebill,This module allows for real-time accounting of a cash balance and\nusing that information for call routing.,))
$(eval $(call Package/freeswitch/Module,odbc_cdr,ODBC CDR,ODBC Call Detail Record handler.,))
$(eval $(call Package/freeswitch/Module,opus,Opus,Opus codec support.,+libopus))
$(eval $(call Package/freeswitch/Module,opusfile,Opus file,Read and Write OGG/Opus files.,+libopusenc +libopusfile))
$(eval $(call Package/freeswitch/Module,oreka,Oreka,This module provides media recording with the Oreka cross-platform\naudio stream recording and retrieval system.,))
$(eval $(call Package/freeswitch/Module,perl,Perl,This package contains mod_perl for FreeSWITCH.,+libdb47 +libgdbm +perlbase-essential @PERL_THREADS))
$(eval $(call Package/freeswitch/Module,pgsql,PostgreSQL,Adds PostgreSQL support.,+libpq))
$(eval $(call Package/freeswitch/Module,png,PNG,Allows playback of video using PNG files.,@FS_WITH_PNG))
$(eval $(call Package/freeswitch/Module,pocketsphinx,Pocketsphinx,This module allows speech recognition. You might want to install\nfreeswitch-misc-grammar as well.,+libsamplerate)) # When libsamplerate is found it'll be linked against, there is no switch to turn it off
$(eval $(call Package/freeswitch/Module,portaudio,Portaudio,Voice through a local soundcard.,+portaudio))
$(eval $(call Package/freeswitch/Module,portaudio_stream,Portaudio streaming,Stream from an external audio source for Music on Hold.,+portaudio))
$(eval $(call Package/freeswitch/Module,posix_timer,POSIX timer,Add POSIX timer support.,))
$(eval $(call Package/freeswitch/Module,prefix,Prefix match,This module provides a data store with fast lookups by the longest\nprefix match rule.,))
$(eval $(call Package/freeswitch/Module,python3,Python3,Python3 support module.,+python3-light))
$(eval $(call Package/freeswitch/Module,radius_cdr,Radius CDR,Radius Call Detail Record handler.,))
$(eval $(call Package/freeswitch/Module,random,Entropy,This module extracts entropy from FreeSWITCH and feeds it into\n/dev/random.,))
$(eval $(call Package/freeswitch/Module,raven,Raven logging,Adds support for logging to Raven instances.,))
$(eval $(call Package/freeswitch/Module,rayo,Rayo,Rayo/XMPP 3PCC server for FreeSWITCH.,+freeswitch-mod-ssml))
$(eval $(call Package/freeswitch/Module,redis,Redis limit backend,This module provides a mechanism to use Redis as a limit backend data\nstore.,))
$(eval $(call Package/freeswitch/Module,rss,RSS,Parses and reads XML based RSS feeds and reads the entries aloud via a TTS engine.,))
$(eval $(call Package/freeswitch/Module,rtc,Media streaming,Media streaming as used by WebRTC and mod_verto.,))
$(eval $(call Package/freeswitch/Module,rtmp,RTMP endpoint,RTMP endpoint support. Allows FreeSWITCH to be used from RTMP clients.,))
$(eval $(call Package/freeswitch/Module,say_de,German Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_en,English Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_es,Spanish Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_es_ar,Argentinian Spanish Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_fa,Persian Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_fr,French Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_he,Hebrew Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_hr,Croatian Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_hu,Hungarian Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_it,Italian Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_ja,Japanese Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_nl,Dutch Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_pl,Polish Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_pt,Portuguese Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_ru,Russian Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_sv,Swedish Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_th,Thai Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,say_zh,Chinese Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/freeswitch/Module,shell_stream,Shell stream,Allows to stream audio from an arbitrary shell command.,))
$(eval $(call Package/freeswitch/Module,shout,Shout,Allows to stream audio from MP3s or Shoutcast streams.,+lame-lib +libmpg123 +libshout))
$(eval $(call Package/freeswitch/Module,signalwire,SignalWire,SignalWire CLOUD - FreeSWITCH connector.,+signalwire-client-c))
$(eval $(call Package/freeswitch/Module,skinny,Skinny,Skinny Call Control Protocol endpoint support.,))
$(eval $(call Package/freeswitch/Module,sms,SMS,This module provides an abstract facility for interfacing with SMS\nsystems.,))
$(eval $(call Package/freeswitch/Module,snapshot,Snapshot,This module can record a sliding window of audio and take snapshots\nto disk.,))
$(eval $(call Package/freeswitch/Module,sndfile,Soundfile,Adds sound format support via libsndfile.,+libsndfile))
$(eval $(call Package/freeswitch/Module,snmp,SNMP,An SNMP stats reporter.,+libnetsnmp))
$(eval $(call Package/freeswitch/Module,snom,SNOM,This module implements features specific to SNOM phones.,))
$(eval $(call Package/freeswitch/Module,sofia,Sofia SIP,SIP module.,))
$(eval $(call Package/freeswitch/Module,sonar,Sonar,This module measures the latency on an audio link by sending audible\naudio sonar pings.,))
$(eval $(call Package/freeswitch/Module,spandsp,SpanDSP,This module implements SpanDSP fax. It includes DSP and codec\nfunctionality.,+libjpeg-turbo +liblzma +libtiff))
$(eval $(call Package/freeswitch/Module,spy,User Spy,This module adds the ability to monitor the audio of a channel.,))
$(eval $(call Package/freeswitch/Module,ssml,SSML,mod_ssml is a FreeSWITCH module that renders SSML into audio. This\nmodule requires a text-to-speech module for speech synthesis.,))
$(eval $(call Package/freeswitch/Module,stress,Stress,This module attempts to detect voice stress on an audio channel.,))
$(eval $(call Package/freeswitch/Module,syslog,Syslog logger,Logs FreeSWITCH output to the syslog.,))
$(eval $(call Package/freeswitch/Module,theora,Theora passthrough,Theora video codec passthrough.,))
$(eval $(call Package/freeswitch/Module,tone_stream,Tone stream,Tone generation stream.,))
$(eval $(call Package/freeswitch/Module,translate,Number translation,This module implements number translation.,))
$(eval $(call Package/freeswitch/Module,tts_commandline,TTS command-line,Run a command-line and play the output file.,))
$(eval $(call Package/freeswitch/Module,valet_parking,Valet parking,This module implements the valet call parking strategy.,))
$(eval $(call Package/freeswitch/Module,verto,Verto,Verto signaling protocol.,+libks))
$(eval $(call Package/freeswitch/Module,video_filter,Video filter chromakey,This module provides a media bug for chromakey functionality.,))
$(eval $(call Package/freeswitch/Module,vmd,Voicemail detection,This module detects voicemail beeps.,))
$(eval $(call Package/freeswitch/Module,voicemail,Voicemail,This module provides a voicemail system.,))
$(eval $(call Package/freeswitch/Module,voicemail_ivr,Voicemail IVR,This module provides an extensible voicemail IVR system.,))
$(eval $(call Package/freeswitch/Module,xml_cdr,XML CDR,XML Call Detail Record handler.,))
$(eval $(call Package/freeswitch/Module,xml_curl,XML cURL,Provides an XML cURL interfaces to pull dynamic XML configuration for\nFreeSWITCH over HTTP.,))
$(eval $(call Package/freeswitch/Module,xml_ldap,XML LDAP,LDAP XML gateway.,+libopenldap))
$(eval $(call Package/freeswitch/Module,xml_rpc,XML RPC,Allows using the webapi to control FreeSWITCH.,))
$(eval $(call Package/freeswitch/Module,xml_scgi,XML SCGI,SCGI XML Gateway.,))
$(eval $(call Package/freeswitch/Module,yaml,YAML,YAML language module.,+libyaml))
$(eval $(call Package/freeswitch/Module,yuv,Raw YUV,Raw YUV I420 video codec support.,@FS_WITH_LIBYUV))

################################
# FreeSWITCH utilities
# Params:
# 1 - Package subname
# 2 - Package title
# 3 - Utility description
# 4 - Utility dependencies
# 5 - Utility is a script (y/n)
################################

$(eval $(call Package/freeswitch/Util,fs_cli,CLI,The fs_cli program is a Command-Line Interface that allows a user to\nconnect to a FreeSWITCH instance running on the local or a remote\nsystem.,,n))
$(eval $(call Package/freeswitch/Util,fs_encode,Sound file conversion,Format conversion of sound files so the result can be used by\nmod_native_file.,+freeswitch-mod-native-file +freeswitch-mod-sndfile +freeswitch-mod-spandsp,n))
$(eval $(call Package/freeswitch/Util,fs_ivrd,IVR daemon,The FreeSWITCH IVR daemon is an abstraction layer that sits on top of\nthe ESL. The basic idea is that the ivrd will allow the user to have\na STDIN/STDOUT interface for simple call control.,,n))
$(eval $(call Package/freeswitch/Util,fs_tts,TTS to sound file,Use TTS to generate a sound file.,,n))
$(eval $(call Package/freeswitch/Util,gentls_cert,TLS certificate,Can be used to create TLS certificates and setup CAs.,+openssl-util,y))
$(eval $(call Package/freeswitch/Util,tone2wav,Sound file generation,Generates a sound file from a teletone script. The output can be in\nany format that is supported by libsndfile.,+freeswitch-mod-sndfile,n))
