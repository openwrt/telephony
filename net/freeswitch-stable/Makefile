#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

# TODO
#
# - try to use system xmlrpc-c once it compiles again :-)

include $(TOPDIR)/rules.mk

PRG_NAME:=freeswitch
PKG_NAME:=$(PRG_NAME)-stable
PKG_VERSION:=1.6.17
PKG_RELEASE:=1
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

PKG_SOURCE:=$(PRG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://files.$(PRG_NAME).org/releases/$(PRG_NAME)
PKG_MD5SUM:=709b3e43362d86b9682a7db14eb344b74362493d68244dfc4e6f40218089d4e1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PRG_NAME)-$(PKG_VERSION)

# configure fails without libjpeg, but it's only needed for mod_spandsp
PKG_BUILD_DEPENDS:= \
	erlang \
	libjpeg \
	python \
	python-setuptools \
	swig/host

# With mod_ssml and mod_rayo enabled the parallel compiles always failed
#PKG_BUILD_PARALLEL:=1
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

FS_STABLE_DEPS_BASE:= \
	+FS_STABLE_WITH_PGSQL:libpq \
	+libopenssl \
	+libuuid

FS_STABLE_DEPS:= \
	$(FS_STABLE_DEPS_BASE) \
	+FS_STABLE_WITH_FREETYPE:libfreetype \
	+FS_STABLE_WITH_LIBEDIT:libedit \
	+FS_STABLE_WITH_ODBC:unixodbc \
	+FS_STABLE_WITH_PNG:libpng \
	+libcurl \
	+libpcre \
	+libpthread \
	+librt \
	+libspeex \
	+libspeexdsp \
	+libstdcpp \
	+libsqlite3 \
	+zlib

FS_STABLE_MOD_AVAILABLE:= \
	abstraction \
	alsa \
	amr \
	amrwb \
	av \
	avmd \
	basic \
	bert \
	blacklist \
	callcenter \
	cdr_csv \
	cdr_mongodb \
	cdr_pg_csv \
	cdr_sqlite \
	cidlookup \
	cluechoo \
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
	erlang_event \
	esf \
	esl \
	event_multicast \
	event_socket \
	expr \
	fifo \
	format_cdr \
	fsk \
	fsv \
	g723_1 \
	g729 \
	graylog2 \
	h26x \
	hash \
	hiredis \
	httapi \
	http_cache \
	isac \
	json_cdr \
	kazoo \
	lcr \
	ldap \
	local_stream \
	logfile \
	loopback \
	lua \
	mp4v \
	native_file \
	nibblebill \
	odbc_cdr \
	opus \
	oreka \
	png \
	prefix \
	python \
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
	unimrcp \
	valet_parking \
	verto \
	voicemail \
	voicemail_ivr \
	xml_cdr \
	xml_curl \
	xml_ldap \
	xml_rpc \
	xml_scgi \
	yaml

include $(INCLUDE_DIR)/package.mk

$(call include_mk, python-version.mk)
PYTHON_DIR:=$(STAGING_DIR)/usr
PYTHON_INC_DIR:=$(PYTHON_DIR)/include/python$(PYTHON_VERSION)
PYTHON_PKG_DIR:=/usr/lib/python$(PYTHON_VERSION)/site-packages

define Package/$(PKG_NAME)/install/bin
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/$(2) $(1)/usr/bin
endef

define Package/$(PKG_NAME)/install/dir
	for dir in $$$$(shell cd $(2); find -type d -print | sed 's|^./\?||'); \
	do \
		$(INSTALL_DIR) $(1)/$$$$$$$$dir; \
	done
	for file in $$$$(shell cd $(2); find -type f -print | sed 's|^./||'); \
	do \
		$(INSTALL_DATA) $(2)/$$$$$$$$file $(1)/$$$$$$$$file; \
	done
endef

define Package/$(PKG_NAME)/install/lib
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(2).so* $(1)/usr/lib
endef

define Package/$(PKG_NAME)/install/mod
	$(INSTALL_DIR) $(1)/usr/lib/$(PRG_NAME)/mod
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/$(PRG_NAME)/mod/mod_$(2).so \
						$(1)/usr/lib/$(PRG_NAME)/mod
ifeq ($(2),python)
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/$(PRG_NAME).py \
						$(1)$(PYTHON_PKG_DIR)
endif
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
  TITLE:=Open source telephony platform, v$(PKG_VERSION)
  MENU:=1
  USERID:=$(PRG_NAME)=372:$(PRG_NAME)=372
  DEPENDS:=$(FS_STABLE_DEPS)
  CONFLICTS:=$(PRG_NAME)
endef

define Package/$(PKG_NAME)/description
FreeSWITCH is a scalable open source cross-platform telephony platform
designed to route and interconnect popular communication protocols
using audio, video, text or any other form of media.
endef

define Package/$(PKG_NAME)/conffiles
/etc/$(PRG_NAME)
/etc/default/$(PRG_NAME)
/etc/init.d/$(PRG_NAME)
endef

define Package/$(PKG_NAME)/install
$(call Package/$(PKG_NAME)/install/bin,$(1),$(PRG_NAME))
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
ifeq ($(CONFIG_FS_STABLE_WITH_LIBEDIT),)
	$(SED) '/^  #procd_append_param command -nc -nf$$$$/s/#//' \
						$(1)/etc/init.d/$(PRG_NAME)
endif
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  # Prevent autostart of $(PRG_NAME)
  touch /etc/$(PRG_NAME)_disabled

  echo
  echo "o-------------------------------------------------------------------o"
  echo "| FreeSWITCH note                                                   |"
  echo "o-------------------------------------------------------------------o"
  echo "| Edit /etc/default/freeswitch to change basic init configuration.  |"
  echo "o-------------------------------------------------------------=^_^=-o"
  echo
fi
exit 0
endef

define Package/$(PKG_NAME)-hotplug
$(call Package/$(PKG_NAME)/Default)
  TITLE:=Hotplug script
  DEPENDS:=$(PKG_NAME)
  PKGARCH:=all
endef

define Package/$(PKG_NAME)-hotplug/description
This package includes a hotplug script for FreeSWITCH.
endef

define Package/$(PKG_NAME)-hotplug/install
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) ./files/$(PRG_NAME).hotplug \
					$(1)/etc/hotplug.d/iface/99-$(PRG_NAME)
endef

define Package/$(PKG_NAME)-hotplug/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  echo
  echo "o-------------------------------------------------------------------o"
  echo "| FreeSWITCH hotplug note                                           |"
  echo "o-------------------------------------------------------------------o"
  echo "| See /etc/default/freeswitch for hotplug hints.                    |"
  echo "o-------------------------------------------------------------=^_^=-o"
  echo
fi
exit 0
endef

define Package/$(PKG_NAME)-python-esl
$(call Package/$(PKG_NAME)/Default)
  TITLE:=Python ESL
  DEPENDS:=$(PKG_NAME) +python-light
endef

define Package/$(PKG_NAME)-python-esl/description
This package contains the Python binding for FreeSWITCH's Event Socket
Library (ESL).
endef

define Package/$(PKG_NAME)-python-esl/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/ESL.py \
					$(1)$(PYTHON_PKG_DIR)
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/_ESL.so \
					$(1)$(PYTHON_PKG_DIR)
endef

define Package/$(PKG_NAME)-timezones
$(call Package/$(PKG_NAME)/Default)
  TITLE:=Timezones file
  DEPENDS:=$(PKG_NAME)
  PKGARCH:=all
endef

define Package/$(PKG_NAME)-timezones/description
This package includes a timezones file for FreeSWITCH.
endef

define Package/$(PKG_NAME)-timezones/install
	$(INSTALL_DIR) $(1)/usr/share/$(PRG_NAME)/tz
	$(INSTALL_DATA) \
	$(PKG_BUILD_DIR)/conf/vanilla/autoload_configs/timezones.conf.xml \
						$(1)/usr/share/$(PRG_NAME)/tz
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
/etc/freeswitch. The system administrator is completely responsible
for that directory. If you install one of the example configuration
packages, it will install the corresponding sample configuration to
/usr/share/freeswitch/conf where you can take a look at it.
endef
define Package/$(PKG_NAME)-example-$(1)/install
$(call Package/$(PKG_NAME)/install/dir,$$(1)/usr/share/$(PRG_NAME)/conf/$(1),$(PKG_BUILD_DIR)/conf/$(1))
endef
$$(eval $$(call BuildPackage,$(PKG_NAME)-example-$(1)))
endef

define Package/$(PKG_NAME)/Language
define Package/$(PKG_NAME)-lang-$(1)
$(call Package/$(PKG_NAME)/Default)
  TITLE:=$(2) language files
  DEPENDS:=$(PKG_NAME)
  PKGARCH:=all
endef
define Package/$(PKG_NAME)-lang-$(1)/description
This package includes the $(2) language files for FreeSWITCH.
endef
define Package/$(PKG_NAME)-lang-$(1)/install
$(call Package/$(PKG_NAME)/install/dir,$$(1)/usr/share/$(PRG_NAME)/lang/$(1),$(PKG_BUILD_DIR)/conf/vanilla/lang/$(1))
endef
$$(eval $$(call BuildPackage,$(PKG_NAME)-lang-$(1)))
endef

define Package/$(PKG_NAME)/Module
define Package/$(PKG_NAME)-mod-$(1)
$(call Package/$(PKG_NAME)/Default)
  TITLE:=$(2) module
  DEPENDS:=$(PKG_NAME) $(4)
endef
define Package/$(PKG_NAME)-mod-$(1)/description
$(subst \n,$(newline),$(3))
endef
define Package/$(PKG_NAME)-mod-$(1)/install
$(call Package/$(PKG_NAME)/install/mod,$$(1),$(1))
endef
$$(eval $$(call BuildPackage,$(PKG_NAME)-mod-$(1)))
endef

define Package/$(PKG_NAME)/Util
define Package/$(PKG_NAME)-util-$(1)
$(call Package/$(PKG_NAME)/Default)
  TITLE:=$(2) utility
  DEPENDS:=$(PKG_NAME) $(4)
  ifeq ($(5),y)
  PKGARCH:=all
  endif
endef
define Package/$(PKG_NAME)-util-$(1)/description
$(subst \n,$(newline),$(3))
endef
define Package/$(PKG_NAME)-util-$(1)/install
$(call Package/$(PKG_NAME)/install/bin,$$(1),$(1))
endef
ifeq ($(1)$(CONFIG_FS_STABLE_WITH_LIBEDIT),fs_cli)
define Package/$(PKG_NAME)-util-$(1)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  echo
  echo "o-------------------------------------------------------------------o"
  echo "| fs_cli note                                                       |"
  echo "o-------------------------------------------------------------------o"
  echo "| Your FreeSWITCH was compiled without libedit support. Due to an   |"
  echo "| interop issue it's possible that when you try to exit fs_cli with |"
  echo "| Ctrl-D, you'll see messages flashing by and have to kill fs_cli   |"
  echo "| manually. To avoid this you can either use Ctrl-C instead (fs_cli |"
  echo "| needs to be started with '-i' for this to work; you could create  |"
  echo "| an appropriate alias in /etc/profile) or type /exit, /quit or     |"
  echo "| /bye.                                                             |"
  echo "o-------------------------------------------------------------=^_^=-o"
  echo
fi
exit 0
endef
endif
$$(eval $$(call BuildPackage,$(PKG_NAME)-util-$(1)))
endef

# we neither need host-perl nor host-php
CONFIGURE_VARS+= \
	ac_cv_prog_PERL=false \
	ac_cv_have_perl=no \
	ac_cv_prog_PHP=false \
	ac_cv_have_php=no \
	ac_cv_prog_PHP_CONFIG=false \
	ac_cv_have_php_config=no

# The autoconf variables in this block are OK for both musl and glibc
CONFIGURE_VARS+= \
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

# Regarding apr_cv_mutex_robust_shared=no see
# http://www.openwall.com/lists/musl/2016/11/26/1
# _Don't_ remove quotes below!
ifeq ($(CONFIG_LIBC),"musl")
CONFIGURE_VARS+= \
	apr_cv_mutex_robust_shared=no \
	ac_cv_strerror_r_rc_int=yes
else
CONFIGURE_VARS+= \
	apr_cv_mutex_robust_shared=yes
endif

# fs_cli
CONFIGURE_VARS+= \
	disable_cc=yes

CONFIGURE_ARGS+= \
	--build=$(GNU_HOST_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--target=$(GNU_TARGET_NAME) \
	--prefix=/usr/share/$(PRG_NAME) \
	--bindir=/usr/bin \
	--libdir=/usr/lib \
	--srcdir=$(PKG_BUILD_DIR) \
	--sysconfdir=/etc \
	--disable-dependency-tracking \
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
	_python_sysroot="$(STAGING_DIR)" \
	_python_prefix="/usr" \
	_python_exec_prefix="/usr" \
	$(call autoconf_bool,CONFIG_FS_STABLE_WITH_LIBEDIT,core-libedit-support) \
	$(call autoconf_bool,CONFIG_FS_STABLE_WITH_ODBC,core-odbc-support) \
	$(call autoconf_bool,CONFIG_FS_STABLE_WITH_SRTP,srtp) \
	$(call autoconf_bool,CONFIG_FS_STABLE_WITH_ZRTP,zrtp) \
	$(if $(CONFIG_FS_STABLE_WITH_DEBUG),,--disable-debug) \
	$(if $(CONFIG_FS_STABLE_WITH_FREETYPE),,--without-freetype) \
	$(if $(CONFIG_FS_STABLE_WITH_LIBYUV),,--disable-libyuv) \
	$(if $(CONFIG_FS_STABLE_WITH_ODBC),--with-odbc-lib="$(STAGING_DIR)/usr/lib") \
	$(if $(CONFIG_FS_STABLE_WITH_ODBC),--with-odbc="$(STAGING_DIR)/usr") \
	$(if $(CONFIG_FS_STABLE_WITH_PGSQL),--enable-core-pgsql-support,--without-pgsql) \
	$(if $(CONFIG_FS_STABLE_WITH_PNG),,--without-png) \
	$(if $(CONFIG_FS_STABLE_WITH_VPX),,--disable-libvpx)

define Build/Prepare
	$(call Build/Prepare/Default)
	$(SED) '/^#/!s/^/#/' $(PKG_BUILD_DIR)/modules.conf
	$(foreach m,$(FS_STABLE_MOD_AVAILABLE),
		$(if $(CONFIG_PACKAGE_$(PKG_NAME)-mod-$(m)),
		$(SED) '/mod_$(m)$$$$/s/^#//' $(PKG_BUILD_DIR)/modules.conf))

	$(SED) 's|^LOCAL_CFLAGS=.*|LOCAL_CFLAGS=-I$(PYTHON_INC_DIR)|' \
		$(PKG_BUILD_DIR)/libs/esl/python/Makefile
	$(SED) 's|^LOCAL_LDFLAGS=.*|LOCAL_LDFLAGS=$(TARGET_LDFLAGS) -lpython$(PYTHON_VERSION)|' \
		$(PKG_BUILD_DIR)/libs/esl/python/Makefile
	$(SED) 's|^SITE_DIR=.*|SITE_DIR=$$$$(DESTDIR)$(PYTHON_PKG_DIR)|' \
		$(PKG_BUILD_DIR)/libs/esl/python/Makefile
	$(SED)'s|swig2.0|$(STAGING_DIR)/host/bin/swig|' \
		$(PKG_BUILD_DIR)/libs/esl/python/Makefile
	$(RM) $(PKG_BUILD_DIR)/libs/esl/python/esl_wrap.cpp
	$(SED)'s|swig2.0|$(STAGING_DIR)/host/bin/swig|' \
		$(PKG_BUILD_DIR)/src/mod/languages/mod_python/Makefile.am
	$(RM) $(PKG_BUILD_DIR)/src/mod/languages/mod_python/mod_python_wrap.cpp
	$(SED)'s|^PYTHON_SITE_DIR=.*|PYTHON_SITE_DIR=$(PYTHON_PKG_DIR)|' \
		$(PKG_BUILD_DIR)/src/mod/languages/mod_python/Makefile.am

# Hack for mod_unimrcp - it has a build-time dep on mod_sofia
ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-mod-unimrcp),)
ifeq ($(CONFIG_PACKAGE_$(PKG_NAME)-mod-sofia),)
	$(SED) '/mod_sofia$$$$/s/^#//' $(PKG_BUILD_DIR)/modules.conf
endif
endif
endef

define Build/Configure
	find $(PKG_BUILD_DIR) -name missing -type f -exec rm {} \;
	cd $(PKG_BUILD_DIR); $(AM_TOOL_PATHS) ./rebootstrap.sh
	$(call Build/Configure/Default)
endef

define Build/Compile
	$(call Build/Compile/Default)
	$(call Build/Compile/Default,-C $(PKG_BUILD_DIR)/libs/esl pymod)
endef

define Build/Install
	$(call Build/Install/Default)
	$(call Build/Install/Default,-C $(PKG_BUILD_DIR)/libs/esl pymod-install)
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-hotplug))
$(eval $(call BuildPackage,$(PKG_NAME)-python-esl))
$(eval $(call BuildPackage,$(PKG_NAME)-timezones))

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

################################
# FreeSWITCH language files
# Params:
# 1 - Language code
# 2 - Language
################################

$(eval $(call Package/$(PKG_NAME)/Language,de,German))
$(eval $(call Package/$(PKG_NAME)/Language,en,English))
$(eval $(call Package/$(PKG_NAME)/Language,es,Spanish))
$(eval $(call Package/$(PKG_NAME)/Language,fr,French))
$(eval $(call Package/$(PKG_NAME)/Language,he,Hebrew))
$(eval $(call Package/$(PKG_NAME)/Language,pt,Portuguese))
$(eval $(call Package/$(PKG_NAME)/Language,ru,Russian))
$(eval $(call Package/$(PKG_NAME)/Language,sv,Swedish))

################################
# FreeSWITCH modules
# Params:
# 1 - Package subname
# 2 - Package title
# 3 - Module description
# 4 - Module dependencies
################################

$(eval $(call Package/$(PKG_NAME)/Module,abstraction,API abstraction,This module provides a way to create new API functions via regex\nrewriting.,))
$(eval $(call Package/$(PKG_NAME)/Module,alsa,ALSA endpoint,ALSA endpoint module.,+alsa-lib))
$(eval $(call Package/$(PKG_NAME)/Module,amr,AMR passthrough,Passthrough AMR codec support.,))
$(eval $(call Package/$(PKG_NAME)/Module,amrwb,AMR wideband passthrough,Passthrough AMR wideband codec support.,))
$(eval $(call Package/$(PKG_NAME)/Module,av,AV,Video codec and format support via FFmpeg.,+libffmpeg-full @BROKEN))
$(eval $(call Package/$(PKG_NAME)/Module,avmd,Voicemail detection,This module attempts to determine when a voicemail system has answered\nthe call.,))
$(eval $(call Package/$(PKG_NAME)/Module,basic,BASIC,BASIC module for FreeSWITCH.,))
$(eval $(call Package/$(PKG_NAME)/Module,bert,BERT,Line testing tool.,))
$(eval $(call Package/$(PKG_NAME)/Module,blacklist,Blacklist helper,This module provides tools to blacklist callers.,))
$(eval $(call Package/$(PKG_NAME)/Module,callcenter,Call center,This module implements Automated Call Distribution queues.,))
$(eval $(call Package/$(PKG_NAME)/Module,cdr_csv,CSV CDR,CSV Call Detail Record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,cdr_mongodb,MongoDB CDR,MongoDB Call Detail Record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,cdr_pg_csv,PostgreSQL CDR,PostgreSQL Call Detail Record handler.,@FS_STABLE_WITH_PGSQL))
$(eval $(call Package/$(PKG_NAME)/Module,cdr_sqlite,SQLite CDR,SQLite Call Detail Record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,cidlookup,Caller ID lookup,This module provides an API for querying caller ID name and location\ndata.,))
$(eval $(call Package/$(PKG_NAME)/Module,cluechoo,Clue Choo,This demo module renders a Clue Choo train on the FreeSWITCH console.,+libncurses))
$(eval $(call Package/$(PKG_NAME)/Module,commands,Commands,This module provides miscellaneous API commands.,))
$(eval $(call Package/$(PKG_NAME)/Module,conference,Conference,This module provides multi-party conferencing.,))
$(eval $(call Package/$(PKG_NAME)/Module,console,Console logger,Allows control over what messages get logged to the console. When\nFreeSWITCH is compiled without libedit support - this is not the\ndefault - mod_console has no effect because the init script starts\nFreeSWITCH with the console disabled to work around an\ninteroperability issue that causes high CPU load.,))
$(eval $(call Package/$(PKG_NAME)/Module,curl,cURL,This module provides an API for making HTTP requests with cURL.,))
$(eval $(call Package/$(PKG_NAME)/Module,db,DB,This module implements a simple db API with group support. Also can be\nused as a limit db backend.,))
$(eval $(call Package/$(PKG_NAME)/Module,dialplan_asterisk,Asterisk dialplan,Asterisk extensions.conf style dialplan parser.,))
$(eval $(call Package/$(PKG_NAME)/Module,dialplan_xml,XML dialplan,Standard FreeSWITCH XML dialplan support.,))
$(eval $(call Package/$(PKG_NAME)/Module,dingaling,Generic XMPP,Allows FreeSWITCH to be used as a client for XMPP Servers.,))
$(eval $(call Package/$(PKG_NAME)/Module,directory,Dial-by-name directory,This module implements a dial-by-name directory IVR.,))
$(eval $(call Package/$(PKG_NAME)/Module,distributor,Load distributor,This module implements a mechanism for performing load balancing.,))
$(eval $(call Package/$(PKG_NAME)/Module,dptools,Dialplan tools,This module implements basic dialplan tools.,))
$(eval $(call Package/$(PKG_NAME)/Module,easyroute,DID routing,This module does destination lookup based on DID.,))
$(eval $(call Package/$(PKG_NAME)/Module,enum,ENUM routing,This module implements ENUM support.,+libldns))
$(eval $(call Package/$(PKG_NAME)/Module,erlang_event,Erlang event,Erlang event module.,))
$(eval $(call Package/$(PKG_NAME)/Module,esf,Multicast,This module adds multi-cast support.,))
$(eval $(call Package/$(PKG_NAME)/Module,esl,Single ESL,This module adds an API for generating one-off ESL requests.,))
$(eval $(call Package/$(PKG_NAME)/Module,event_multicast,Multicast Event,Multicast Event System for FreeSWITCH.,))
$(eval $(call Package/$(PKG_NAME)/Module,event_socket,Event socket,Sends events via a single socket. Needed for fs_cli.,))
$(eval $(call Package/$(PKG_NAME)/Module,expr,Expr,This module adds expr support for expression evaluation.,))
$(eval $(call Package/$(PKG_NAME)/Module,fifo,FIFO,This module adds a first-in first-out queue system.,))
$(eval $(call Package/$(PKG_NAME)/Module,format_cdr,Multiformat CDR,A superset of mod_json_cdr and mod_xml_cdr.,))
$(eval $(call Package/$(PKG_NAME)/Module,fsk,FSK,This module adds frequency-shift keying support which can be used to\nsend and receive caller ID.,))
$(eval $(call Package/$(PKG_NAME)/Module,fsv,FSV,This module provides dialplan applications for recording and playing\nvideos.,))
$(eval $(call Package/$(PKG_NAME)/Module,g723_1,G.723.1 passthrough,G.723.1 codec passthrough.,))
$(eval $(call Package/$(PKG_NAME)/Module,g729,G.729 passthrough,G.729 codec passthrough.,))
$(eval $(call Package/$(PKG_NAME)/Module,graylog2,Graylog2 logger,GELF logger for Graylog2 and Logstash.,))
$(eval $(call Package/$(PKG_NAME)/Module,h26x,H.26x passthrough,H.26x video codec passthrough.,))
$(eval $(call Package/$(PKG_NAME)/Module,hash,Hash,This module provides a key-value in-memory datastore. Usable as a\nlimit backend.,))
$(eval $(call Package/$(PKG_NAME)/Module,hiredis,Redis client,This module provides a mechanism to use Redis as a datastore.,libhiredis))
$(eval $(call Package/$(PKG_NAME)/Module,httapi,HT-TAPI,This module provides an API for controlling the switch by responding\nto HTTP requests.,))
$(eval $(call Package/$(PKG_NAME)/Module,http_cache,HTTP GET with caching,This module provides an API for making HTTP GET requests where the\nresult is cached.,))
$(eval $(call Package/$(PKG_NAME)/Module,isac,iSAC,iSAC codec support.,))
$(eval $(call Package/$(PKG_NAME)/Module,json_cdr,JSON CDR,JSON-based Call Detail Record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,kazoo,Kazoo,Kazoo module for FreeSWITCH.,))
$(eval $(call Package/$(PKG_NAME)/Module,lcr,LCR,This module adds a facility for least-cost routing.,))
$(eval $(call Package/$(PKG_NAME)/Module,ldap,LDAP,LDAP module for FreeSWITCH.,+libopenldap))
$(eval $(call Package/$(PKG_NAME)/Module,local_stream,Local stream,Connects multiple channels to a looped stream.,))
$(eval $(call Package/$(PKG_NAME)/Module,logfile,File logger,Logs FreeSWITCH output to a file.,))
$(eval $(call Package/$(PKG_NAME)/Module,loopback,Loopback,A loopback channel driver.,))
$(eval $(call Package/$(PKG_NAME)/Module,lua,Lua,Lua language interface for FreeSWITCH.,+liblua))
$(eval $(call Package/$(PKG_NAME)/Module,mp4v,MP4 video passthrough,MP4 video passthrough..,))
$(eval $(call Package/$(PKG_NAME)/Module,native_file,Native file,Plays files that are already encoded in the right format.,))
$(eval $(call Package/$(PKG_NAME)/Module,nibblebill,Nibblebill,This module allows for real-time accounting of a cash balance and\nusing that information for call routing.,))
$(eval $(call Package/$(PKG_NAME)/Module,odbc_cdr,ODBC CDR,ODBC Call Detail Record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,opus,Opus,Opus codec support.,+libopus))
$(eval $(call Package/$(PKG_NAME)/Module,oreka,Oreka,This module provides media recording with the Oreka cross-platform\naudio stream recording and retrieval system.,))
$(eval $(call Package/$(PKG_NAME)/Module,png,PNG,Allows playback of video using PNG files.,))
$(eval $(call Package/$(PKG_NAME)/Module,prefix,Prefix match,This module provides a data store with fast lookups by the longest\nprefix match rule.,))
$(eval $(call Package/$(PKG_NAME)/Module,python,Python,Python support module.,+python-light))
$(eval $(call Package/$(PKG_NAME)/Module,rayo,Rayo,Rayo/XMPP 3PCC server for FreeSWITCH.,+$(PKG_NAME)-mod-ssml))
$(eval $(call Package/$(PKG_NAME)/Module,redis,Redis limit backend,This module provides a mechanism to use Redis as a limit backend data\nstore.,))
$(eval $(call Package/$(PKG_NAME)/Module,rss,RSS,Parses and reads XML based RSS feeds and reads the entries aloud via a TTS engine.,))
$(eval $(call Package/$(PKG_NAME)/Module,rtc,Media streaming,Media streaming as used by WebRTC and mod_verto.,))
$(eval $(call Package/$(PKG_NAME)/Module,rtmp,RTMP endpoint,RTMP endpoint support. Allows FreeSWITCH to be used from RTMP clients.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_de,German Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_en,English Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_es,Spanish Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_es_ar,Argentinian Spanish Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_fa,Persian Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_fr,French Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_he,Hebrew Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_hr,Croatian Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_hu,Hungarian Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_it,Italian Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_ja,Japanese Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_nl,Dutch Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_pl,Polish Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_pt,Portuguese Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_ru,Russian Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_sv,Swedish Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_th,Thai Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,say_zh,Chinese Say,Uses prerecorded sounds to read or say various things.,))
$(eval $(call Package/$(PKG_NAME)/Module,shell_stream,Shell stream,Allows to stream audio from an arbitrary shell command.,))
$(eval $(call Package/$(PKG_NAME)/Module,shout,Shout,Allows to stream audio from MP3s or Shoutcast streams.,+lame-lib +libmpg123 +libshout))
$(eval $(call Package/$(PKG_NAME)/Module,skinny,Skinny,Skinny Call Control Protocol endpoint support.,))
$(eval $(call Package/$(PKG_NAME)/Module,sms,SMS,This module provides an abstract facility for interfacing with SMS\nsystems.,))
$(eval $(call Package/$(PKG_NAME)/Module,snapshot,Snapshot,This module can record a sliding window of audio and take snapshots\nto disk.,))
$(eval $(call Package/$(PKG_NAME)/Module,sndfile,Soundfile,Adds sound format support via libsndfile.,+libsndfile))
$(eval $(call Package/$(PKG_NAME)/Module,snmp,SNMP,An SNMP stats reporter.,+libnetsnmp))
$(eval $(call Package/$(PKG_NAME)/Module,snom,SNOM,This module implements features specific to SNOM phones.,))
$(eval $(call Package/$(PKG_NAME)/Module,sofia,Sofia SIP,SIP module.,))
$(eval $(call Package/$(PKG_NAME)/Module,sonar,Sonar,This module measures the latency on an audio link by sending audible\naudio sonar pings.,))
$(eval $(call Package/$(PKG_NAME)/Module,spandsp,SpanDSP,This module implements SpanDSP fax. It includes DSP and codec\nfunctionality.,+libjpeg +liblzma))
$(eval $(call Package/$(PKG_NAME)/Module,spy,User Spy,This module adds the ability to monitor the audio of a channel.,))
$(eval $(call Package/$(PKG_NAME)/Module,ssml,SSML,mod_ssml is a FreeSWITCH module that renders SSML into audio. This\nmodule requires a text-to-speech module for speech synthesis.,))
$(eval $(call Package/$(PKG_NAME)/Module,stress,Stress,This module attempts to detect voice stress on an audio channel.,))
$(eval $(call Package/$(PKG_NAME)/Module,syslog,Syslog logger,Logs FreeSWITCH output to the syslog.,))
$(eval $(call Package/$(PKG_NAME)/Module,theora,Theora passthrough,Theora video codec passthrough.,))
$(eval $(call Package/$(PKG_NAME)/Module,tone_stream,Tone stream,Tone generation stream.,))
$(eval $(call Package/$(PKG_NAME)/Module,translate,Number translation,This module implements number translation.,))
$(eval $(call Package/$(PKG_NAME)/Module,tts_commandline,TTS command-line,Run a command-line and play the output file.,))
$(eval $(call Package/$(PKG_NAME)/Module,unimrcp,UniMRCP,Allows communication with Media Resource Control Protocol servers.,))
$(eval $(call Package/$(PKG_NAME)/Module,valet_parking,Valet parking,This module implements the valet call parking strategy.,))
$(eval $(call Package/$(PKG_NAME)/Module,verto,Verto,Verto signaling protocol.,))
$(eval $(call Package/$(PKG_NAME)/Module,voicemail,Voicemail,This module provides a voicemail system.,))
$(eval $(call Package/$(PKG_NAME)/Module,voicemail_ivr,Voicemail IVR,This module provides an extensible voicemail IVR system.,))
$(eval $(call Package/$(PKG_NAME)/Module,xml_cdr,XML CDR,XML Call Detail Record handler.,))
$(eval $(call Package/$(PKG_NAME)/Module,xml_curl,XML cURL,Provides an XML cURL interfaces to pull dynamic XML configuration for\nFreeSWITCH over HTTP.,))
$(eval $(call Package/$(PKG_NAME)/Module,xml_ldap,XML LDAP,LDAP XML gateway.,+libopenldap))
$(eval $(call Package/$(PKG_NAME)/Module,xml_rpc,XML RPC,Allows using the webapi to control FreeSWITCH.,))
$(eval $(call Package/$(PKG_NAME)/Module,xml_scgi,XML SCGI,SCGI XML Gateway.,))
$(eval $(call Package/$(PKG_NAME)/Module,yaml,YAML,YAML language module.,+libyaml))

################################
# FreeSWITCH utilities
# Params:
# 1 - Package subname
# 2 - Package title
# 3 - Utility description
# 4 - Utility dependencies
# 5 - Utility is a script (y/n)
################################

$(eval $(call Package/$(PKG_NAME)/Util,fs_cli,CLI,The fs_cli program is a Command-Line Interface that allows a user to\nconnect to a FreeSWITCH instance running on the local or a remote\nsystem.,$(FS_STABLE_DEPS_BASE) +FS_STABLE_WITH_LIBEDIT:libedit,n))
$(eval $(call Package/$(PKG_NAME)/Util,fs_encode,Sound file conversion,Format conversion of sound files so the result can be used by\nmod_native_file.,$(FS_STABLE_DEPS) +$(PKG_NAME)-mod-native_file +$(PKG_NAME)-mod-sndfile +$(PKG_NAME)-mod-spandsp,n))
$(eval $(call Package/$(PKG_NAME)/Util,fs_ivrd,IVR daemon,The FreeSWITCH IVR daemon is an abstraction layer that sits on top of\nthe ESL. The basic idea is that the ivrd will allow the user to have\na STDIN/STDOUT interface for simple call control.,$(FS_STABLE_DEPS_BASE),n))
$(eval $(call Package/$(PKG_NAME)/Util,gentls_cert,TLS certificate,Can be used to create TLS certificates and setup CAs.,+openssl-util,y))
$(eval $(call Package/$(PKG_NAME)/Util,tone2wav,Sound file generation,Generates a sound file from a teletone script. The output can be in\nany format that is supported by libsndfile.,$(FS_STABLE_DEPS) +$(PKG_NAME)-mod-sndfile,n))
