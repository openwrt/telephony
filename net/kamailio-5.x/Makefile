#
# Copyright (C) 2017 OpenWrt.org
# Copyright (C) 2017 Jiri Slachta
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kamailio5
PKG_VERSION:=5.2.1
PKG_RELEASE:=2

PKG_SOURCE_URL:=https://www.kamailio.org/pub/kamailio/$(PKG_VERSION)/src
PKG_SOURCE:=kamailio-$(PKG_VERSION)$(PKG_VARIANT)_src.tar.gz
PKG_HASH:=95d2158f97c76124a381364d99de1420f193275c5a1c9f88489c6409702f2c8f
PKG_USE_MIPS16:=0

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

# Defining PKG_BUILD_PARALLEL to 1 would be a noop due to the way we call make
#PKG_BUILD_PARALLEL:=1

MODULES_AVAILABLE:= \
	acc \
	acc_diameter \
	acc_json \
	alias_db \
	app_jsdt \
	app_lua \
	app_python \
	app_python3 \
	app_ruby \
	app_sqlang \
	async \
	auth \
	auth_db \
	auth_diameter \
	auth_ephemeral \
	auth_identity \
	auth_xkeys \
	avp \
	avpops \
	benchmark \
	blst \
	call_control \
	call_obj \
	carrierroute \
	cdp \
	cdp_avp \
	cfgutils \
	cfg_db \
	cfg_rpc \
	cfgt \
	cnxcc \
	corex \
	counters \
	cplc \
	crypto \
	ctl \
	db2_ldap \
	db2_ops \
	db_berkeley \
	db_cluster \
	db_flatstore \
	db_mysql \
	db_postgres \
	db_redis \
	db_sqlite \
	db_text \
	db_unixodbc \
	debugger \
	dialog \
	dialplan \
	dispatcher \
	diversion \
	dmq \
	dmq_usrloc \
	domain \
	domainpolicy \
	drouting \
	enum \
	erlang \
	evapi \
	evrexec \
	exec \
	group \
	gzcompress \
	h350 \
	htable \
	http_client \
	imc \
	ims_auth \
	ims_charging \
	ims_dialog \
	ims_diameter_server \
	ims_icscf \
	ims_ipsec_pcscf \
	ims_isc \
	ims_ocs \
	ims_qos \
	ims_registrar_pcscf \
	ims_registrar_scscf \
	ims_usrloc_pcscf \
	ims_usrloc_scscf \
	ipops \
	jansson \
	janssonrpcc \
	json \
	jsonrpcs \
	keepalive \
	kex \
	lcr \
	ldap \
	log_custom \
	mangler \
	matrix \
	maxfwd \
	mediaproxy \
	mohqueue \
	mqueue \
	msilo \
	msrp \
	mtree \
	nathelper \
	nat_traversal \
	ndb_redis \
	nosip \
	outbound \
	p_usrloc \
	path \
	pdb \
	pdt \
	permissions \
	pike \
	pipelimit \
	prefix_route \
	presence \
	presence_conference \
	presence_dialoginfo \
	presence_mwi \
	presence_profile \
	presence_reginfo \
	presence_xml \
	pua \
	pua_bla \
	pua_dialoginfo \
	pua_json \
	pua_reginfo \
	pua_rpc \
	pua_usrloc \
	pua_xmpp \
	pv \
	qos \
	ratelimit \
	regex \
	registrar \
	rls \
	rr \
	rtimer \
	rtjson \
	rtpengine \
	rtpproxy \
	sanity \
	sca \
	sctp \
	sdpops \
	seas \
	sipcapture \
	sipdump \
	sipt \
	siptrace \
	siputils \
	sl \
	sms \
	smsops \
	snmpstats \
	speeddial \
	sqlops \
	ss7ops \
	statistics \
	statsc \
	statsd \
	stun \
	sst \
	tcpops \
	textops \
	textopsx \
	timer \
	tls \
	tmrec \
	topoh \
	topos \
	topos_redis \
	tm \
	tmx \
	tsilo \
	uac \
	uac_redirect \
	uid_auth_db \
	uid_avp_db \
	uid_domain \
	uid_gflags \
	uid_uri_db \
	uri_db \
	userblacklist \
	usrloc \
	utils \
	uuid \
	websocket \
	xcap_client \
	xcap_server \
	xhttp \
	xhttp_pi \
	xhttp_rpc \
	xlog \
	xmlops \
	xmlrpc \
	xmpp \
	xprint

PKG_CONFIG_DEPENDS:= \
	$(patsubst %,CONFIG_PACKAGE_$(PKG_NAME)-mod-%,$(subst _,-,$(MODULES_AVAILABLE)))

include $(INCLUDE_DIR)/nls.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-host.mk

# Build reproducibly
TARGET_CFLAGS += -DVERSION_NODATE=1

PREBUILT_STAMP=$(STAGING_DIR)/stamp/.$(PKG_NAME)_prebuilt
TAR_CMD:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components 1 $(TAR_OPTIONS)

INCL_MODULES:=

define Package/kamailio5/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  URL:=http://www.kamailio.org/
  DEPENDS:=$(ICONV_DEPENDS) +libncurses +libpthread +libreadline +libxml2
endef

define Package/kamailio5
$(call Package/kamailio5/Default)
  TITLE:=Mature and flexible open source SIP server, v$(PKG_VERSION)
  USERID:=kamailio=380:kamailio=380
  MENU:=1
endef

define Package/kamailio5/conffiles
/etc/config/kamailio
/etc/init.d/kamailio
/etc/kamailio/kamailio.cfg
/etc/kamailio/kamctlrc
endef

define Package/kamailio5/install
$(foreach c,kamailio.cfg kamctlrc,$(call Package/kamailio5/install/conffile,$(1),$(c));)
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/sbin/kam{ailio,cmd,ctl,dbctl} \
		$(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/lib/kamailio/modules
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/kamailio/lib{srdb1,srdb2,srutils}.so* \
		$(1)/usr/lib/kamailio/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) \
		./files/kamailio.config \
		$(1)/etc/config/kamailio
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) \
		./files/kamailio.init \
		$(1)/etc/init.d/kamailio
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) \
		./files/kamailio.hotplug \
		$(1)/etc/hotplug.d/iface/99-kamailio
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/kamailio/kamctl \
		$(1)/usr/lib/kamailio/
endef

define Package/kamailio5/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  echo
  echo "o-------------------------------------------------------------------o"
  echo "| Kamailio note                                                     |"
  echo "o-------------------------------------------------------------------o"
  echo "| Edit /etc/config/kamailio to change basic init configuration.     |"
  echo "o-------------------------------------------------------------=^_^=-o"
  echo
fi
exit 0
endef

define Package/kamailio5/install/conffile
	$(INSTALL_DIR) $(1)/etc/kamailio
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/kamailio/$(2) $(1)/etc/kamailio
endef

define Package/kamailio5/install/dbfiles
	$(INSTALL_DIR) $(1)/usr/share/kamailio/$(2)
	$(CP) $(PKG_INSTALL_DIR)/usr/share/kamailio/$(2)/* $(1)/usr/share/kamailio/$(2)/
endef

define Package/kamailio5/install/module
	$(INSTALL_DIR) $(1)/usr/lib/kamailio/modules
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/kamailio/modules/$(2).so* $(1)/usr/lib/kamailio/modules/
endef

define Package/kamailio5-lib-libkamailio-ims
$(call Package/kamailio5/Default)
  TITLE:=Kamailio5 IMS library
  DEPENDS:=kamailio5
endef

define Package/kamailio5-lib-libkamailio-ims/install
	$(INSTALL_DIR) $(1)/usr/lib/kamailio
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/kamailio/libkamailio_ims.so* \
						$(1)/usr/lib/kamailio
endef

define Package/kamailio5-lib-libtrie
$(call Package/kamailio5/Default)
  TITLE:=Kamailio5 digital tree library
  DEPENDS:=kamailio5
endef

define Package/kamailio5-lib-libtrie/install
	$(INSTALL_DIR) $(1)/usr/lib/kamailio
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/kamailio/libtrie.so* \
					$(1)/usr/lib/kamailio
endef

define Package/kamailio5-util-kambdb-recover
$(call Package/kamailio5/Default)
  TITLE:=Kamailio5 Berkeley DB recovery utility
  DEPENDS:=kamailio5 +PACKAGE_kamailio5-util-kambdb-recover:kamailio5-mod-db-berkeley
endef

define Package/kamailio5-util-kambdb-recover/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/kambdb_recover $(1)/usr/sbin
endef

define BuildKamailio5Module
  define Package/kamailio5-mod-$(subst _,-,$(1))
    $$(call Package/kamailio5/Default)
    TITLE:=$(2) for Kamailio5
    DEPENDS:=kamailio5 $(patsubst +%,+PACKAGE_kamailio5-mod-$(subst _,-,$(1)):%,$(4))
    ifneq ($$(CONFIG_PACKAGE_kamailio5-mod-$(subst _,-,$(1))),)
    INCL_MODULES+=$(1)
    endif
  endef
  define Package/kamailio5-mod-$(subst _,-,$(1))/conffiles
$(subst $(space),$(newline),$(foreach c,$(6),/etc/kamailio/$(c)))
  endef
  define Package/kamailio5-mod-$(subst _,-,$(1))/install
$(call Package/kamailio5/install/module,$$(1),$(1))
$(foreach c,$(6),$(call Package/kamailio5/install/conffile,$$(1),$(c));)
$(foreach d,$(5),$(call Package/kamailio5/install/dbfiles,$$(1),$(d));)
  ifeq ($(1),snmpstats)
	$(INSTALL_DIR) $$(1)/usr/share/snmp/mibs
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/snmp/mibs/* \
					$$(1)/usr/share/snmp/mibs
  endif
  endef
$$(eval $$(call BuildPackage,kamailio5-mod-$(subst _,-,$(1))))
endef

TARGET_CPPFLAGS+=$(if $(CONFIG_PACKAGE_kamailio5-mod-app-python),-I$(STAGING_DIR)/usr/include/python$(PYTHON_VERSION))

# Kamailio always builds a baseline of packages. The "standard" group is
# the lightest baseline.

# "uid_gflags" is added to the list of modules to have at least one
# module that kicks off the build of the internal libsrdb2. The module
# has no other extra dependencies.
#
# The same is done with:
#   "ims_diameter_server" -> libkamailio_ims
#   "carrierroute" -> libtrie

# "lib_target" is specified in order for the modules to get a proper
# RPATH, as otherwise they would not find the internal libraries.

EXTRA_MODULES:= \
	$(if $(CONFIG_PACKAGE_kamailio5-mod-carrierroute),,carrierroute) \
	$(if $(CONFIG_PACKAGE_kamailio5-mod-ims-diameter-server),,ims_diameter_server) \
	$(if $(CONFIG_PACKAGE_kamailio5-mod-uid-gflags),,uid_gflags)

# MIPS tweak:
#
# Kamailio enables use of fast inline assembly locks when ARCH is set to
# "mips2". When ARCH is set to "mips" instead, Kamailio assumes it is dealing
# with an old 32-bit MIPS CPU without hardware locking support (like R3000).
#
# When CONFIG_CPU_TYPE matches one of the identifiers in the list below, set
# ARCH to "mips2" to get FAST_LOCK support.
ifeq ($(call qstrip,$(CONFIG_ARCH)),mips)
CPU_MIPS2:=mips32 24kc 34kc 74kc
endif

PKG_MAKE_ARGS:= \
	prefix=/ \
	cfg_dir=/etc/kamailio/ \
	bin_dir=/usr/sbin/ \
	data_dir=/usr/share/kamailio/ \
	lib_dir=/usr/lib/kamailio/ \
	modules_dir=/usr/lib/kamailio/ \
	group_include="standard" \
	include_modules="$$(INCL_MODULES) $(EXTRA_MODULES)" \
	cfg_target=/etc/kamailio/ \
	lib_target=/usr/lib/kamailio/ \
	run_target=/var/run/kamailio/ \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	LD_EXTRA_OPTS="$(TARGET_LDFLAGS)" \
	LOCALBASE="$(STAGING_DIR)/usr" \
	SYSBASE="$(STAGING_DIR)/usr" \
	CROSS_COMPILE=$(TARGET_CROSS) \
	CC="$(TARGET_CC)" \
	$(if $(findstring $(call qstrip,$(CONFIG_CPU_TYPE)),$(CPU_MIPS2)),ARCH="mips2",ARCH="$(ARCH)") \
	DESTDIR=$(PKG_INSTALL_DIR) \
	quiet=verbose

define Build/Configure
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) $(PKG_MAKE_ARGS) cfg
	$(MAKE) -C $(PKG_BUILD_DIR) quiet=verbose all
	$(MAKE) -C $(PKG_BUILD_DIR) quiet=verbose install
endef

$(eval $(call BuildPackage,kamailio5))
$(eval $(call BuildPackage,kamailio5-lib-libkamailio-ims))
$(eval $(call BuildPackage,kamailio5-lib-libtrie))
$(eval $(call BuildPackage,kamailio5-util-kambdb-recover))

################################
# Kamailio module parameters
# Params:
# 1 - Module name
# 2 - Module title
# 3 - Module description
# 4 - Dependencies
# 5 - Kamailio DB files
# 6 - Configuration files
################################

$(eval $(call BuildKamailio5Module,acc,Accounting,,+kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,acc_diameter,Accounting for DIAMETER backend,,+kamailio5-mod-acc))
$(eval $(call BuildKamailio5Module,acc_json,Accounting with records exported in JSON format,,+jansson +kamailio5-mod-acc))
$(eval $(call BuildKamailio5Module,alias_db,Database-backend aliases,,))
$(eval $(call BuildKamailio5Module,app_jsdt,Execute JavaScript scripts,,))
$(eval $(call BuildKamailio5Module,app_lua,Execute embedded Lua scripts,,+liblua))
$(eval $(call BuildKamailio5Module,app_python,Execute Python scripts,,+python-light))
$(eval $(call BuildKamailio5Module,app_python3,Python3 scripting interpreter,,@BROKEN +python3-light))
$(eval $(call BuildKamailio5Module,app_ruby,Ruby scripting interpreter,,+libruby))
$(eval $(call BuildKamailio5Module,app_sqlang,Execute Squirrel language scripts,,+libstdcpp))
$(eval $(call BuildKamailio5Module,async,Asynchronous SIP handling functions,,+kamailio5-mod-tm +kamailio5-mod-tmx))
$(eval $(call BuildKamailio5Module,auth,Authentication Framework,,))
$(eval $(call BuildKamailio5Module,auth_db,Database-backend authentication,,+kamailio5-mod-auth))
$(eval $(call BuildKamailio5Module,auth_diameter,Diameter authentication,,+kamailio5-mod-sl))
$(eval $(call BuildKamailio5Module,auth_ephemeral,Ephemeral credentials,,+libopenssl))
$(eval $(call BuildKamailio5Module,auth_identity,Identity authentication,,+libopenssl +libcurl))
$(eval $(call BuildKamailio5Module,auth_xkeys,Shared-key authentication,,+kamailio5-mod-auth))
$(eval $(call BuildKamailio5Module,avp,Functions for handling AVPs,,))
$(eval $(call BuildKamailio5Module,avpops,AVP operation,,))
$(eval $(call BuildKamailio5Module,benchmark,Config benchmark,,))
$(eval $(call BuildKamailio5Module,blst,Blacklisting API for config,,))
$(eval $(call BuildKamailio5Module,call_control,Call Control,,+kamailio5-mod-dialog +kamailio5-mod-pv))
$(eval $(call BuildKamailio5Module,call_obj,Call identification support,,))
$(eval $(call BuildKamailio5Module,carrierroute,Carrier Route,,+kamailio5-lib-libtrie))
$(eval $(call BuildKamailio5Module,cdp,C Diameter Peer,,))
$(eval $(call BuildKamailio5Module,cdp_avp,CDP AVP helper module,,+kamailio5-mod-cdp))
$(eval $(call BuildKamailio5Module,cfgutils,Config utilities,,))
$(eval $(call BuildKamailio5Module,cfg_db,Load parameters from database,,))
$(eval $(call BuildKamailio5Module,cfg_rpc,Update parameters via RPC,,))
$(eval $(call BuildKamailio5Module,cfgt,Unit test reporting,,))
$(eval $(call BuildKamailio5Module,cnxcc,Limit call duration,,+kamailio5-mod-dialog +libhiredis +libevent2))
$(eval $(call BuildKamailio5Module,corex,Legacy functions,,))
$(eval $(call BuildKamailio5Module,counters,Functions for counter manipulation,,))
$(eval $(call BuildKamailio5Module,cplc,Call Processing Language interpreter,,+kamailio5-mod-sl +kamailio5-mod-tm +kamailio5-mod-usrloc))
$(eval $(call BuildKamailio5Module,crypto,Various cryptography tools,,+libopenssl))
$(eval $(call BuildKamailio5Module,ctl,BINRPC transport interface,,))
$(eval $(call BuildKamailio5Module,db2_ldap,DBv2 LDAP module,,+libopenldap))
$(eval $(call BuildKamailio5Module,db2_ops,Run SQL queries from script,,))
$(eval $(call BuildKamailio5Module,db_berkeley,Berkeley DB backend,,+libdb47))
$(eval $(call BuildKamailio5Module,db_cluster,Database clustering system,,))
$(eval $(call BuildKamailio5Module,db_flatstore,fast write-only text DB-backend,,))
$(eval $(call BuildKamailio5Module,db_mysql,MySQL DB-backend,,+libmysqlclient,mysql))
$(eval $(call BuildKamailio5Module,db_postgres,PostgreSQL DB-backend,,+libpq,postgres))
$(eval $(call BuildKamailio5Module,db_redis,Database backend with Redis server,,+libhiredis,db_redis))
$(eval $(call BuildKamailio5Module,db_sqlite,SQLite DB-backend,,+libsqlite3,db_sqlite))
$(eval $(call BuildKamailio5Module,db_text,Text DB-backend,,,dbtext/kamailio))
$(eval $(call BuildKamailio5Module,db_unixodbc,UnixODBC DB-backend,,+unixodbc))
$(eval $(call BuildKamailio5Module,debugger,Interactive config file debugger,,))
$(eval $(call BuildKamailio5Module,dialog,Dialog support,,+kamailio5-mod-rr +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,dialplan,Dialplan management,,+libpcre))
$(eval $(call BuildKamailio5Module,dispatcher,Dispatcher,,))
$(eval $(call BuildKamailio5Module,diversion,Diversion header insertion,,))
$(eval $(call BuildKamailio5Module,dmq,Distributed Message Queue,,+kamailio5-mod-sl +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,dmq_usrloc,DMQ USRLOC replication,,+kamailio5-mod-dmq +kamailio5-mod-usrloc))
$(eval $(call BuildKamailio5Module,domain,Multi-domain support,,))
$(eval $(call BuildKamailio5Module,domainpolicy,Domain policy,,))
$(eval $(call BuildKamailio5Module,drouting,Dynamic routing module,,))
$(eval $(call BuildKamailio5Module,enum,ENUM lookup,,))
$(eval $(call BuildKamailio5Module,erlang,Erlang node connector module,,@!USE_MUSL +erlang))
$(eval $(call BuildKamailio5Module,evapi,push event details via tcp,,+libev))
$(eval $(call BuildKamailio5Module,evrexec,Execut event routes at startup,,))
$(eval $(call BuildKamailio5Module,exec,External exec,,))
$(eval $(call BuildKamailio5Module,group,Database-backend user-groups,,))
$(eval $(call BuildKamailio5Module,gzcompress,Compress SIP messages,,+zlib))
$(eval $(call BuildKamailio5Module,h350,H.350,,+kamailio5-mod-ldap +libopenldap))
$(eval $(call BuildKamailio5Module,htable,Hash Table,,))
$(eval $(call BuildKamailio5Module,http_client,HTTP client using CURL,,+libcurl))
$(eval $(call BuildKamailio5Module,imc,IM conferencing,,+kamailio5-mod-db-mysql +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,ims_auth,IMS authentication module,,+kamailio5-lib-libkamailio-ims +kamailio5-mod-cdp +kamailio5-mod-cdp-avp +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,ims_charging,IMS charging component module,,+kamailio5-lib-libkamailio-ims +kamailio5-mod-cdp +kamailio5-mod-cdp-avp +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,ims_dialog,IMS dialog tracking module,,+kamailio5-mod-rr +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,ims_diameter_server,IMS DIAMETER server module,,+kamailio5-lib-libkamailio-ims +kamailio5-mod-cdp +kamailio5-mod-cdp-avp))
$(eval $(call BuildKamailio5Module,ims_icscf,IMS ICSCF component module,,+kamailio5-lib-libkamailio-ims +kamailio5-mod-cdp +kamailio5-mod-cdp-avp +kamailio5-mod-sl +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,ims_ipsec_pcscf,Diameter server implementation,,+kamailio5-lib-libkamailio-ims +kamailio5-mod-ims-usrloc-pcscf +kamailio5-mod-tm +libmnl))
$(eval $(call BuildKamailio5Module,ims_isc,IMS ISC component module,,+kamailio5-lib-libkamailio-ims +kamailio5-mod-ims-usrloc-scscf +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,ims_ocs,MS OCS component module,,+kamailio5-lib-libkamailio-ims +kamailio5-mod-cdp +kamailio5-mod-cdp-avp))
$(eval $(call BuildKamailio5Module,ims_qos,IMS Diameter Rx interface between PCSCF and PCRF functions,,+kamailio5-lib-libkamailio-ims +kamailio5-mod-cdp +kamailio5-mod-cdp-avp +kamailio5-mod-ims-dialog +kamailio5-mod-ims-usrloc-pcscf +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,ims_registrar_pcscf,MS PCSCF registrar module,,+kamailio5-lib-libkamailio-ims +kamailio5-mod-ims-usrloc-pcscf))
$(eval $(call BuildKamailio5Module,ims_registrar_scscf,IMS SCSCF registrar module,,+kamailio5-lib-libkamailio-ims +kamailio5-mod-cdp +kamailio5-mod-cdp-avp +kamailio5-mod-ims-usrloc-scscf +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,ims_usrloc_pcscf,IMS PCSCF usrloc module,,))
$(eval $(call BuildKamailio5Module,ims_usrloc_scscf,IMS SCSCF usrloc module,,))
$(eval $(call BuildKamailio5Module,ipops,IP and IPv6 operations,,))
$(eval $(call BuildKamailio5Module,jansson,Access to JSON attributes,,+jansson))
$(eval $(call BuildKamailio5Module,janssonrpcc,Alternative JSONRPC server,,+kamailio5-mod-jansson +libevent2))
$(eval $(call BuildKamailio5Module,json,Access to JSON document attributes,,+libjson-c))
$(eval $(call BuildKamailio5Module,jsonrpcs,JSONRPC server over HTTP,,+libevent2))
$(eval $(call BuildKamailio5Module,keepalive,SIP keepalive monitoring,+kamailio5-mod-tm,))
$(eval $(call BuildKamailio5Module,kex,Core extensions,,))
$(eval $(call BuildKamailio5Module,lcr,Least Cost Routing,,+kamailio5-mod-tm +libpcre))
$(eval $(call BuildKamailio5Module,ldap,LDAP connector,,+libopenldap))
$(eval $(call BuildKamailio5Module,log_custom,Logging to custom backends,,))
$(eval $(call BuildKamailio5Module,mangler,SDP mangling,,))
$(eval $(call BuildKamailio5Module,matrix,Matrix operations,,))
$(eval $(call BuildKamailio5Module,maxfwd,Max-Forward processor,,))
$(eval $(call BuildKamailio5Module,mediaproxy,Automatic NAT traversal,,+kamailio5-mod-dialog))
$(eval $(call BuildKamailio5Module,mohqueue,Music on hold queuing system,,+kamailio5-mod-rtpproxy +kamailio5-mod-sl +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,mqueue,Generic message queue system,,))
$(eval $(call BuildKamailio5Module,msilo,SIP message silo,,+kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,msrp,MSRP routing engine,,+kamailio5-mod-tls))
$(eval $(call BuildKamailio5Module,mtree,Memory caching system,,))
$(eval $(call BuildKamailio5Module,nathelper,NAT helper,,+kamailio5-mod-usrloc))
$(eval $(call BuildKamailio5Module,nat_traversal,NAT traversal,,+kamailio5-mod-dialog +kamailio5-mod-sl +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,ndb_redis,Connect to REDIS NoSQL,,+libhiredis))
$(eval $(call BuildKamailio5Module,nosip,non-sip package handling,,+kamailio5-mod-rr))
$(eval $(call BuildKamailio5Module,outbound,SIP Outbound implementation,,+kamailio5-mod-stun +libopenssl))
$(eval $(call BuildKamailio5Module,p_usrloc,Partitioned USRLOC services,,))
$(eval $(call BuildKamailio5Module,path,SIP path insertion,,+kamailio5-mod-rr))
$(eval $(call BuildKamailio5Module,pdb,Number portability module,,))
$(eval $(call BuildKamailio5Module,pdt,Prefix-to-Domain translator,,))
$(eval $(call BuildKamailio5Module,permissions,Permissions control,,))
$(eval $(call BuildKamailio5Module,pike,Flood detector,,))
$(eval $(call BuildKamailio5Module,pipelimit,Traffic shaping policies,,+kamailio5-mod-sl))
$(eval $(call BuildKamailio5Module,prefix_route,Execute based on prefix,,))
$(eval $(call BuildKamailio5Module,presence,Presence server,,+kamailio5-mod-sl +kamailio5-mod-tm +libxml2))
$(eval $(call BuildKamailio5Module,presence_conference,Conference events,,+kamailio5-mod-presence))
$(eval $(call BuildKamailio5Module,presence_dialoginfo,Dialog Event presence,,+kamailio5-mod-presence))
$(eval $(call BuildKamailio5Module,presence_mwi,MWI presence,,+kamailio5-mod-presence))
$(eval $(call BuildKamailio5Module,presence_profile,User profile extensions,,+kamailio5-mod-presence))
$(eval $(call BuildKamailio5Module,presence_reginfo,Registration info,,+kamailio5-mod-presence))
$(eval $(call BuildKamailio5Module,presence_xml,XCAP presence,,+kamailio5-mod-presence +kamailio5-mod-xcap-client))
$(eval $(call BuildKamailio5Module,pua,Presence User Agent,,+kamailio5-mod-tm +libxml2))
$(eval $(call BuildKamailio5Module,pua_bla,Bridged Line Appearence PUA,,+kamailio5-mod-presence +kamailio5-mod-pua +kamailio5-mod-usrloc))
$(eval $(call BuildKamailio5Module,pua_dialoginfo,Dialog Event PUA,,+kamailio5-mod-dialog +kamailio5-mod-pua))
$(eval $(call BuildKamailio5Module,pua_json,Presence user agent implementation with JSON messages,,+libjson-c))
$(eval $(call BuildKamailio5Module,pua_reginfo,PUA registration info,,+kamailio5-mod-pua +kamailio5-mod-usrloc))
$(eval $(call BuildKamailio5Module,pua_rpc,RPC extensions for PUA,,+kamailio5-mod-pua))
$(eval $(call BuildKamailio5Module,pua_usrloc,PUA User Location,,+kamailio5-mod-pua +kamailio5-mod-usrloc))
$(eval $(call BuildKamailio5Module,pua_xmpp,PUA XMPP,,+kamailio5-mod-presence +kamailio5-mod-pua +kamailio5-mod-xmpp))
$(eval $(call BuildKamailio5Module,pv,Pseudo-Variables,,))
$(eval $(call BuildKamailio5Module,qos,QoS control,,+kamailio5-mod-dialog))
$(eval $(call BuildKamailio5Module,ratelimit,Traffic shapping,,))
$(eval $(call BuildKamailio5Module,regex,Regular Expression,,+libpcre))
$(eval $(call BuildKamailio5Module,registrar,SIP Registrar,,+kamailio5-mod-usrloc))
$(eval $(call BuildKamailio5Module,rls,Resource List Server,,+kamailio5-mod-presence +kamailio5-mod-pua +kamailio5-mod-tm +libxml2))
$(eval $(call BuildKamailio5Module,rr,Record-Route and Route,,))
$(eval $(call BuildKamailio5Module,rtimer,Routing Timer,,))
$(eval $(call BuildKamailio5Module,rtjson,SIP routing based on JSON API,,))
$(eval $(call BuildKamailio5Module,rtpengine,RTP engine,,+kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,rtpproxy,RTP proxy,,+kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,sanity,SIP sanity checks,,+kamailio5-mod-sl))
$(eval $(call BuildKamailio5Module,sca,Shared Call Appearances,,+kamailio5-mod-sl +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,sctp,SCTP support,,+libsctp))
$(eval $(call BuildKamailio5Module,sdpops,Managing SDP payloads,,))
$(eval $(call BuildKamailio5Module,seas,Sip Express Application Server,,+kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,sipcapture,SIP capture,,))
$(eval $(call BuildKamailio5Module,sipdump,Save SIP traffic,,))
$(eval $(call BuildKamailio5Module,sipt,SIP-T and SIP-I operations,,))
$(eval $(call BuildKamailio5Module,siptrace,SIP trace,,))
$(eval $(call BuildKamailio5Module,siputils,SIP utilities,,+kamailio5-mod-sl))
$(eval $(call BuildKamailio5Module,sl,Stateless replier,,))
$(eval $(call BuildKamailio5Module,sms,SIP-to-SMS IM gateway,,+kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,smsops,Handle SMS packets in SIP,,))
$(eval $(call BuildKamailio5Module,snmpstats,SNMP interface for statistics,,+libnetsnmp))
$(eval $(call BuildKamailio5Module,speeddial,Per-user speed-dial controller,,))
$(eval $(call BuildKamailio5Module,sqlops,SQL operations,,))
$(eval $(call BuildKamailio5Module,ss7ops,JSON Operations for SS7 over HEP,,))
$(eval $(call BuildKamailio5Module,statistics,Script statistics,,))
$(eval $(call BuildKamailio5Module,statsc,Statistics collector,,))
$(eval $(call BuildKamailio5Module,statsd,Connector for statsd application,,))
$(eval $(call BuildKamailio5Module,stun,STUN server support,,))
$(eval $(call BuildKamailio5Module,sst,SIP Session Timer,,+kamailio5-mod-dialog +kamailio5-mod-sl))
$(eval $(call BuildKamailio5Module,tcpops,TCP options tweaking operations,,))
$(eval $(call BuildKamailio5Module,textops,Text operations,,))
$(eval $(call BuildKamailio5Module,textopsx,Extra text operations,,))
$(eval $(call BuildKamailio5Module,timer,Execute routing blocks on core timers,,))
$(eval $(call BuildKamailio5Module,tls,TLS operations,,+libopenssl,,tls.cfg))
$(eval $(call BuildKamailio5Module,tmrec,Match time recurrences,,))
$(eval $(call BuildKamailio5Module,topoh,Topology hiding,,+kamailio5-mod-rr))
$(eval $(call BuildKamailio5Module,topos,Topology stripping module,,+kamailio5-mod-rr))
$(eval $(call BuildKamailio5Module,topos_redis,Redis backend for topos module,,+kamailio5-mod-ndb-redis +kamailio5-mod-topos))
$(eval $(call BuildKamailio5Module,tm,Transaction,,))
$(eval $(call BuildKamailio5Module,tmx,Transaction module extensions,,))
$(eval $(call BuildKamailio5Module,tsilo,Transaction storage,,+kamailio5-mod-registrar +kamailio5-mod-sl +kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,uac,User Agent Client,,+kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,uac_redirect,User Agent Client redirection,,+kamailio5-mod-tm))
$(eval $(call BuildKamailio5Module,uid_auth_db,Authentication module,,+kamailio5-mod-auth))
$(eval $(call BuildKamailio5Module,uid_avp_db,AVP database operations,,))
$(eval $(call BuildKamailio5Module,uid_domain,Domains management,,))
$(eval $(call BuildKamailio5Module,uid_gflags,Global attributes and flags,,))
$(eval $(call BuildKamailio5Module,uid_uri_db,Database URI operations,,))
$(eval $(call BuildKamailio5Module,uri_db,Database-backend SIP URI checking,,))
$(eval $(call BuildKamailio5Module,userblacklist,User blacklists,,+kamailio5-lib-libtrie))
$(eval $(call BuildKamailio5Module,usrloc,User location,,))
$(eval $(call BuildKamailio5Module,utils,Misc utilities,,+libcurl +libxml2))
$(eval $(call BuildKamailio5Module,uuid,UUID utilities,,+libuuid))
$(eval $(call BuildKamailio5Module,websocket,WebSocket transport layer,,+kamailio5-mod-sl +kamailio5-mod-tm +libopenssl +libunistring))
$(eval $(call BuildKamailio5Module,xcap_client,XCAP Client,,+libcurl))
$(eval $(call BuildKamailio5Module,xcap_server,XCAP server implementation,,+kamailio5-mod-xhttp +kamailio5-mod-sl))
$(eval $(call BuildKamailio5Module,xhttp,Basic HTTP request handling server,,+kamailio5-mod-sl))
$(eval $(call BuildKamailio5Module,xhttp_pi,HTTP provisioning interface,,+kamailio5-mod-xhttp,xhttp_pi,pi_framework.xml))
$(eval $(call BuildKamailio5Module,xhttp_rpc,RPC commands handling over HTTP,,+kamailio5-mod-xhttp))
$(eval $(call BuildKamailio5Module,xlog,Advanced logger,,))
$(eval $(call BuildKamailio5Module,xmlops,XML operations,,))
$(eval $(call BuildKamailio5Module,xmlrpc,XML RPC module,,+libxml2))
$(eval $(call BuildKamailio5Module,xmpp,SIP-to-XMPP Gateway,,+kamailio5-mod-tm +libexpat))
$(eval $(call BuildKamailio5Module,xprint,Print messages with specifiers,,))
