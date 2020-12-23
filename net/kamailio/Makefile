#
# Copyright (C) 2017 OpenWrt.org
# Copyright (C) 2017 Jiri Slachta
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kamailio
PKG_VERSION:=5.4.2
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://www.kamailio.org/pub/kamailio/$(PKG_VERSION)/src
PKG_SOURCE:=kamailio-$(PKG_VERSION)_src.tar.gz
PKG_HASH:=e710824d6810d3053ec79a39ee532c51bb91738a07f16c3a103aa07e0f8b80b5
PKG_USE_MIPS16:=0

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_INSTALL:=1

PKG_BUILD_PARALLEL:=1

MODULES_AVAILABLE:= \
	acc \
	acc_diameter \
	acc_json \
	alias_db \
	app_jsdt \
	app_lua \
	app_lua_sr \
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
	dlgs \
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
	kemix \
	kex \
	lcr \
	ldap \
	log_custom \
	lost \
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
	pv_headers \
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
	secfilter \
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
	xhttp_prom \
	xhttp_rpc \
	xlog \
	xmlops \
	xmlrpc \
	xmpp \
	xprint

PKG_CONFIG_DEPENDS:= \
	$(patsubst %,CONFIG_PACKAGE_kamailio-mod-%,$(subst _,-,$(MODULES_AVAILABLE)))

include $(INCLUDE_DIR)/nls.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-version.mk

# Build reproducibly
TARGET_CFLAGS += -DVERSION_NODATE=1

PREBUILT_STAMP=$(STAGING_DIR)/stamp/.kamailio_prebuilt
TAR_CMD:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components 1 $(TAR_OPTIONS)

INCL_MODULES:=

define Package/kamailio/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  URL:=http://www.kamailio.org/
  DEPENDS:=$(ICONV_DEPENDS) +libncurses +libpthread +libreadline +libxml2
endef

define Package/kamailio
$(call Package/kamailio/Default)
  TITLE:=Mature and flexible open source SIP server, v$(PKG_VERSION)
  USERID:=kamailio=380:kamailio=380
  MENU:=1
endef

define Package/kamailio/conffiles
/etc/config/kamailio
/etc/init.d/kamailio
/etc/kamailio/kamailio.cfg
/etc/kamailio/kamctlrc
endef

define Package/kamailio/install
$(foreach c,kamailio.cfg kamctlrc,$(call Package/kamailio/install/conffile,$(1),$(c));)
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/sbin/kam{ailio,cmd,ctl,dbctl} \
		$(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/lib/kamailio/modules
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/kamailio/lib{srdb1,srdb2}.so* \
		$(1)/usr/lib/kamailio/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) \
		./files/kamailio.conf \
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

define Package/kamailio/postinst
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

define Package/kamailio/install/conffile
	$(INSTALL_DIR) $(1)/etc/kamailio
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/kamailio/$(2) $(1)/etc/kamailio
endef

define Package/kamailio/install/dbfiles
	$(INSTALL_DIR) $(1)/usr/share/kamailio/$(2)
	$(CP) $(PKG_INSTALL_DIR)/usr/share/kamailio/$(2)/* $(1)/usr/share/kamailio/$(2)/
endef

define Package/kamailio/install/module
	$(INSTALL_DIR) $(1)/usr/lib/kamailio/modules
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/kamailio/modules/$(2).so* $(1)/usr/lib/kamailio/modules/
endef

define Package/kamailio-lib-libkamailio-ims
$(call Package/kamailio/Default)
  TITLE:=Kamailio IMS library
  DEPENDS:=kamailio
endef

define Package/kamailio-lib-libkamailio-ims/install
	$(INSTALL_DIR) $(1)/usr/lib/kamailio
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/kamailio/libkamailio_ims.so* \
						$(1)/usr/lib/kamailio
endef

define Package/kamailio-lib-libtrie
$(call Package/kamailio/Default)
  TITLE:=Kamailio digital tree library
  DEPENDS:=kamailio
endef

define Package/kamailio-lib-libtrie/install
	$(INSTALL_DIR) $(1)/usr/lib/kamailio
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/kamailio/libtrie.so* \
					$(1)/usr/lib/kamailio
endef

define Package/kamailio-util-kambdb-recover
$(call Package/kamailio/Default)
  TITLE:=Kamailio Berkeley DB recovery utility
  DEPENDS:=kamailio +PACKAGE_kamailio-util-kambdb-recover:kamailio-mod-db-berkeley
endef

define Package/kamailio-util-kambdb-recover/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/kambdb_recover $(1)/usr/sbin
endef

define BuildKamailioModule
  define Package/kamailio-mod-$(subst _,-,$(1))
    $$(call Package/kamailio/Default)
    TITLE:=$(2) for Kamailio
    DEPENDS:=kamailio $(patsubst +%,+PACKAGE_kamailio-mod-$(subst _,-,$(1)):%,$(4))
    ifneq ($$(CONFIG_PACKAGE_kamailio-mod-$(subst _,-,$(1))),)
    INCL_MODULES+=$(1)
    endif
  endef
  define Package/kamailio-mod-$(subst _,-,$(1))/conffiles
$(subst $(space),$(newline),$(foreach c,$(6),/etc/kamailio/$(c)))
  endef
  define Package/kamailio-mod-$(subst _,-,$(1))/install
$(call Package/kamailio/install/module,$$(1),$(1))
$(foreach c,$(6),$(call Package/kamailio/install/conffile,$$(1),$(c));)
$(foreach d,$(5),$(call Package/kamailio/install/dbfiles,$$(1),$(d));)
  ifeq ($(1),snmpstats)
	$(INSTALL_DIR) $$(1)/usr/share/snmp/mibs
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/snmp/mibs/* \
					$$(1)/usr/share/snmp/mibs
  endif
  endef
$$(eval $$(call BuildPackage,kamailio-mod-$(subst _,-,$(1))))
endef

# Kamailio always builds a baseline of packages. The "standard" group is
# the lightest baseline.

# "uid_gflags" is added to the list of modules to have at least one
# module that kicks off the build of the internal libsrdb2. The module
# has no other extra dependencies.
#
# The same is done with:
#   "ims_diameter_server" -> libkamailio_ims
#   "carrierroute" -> libtrie

EXTRA_MODULES:= \
	$(if $(CONFIG_PACKAGE_kamailio-mod-carrierroute),,carrierroute) \
	$(if $(CONFIG_PACKAGE_kamailio-mod-ims-diameter-server),,ims_diameter_server) \
	$(if $(CONFIG_PACKAGE_kamailio-mod-uid-gflags),,uid_gflags)

# MIPS tweak:
#
# Kamailio enables use of fast inline assembly locks when ARCH is set to
# "mips2". When ARCH is set to "mips" instead, Kamailio assumes it is dealing
# with an old 32-bit MIPS CPU without hardware locking support (like R3000).
#
# When CONFIG_CPU_TYPE matches one of the identifiers in the list below, set
# ARCH to "mips2" to get FAST_LOCK support.
ifeq ($(call qstrip,$(CONFIG_ARCH)),mips)
CPU_MIPS2:=mips32 24kc 34kc 4kec 74kc
endif

MAKE_FLAGS += \
	$(if $(findstring $(call qstrip,$(CONFIG_CPU_TYPE)),$(CPU_MIPS2)),ARCH="mips2",ARCH="$(ARCH)") \
	CC_EXTRA_OPTS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	LD="$(TARGET_CC)" \
	LD_EXTRA_OPTS="$(TARGET_LDFLAGS)" \
	LIBDIR=lib \
	PREFIX=/usr \
	cfg_prefix="$(PKG_INSTALL_DIR)" \
	cfg_target=/etc/kamailio \
	group_include="standard" \
	include_modules="$$(INCL_MODULES) $(EXTRA_MODULES)" \
	quiet=verbose \
	run_prefix=""

MAKE_VARS += \
	PYTHON3=python$(PYTHON3_VERSION)

define Build/Prepare
	$(call Build/Prepare/Default)
	# Upstream adds "-funroll-loops" to compiler flags, which increases
	# binary size significantly. Remove this flag.
	$(SED) 's/[ ]*-funroll-loops//' $(PKG_BUILD_DIR)/src/Makefile.defs
endef

define Build/Configure
endef

define Build/Compile
	$(call Build/Compile/Default,cfg)
	$(call Build/Compile/Default,all)
endef

$(eval $(call BuildPackage,kamailio))
$(eval $(call BuildPackage,kamailio-lib-libkamailio-ims))
$(eval $(call BuildPackage,kamailio-lib-libtrie))
$(eval $(call BuildPackage,kamailio-util-kambdb-recover))

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

$(eval $(call BuildKamailioModule,acc,Accounting,,+kamailio-mod-tm))
$(eval $(call BuildKamailioModule,acc_diameter,Accounting for DIAMETER backend,,+kamailio-mod-acc))
$(eval $(call BuildKamailioModule,acc_json,Accounting with records exported in JSON format,,+jansson +kamailio-mod-acc))
$(eval $(call BuildKamailioModule,alias_db,Database-backend aliases,,))
$(eval $(call BuildKamailioModule,app_jsdt,Execute JavaScript scripts,,))
$(eval $(call BuildKamailioModule,app_lua,Execute embedded Lua scripts,,+liblua))
$(eval $(call BuildKamailioModule,app_lua_sr,Old Lua API,,+kamailio-mod-app-lua,))
$(eval $(call BuildKamailioModule,app_python3,Python3 scripting interpreter,,+python3-light))
$(eval $(call BuildKamailioModule,app_ruby,Ruby scripting interpreter,,+libruby))
$(eval $(call BuildKamailioModule,app_sqlang,Execute Squirrel language scripts,,+libstdcpp))
$(eval $(call BuildKamailioModule,async,Asynchronous SIP handling functions,,+kamailio-mod-tm +kamailio-mod-tmx))
$(eval $(call BuildKamailioModule,auth,Authentication Framework,,))
$(eval $(call BuildKamailioModule,auth_db,Database-backend authentication,,+kamailio-mod-auth))
$(eval $(call BuildKamailioModule,auth_diameter,Diameter authentication,,+kamailio-mod-sl))
$(eval $(call BuildKamailioModule,auth_ephemeral,Ephemeral credentials,,+libopenssl))
$(eval $(call BuildKamailioModule,auth_identity,Identity authentication,,+libopenssl +libcurl))
$(eval $(call BuildKamailioModule,auth_xkeys,Shared-key authentication,,+kamailio-mod-auth))
$(eval $(call BuildKamailioModule,avp,Functions for handling AVPs,,))
$(eval $(call BuildKamailioModule,avpops,AVP operation,,))
$(eval $(call BuildKamailioModule,benchmark,Config benchmark,,))
$(eval $(call BuildKamailioModule,blst,Blacklisting API for config,,))
$(eval $(call BuildKamailioModule,call_control,Call Control,,+kamailio-mod-dialog +kamailio-mod-pv))
$(eval $(call BuildKamailioModule,call_obj,Call identification support,,))
$(eval $(call BuildKamailioModule,carrierroute,Carrier Route,,+kamailio-lib-libtrie))
$(eval $(call BuildKamailioModule,cdp,C Diameter Peer,,))
$(eval $(call BuildKamailioModule,cdp_avp,CDP AVP helper module,,+kamailio-mod-cdp))
$(eval $(call BuildKamailioModule,cfgutils,Config utilities,,))
$(eval $(call BuildKamailioModule,cfg_db,Load parameters from database,,))
$(eval $(call BuildKamailioModule,cfg_rpc,Update parameters via RPC,,))
$(eval $(call BuildKamailioModule,cfgt,Unit test reporting,,))
$(eval $(call BuildKamailioModule,cnxcc,Limit call duration,,+kamailio-mod-dialog +libhiredis +libevent2))
$(eval $(call BuildKamailioModule,corex,Legacy functions,,))
$(eval $(call BuildKamailioModule,counters,Functions for counter manipulation,,))
$(eval $(call BuildKamailioModule,cplc,Call Processing Language interpreter,,+kamailio-mod-sl +kamailio-mod-tm +kamailio-mod-usrloc))
$(eval $(call BuildKamailioModule,crypto,Various cryptography tools,,+libopenssl))
$(eval $(call BuildKamailioModule,ctl,BINRPC transport interface,,))
$(eval $(call BuildKamailioModule,db2_ldap,DBv2 LDAP module,,+libopenldap))
$(eval $(call BuildKamailioModule,db2_ops,Run SQL queries from script,,))
$(eval $(call BuildKamailioModule,db_berkeley,Berkeley DB backend,,+libdb47))
$(eval $(call BuildKamailioModule,db_cluster,Database clustering system,,))
$(eval $(call BuildKamailioModule,db_flatstore,fast write-only text DB-backend,,))
$(eval $(call BuildKamailioModule,db_mysql,MySQL DB-backend,,+libmysqlclient,mysql))
$(eval $(call BuildKamailioModule,db_postgres,PostgreSQL DB-backend,,+libpq,postgres))
$(eval $(call BuildKamailioModule,db_redis,Database backend with Redis server,,+libhiredis,db_redis))
$(eval $(call BuildKamailioModule,db_sqlite,SQLite DB-backend,,+libsqlite3,db_sqlite))
$(eval $(call BuildKamailioModule,db_text,Text DB-backend,,,dbtext/kamailio))
$(eval $(call BuildKamailioModule,db_unixodbc,UnixODBC DB-backend,,+unixodbc))
$(eval $(call BuildKamailioModule,debugger,Interactive config file debugger,,))
$(eval $(call BuildKamailioModule,dialog,Dialog support,,+kamailio-mod-rr +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,dialplan,Dialplan management,,+libpcre))
$(eval $(call BuildKamailioModule,dispatcher,Dispatcher,,))
$(eval $(call BuildKamailioModule,diversion,Diversion header insertion,,))
$(eval $(call BuildKamailioModule,dlgs,Track active calls in stateless mode,,))
$(eval $(call BuildKamailioModule,dmq,Distributed Message Queue,,+kamailio-mod-sl +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,dmq_usrloc,DMQ USRLOC replication,,+kamailio-mod-dmq +kamailio-mod-usrloc))
$(eval $(call BuildKamailioModule,domain,Multi-domain support,,))
$(eval $(call BuildKamailioModule,domainpolicy,Domain policy,,))
$(eval $(call BuildKamailioModule,drouting,Dynamic routing module,,))
$(eval $(call BuildKamailioModule,enum,ENUM lookup,,))
$(eval $(call BuildKamailioModule,erlang,Erlang node connector module,,@!USE_MUSL +erlang))
$(eval $(call BuildKamailioModule,evapi,push event details via tcp,,+libev))
$(eval $(call BuildKamailioModule,evrexec,Execut event routes at startup,,))
$(eval $(call BuildKamailioModule,exec,External exec,,))
$(eval $(call BuildKamailioModule,group,Database-backend user-groups,,))
$(eval $(call BuildKamailioModule,gzcompress,Compress SIP messages,,+zlib))
$(eval $(call BuildKamailioModule,h350,H.350,,+kamailio-mod-ldap +libopenldap))
$(eval $(call BuildKamailioModule,htable,Hash Table,,))
$(eval $(call BuildKamailioModule,http_client,HTTP client using CURL,,+libcurl))
$(eval $(call BuildKamailioModule,imc,IM conferencing,,+kamailio-mod-db-mysql +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,ims_auth,IMS authentication module,,+kamailio-lib-libkamailio-ims +kamailio-mod-cdp +kamailio-mod-cdp-avp +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,ims_charging,IMS charging component module,,+kamailio-lib-libkamailio-ims +kamailio-mod-cdp +kamailio-mod-cdp-avp +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,ims_dialog,IMS dialog tracking module,,+kamailio-mod-rr +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,ims_diameter_server,IMS DIAMETER server module,,+kamailio-lib-libkamailio-ims +kamailio-mod-cdp +kamailio-mod-cdp-avp))
$(eval $(call BuildKamailioModule,ims_icscf,IMS ICSCF component module,,+kamailio-lib-libkamailio-ims +kamailio-mod-cdp +kamailio-mod-cdp-avp +kamailio-mod-sl +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,ims_ipsec_pcscf,Diameter server implementation,,+kamailio-lib-libkamailio-ims +kamailio-mod-ims-usrloc-pcscf +kamailio-mod-tm +libmnl))
$(eval $(call BuildKamailioModule,ims_isc,IMS ISC component module,,+kamailio-lib-libkamailio-ims +kamailio-mod-ims-usrloc-scscf +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,ims_ocs,MS OCS component module,,+kamailio-lib-libkamailio-ims +kamailio-mod-cdp +kamailio-mod-cdp-avp))
$(eval $(call BuildKamailioModule,ims_qos,IMS Diameter Rx interface between PCSCF and PCRF functions,,+kamailio-lib-libkamailio-ims +kamailio-mod-cdp +kamailio-mod-cdp-avp +kamailio-mod-ims-dialog +kamailio-mod-ims-usrloc-pcscf +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,ims_registrar_pcscf,MS PCSCF registrar module,,+kamailio-lib-libkamailio-ims +kamailio-mod-ims-usrloc-pcscf))
$(eval $(call BuildKamailioModule,ims_registrar_scscf,IMS SCSCF registrar module,,+kamailio-lib-libkamailio-ims +kamailio-mod-cdp +kamailio-mod-cdp-avp +kamailio-mod-ims-usrloc-scscf +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,ims_usrloc_pcscf,IMS PCSCF usrloc module,,))
$(eval $(call BuildKamailioModule,ims_usrloc_scscf,IMS SCSCF usrloc module,,))
$(eval $(call BuildKamailioModule,ipops,IP and IPv6 operations,,))
$(eval $(call BuildKamailioModule,jansson,Access to JSON attributes,,+jansson))
$(eval $(call BuildKamailioModule,janssonrpcc,Alternative JSONRPC server,,+kamailio-mod-jansson +libevent2))
$(eval $(call BuildKamailioModule,json,Access to JSON document attributes,,+libjson-c))
$(eval $(call BuildKamailioModule,jsonrpcs,JSONRPC server over HTTP,,+libevent2))
$(eval $(call BuildKamailioModule,keepalive,SIP keepalive monitoring,+kamailio-mod-tm,))
$(eval $(call BuildKamailioModule,kemix,KEMI extensions,,,))
$(eval $(call BuildKamailioModule,kex,Core extensions,,))
$(eval $(call BuildKamailioModule,lcr,Least Cost Routing,,+kamailio-mod-tm +libpcre))
$(eval $(call BuildKamailioModule,ldap,LDAP connector,,+libopenldap))
$(eval $(call BuildKamailioModule,log_custom,Logging to custom backends,,))
$(eval $(call BuildKamailioModule,lost,HELD and LOST routing,,+kamailio-mod-http-client,))
$(eval $(call BuildKamailioModule,mangler,SDP mangling,,))
$(eval $(call BuildKamailioModule,matrix,Matrix operations,,))
$(eval $(call BuildKamailioModule,maxfwd,Max-Forward processor,,))
$(eval $(call BuildKamailioModule,mediaproxy,Automatic NAT traversal,,+kamailio-mod-dialog))
$(eval $(call BuildKamailioModule,mohqueue,Music on hold queuing system,,+kamailio-mod-rtpproxy +kamailio-mod-sl +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,mqueue,Generic message queue system,,))
$(eval $(call BuildKamailioModule,msilo,SIP message silo,,+kamailio-mod-tm))
$(eval $(call BuildKamailioModule,msrp,MSRP routing engine,,+kamailio-mod-tls))
$(eval $(call BuildKamailioModule,mtree,Memory caching system,,))
$(eval $(call BuildKamailioModule,nathelper,NAT helper,,+kamailio-mod-usrloc))
$(eval $(call BuildKamailioModule,nat_traversal,NAT traversal,,+kamailio-mod-dialog +kamailio-mod-sl +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,ndb_redis,Connect to REDIS NoSQL,,+libhiredis))
$(eval $(call BuildKamailioModule,nosip,non-sip package handling,,+kamailio-mod-rr))
$(eval $(call BuildKamailioModule,outbound,SIP Outbound implementation,,+kamailio-mod-stun +libopenssl))
$(eval $(call BuildKamailioModule,p_usrloc,Partitioned USRLOC services,,))
$(eval $(call BuildKamailioModule,path,SIP path insertion,,+kamailio-mod-rr))
$(eval $(call BuildKamailioModule,pdb,Number portability module,,))
$(eval $(call BuildKamailioModule,pdt,Prefix-to-Domain translator,,))
$(eval $(call BuildKamailioModule,permissions,Permissions control,,))
$(eval $(call BuildKamailioModule,pike,Flood detector,,))
$(eval $(call BuildKamailioModule,pipelimit,Traffic shaping policies,,+kamailio-mod-sl))
$(eval $(call BuildKamailioModule,prefix_route,Execute based on prefix,,))
$(eval $(call BuildKamailioModule,presence,Presence server,,+kamailio-mod-sl +kamailio-mod-tm,))
$(eval $(call BuildKamailioModule,presence_conference,Conference events,,+kamailio-mod-presence))
$(eval $(call BuildKamailioModule,presence_dialoginfo,Dialog Event presence,,+kamailio-mod-presence))
$(eval $(call BuildKamailioModule,presence_mwi,MWI presence,,+kamailio-mod-presence))
$(eval $(call BuildKamailioModule,presence_profile,User profile extensions,,+kamailio-mod-presence))
$(eval $(call BuildKamailioModule,presence_reginfo,Registration info,,+kamailio-mod-presence))
$(eval $(call BuildKamailioModule,presence_xml,XCAP presence,,+kamailio-mod-presence +kamailio-mod-xcap-client))
$(eval $(call BuildKamailioModule,pua,Presence User Agent,,+kamailio-mod-tm,))
$(eval $(call BuildKamailioModule,pua_bla,Bridged Line Appearence PUA,,+kamailio-mod-presence +kamailio-mod-pua +kamailio-mod-usrloc))
$(eval $(call BuildKamailioModule,pua_dialoginfo,Dialog Event PUA,,+kamailio-mod-dialog +kamailio-mod-pua))
$(eval $(call BuildKamailioModule,pua_json,Presence user agent implementation with JSON messages,,+libjson-c))
$(eval $(call BuildKamailioModule,pua_reginfo,PUA registration info,,+kamailio-mod-pua +kamailio-mod-usrloc))
$(eval $(call BuildKamailioModule,pua_rpc,RPC extensions for PUA,,+kamailio-mod-pua))
$(eval $(call BuildKamailioModule,pua_usrloc,PUA User Location,,+kamailio-mod-pua +kamailio-mod-usrloc))
$(eval $(call BuildKamailioModule,pua_xmpp,PUA XMPP,,+kamailio-mod-presence +kamailio-mod-pua +kamailio-mod-xmpp))
$(eval $(call BuildKamailioModule,pv,Pseudo-Variables,,))
$(eval $(call BuildKamailioModule,pv_headers,Flexible SIP header management,,))
$(eval $(call BuildKamailioModule,qos,QoS control,,+kamailio-mod-dialog))
$(eval $(call BuildKamailioModule,ratelimit,Traffic shapping,,))
$(eval $(call BuildKamailioModule,regex,Regular Expression,,+libpcre))
$(eval $(call BuildKamailioModule,registrar,SIP Registrar,,+kamailio-mod-usrloc))
$(eval $(call BuildKamailioModule,rls,Resource List Server,,+kamailio-mod-presence +kamailio-mod-pua +kamailio-mod-tm,))
$(eval $(call BuildKamailioModule,rr,Record-Route and Route,,))
$(eval $(call BuildKamailioModule,rtimer,Routing Timer,,))
$(eval $(call BuildKamailioModule,rtjson,SIP routing based on JSON API,,))
$(eval $(call BuildKamailioModule,rtpengine,RTP engine,,+kamailio-mod-tm))
$(eval $(call BuildKamailioModule,rtpproxy,RTP proxy,,+kamailio-mod-tm))
$(eval $(call BuildKamailioModule,sanity,SIP sanity checks,,+kamailio-mod-sl))
$(eval $(call BuildKamailioModule,sca,Shared Call Appearances,,+kamailio-mod-sl +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,sctp,SCTP support,,+libsctp))
$(eval $(call BuildKamailioModule,sdpops,Managing SDP payloads,,))
$(eval $(call BuildKamailioModule,seas,Sip Express Application Server,,+kamailio-mod-tm))
$(eval $(call BuildKamailioModule,secfilter,Allow/block filters,,,))
$(eval $(call BuildKamailioModule,sipcapture,SIP capture,,))
$(eval $(call BuildKamailioModule,sipdump,Save SIP traffic,,))
$(eval $(call BuildKamailioModule,sipt,SIP-T and SIP-I operations,,))
$(eval $(call BuildKamailioModule,siptrace,SIP trace,,))
$(eval $(call BuildKamailioModule,siputils,SIP utilities,,+kamailio-mod-sl))
$(eval $(call BuildKamailioModule,sl,Stateless replier,,))
$(eval $(call BuildKamailioModule,sms,SIP-to-SMS IM gateway,,+kamailio-mod-tm))
$(eval $(call BuildKamailioModule,smsops,Handle SMS packets in SIP,,))
$(eval $(call BuildKamailioModule,snmpstats,SNMP interface for statistics,,+libnetsnmp))
$(eval $(call BuildKamailioModule,speeddial,Per-user speed-dial controller,,))
$(eval $(call BuildKamailioModule,sqlops,SQL operations,,))
$(eval $(call BuildKamailioModule,ss7ops,JSON Operations for SS7 over HEP,,))
$(eval $(call BuildKamailioModule,statistics,Script statistics,,))
$(eval $(call BuildKamailioModule,statsc,Statistics collector,,))
$(eval $(call BuildKamailioModule,statsd,Connector for statsd application,,))
$(eval $(call BuildKamailioModule,stun,STUN server support,,))
$(eval $(call BuildKamailioModule,sst,SIP Session Timer,,+kamailio-mod-dialog +kamailio-mod-sl))
$(eval $(call BuildKamailioModule,tcpops,TCP options tweaking operations,,))
$(eval $(call BuildKamailioModule,textops,Text operations,,))
$(eval $(call BuildKamailioModule,textopsx,Extra text operations,,))
$(eval $(call BuildKamailioModule,timer,Execute routing blocks on core timers,,))
$(eval $(call BuildKamailioModule,tls,TLS operations,,+libopenssl,,tls.cfg))
$(eval $(call BuildKamailioModule,tmrec,Match time recurrences,,))
$(eval $(call BuildKamailioModule,topoh,Topology hiding,,+kamailio-mod-rr))
$(eval $(call BuildKamailioModule,topos,Topology stripping module,,+kamailio-mod-rr))
$(eval $(call BuildKamailioModule,topos_redis,Redis backend for topos module,,+kamailio-mod-ndb-redis +kamailio-mod-topos))
$(eval $(call BuildKamailioModule,tm,Transaction,,))
$(eval $(call BuildKamailioModule,tmx,Transaction module extensions,,))
$(eval $(call BuildKamailioModule,tsilo,Transaction storage,,+kamailio-mod-registrar +kamailio-mod-sl +kamailio-mod-tm))
$(eval $(call BuildKamailioModule,uac,User Agent Client,,+kamailio-mod-tm))
$(eval $(call BuildKamailioModule,uac_redirect,User Agent Client redirection,,+kamailio-mod-tm))
$(eval $(call BuildKamailioModule,uid_auth_db,Authentication module,,+kamailio-mod-auth))
$(eval $(call BuildKamailioModule,uid_avp_db,AVP database operations,,))
$(eval $(call BuildKamailioModule,uid_domain,Domains management,,))
$(eval $(call BuildKamailioModule,uid_gflags,Global attributes and flags,,))
$(eval $(call BuildKamailioModule,uid_uri_db,Database URI operations,,))
$(eval $(call BuildKamailioModule,uri_db,Database-backend SIP URI checking,,))
$(eval $(call BuildKamailioModule,userblacklist,User blacklists,,+kamailio-lib-libtrie))
$(eval $(call BuildKamailioModule,usrloc,User location,,))
$(eval $(call BuildKamailioModule,utils,Misc utilities,,+libcurl,))
$(eval $(call BuildKamailioModule,uuid,UUID utilities,,+libuuid))
$(eval $(call BuildKamailioModule,websocket,WebSocket transport layer,,+kamailio-mod-sl +kamailio-mod-tm +libopenssl +libunistring))
$(eval $(call BuildKamailioModule,xcap_client,XCAP Client,,+libcurl))
$(eval $(call BuildKamailioModule,xcap_server,XCAP server implementation,,+kamailio-mod-xhttp +kamailio-mod-sl))
$(eval $(call BuildKamailioModule,xhttp,Basic HTTP request handling server,,+kamailio-mod-sl))
$(eval $(call BuildKamailioModule,xhttp_pi,HTTP provisioning interface,,+kamailio-mod-xhttp,xhttp_pi,pi_framework.xml))
$(eval $(call BuildKamailioModule,xhttp_prom,Prometheus metrics,,+kamailio-mod-xhttp,))
$(eval $(call BuildKamailioModule,xhttp_rpc,RPC commands handling over HTTP,,+kamailio-mod-xhttp))
$(eval $(call BuildKamailioModule,xlog,Advanced logger,,))
$(eval $(call BuildKamailioModule,xmlops,XML operations,,))
$(eval $(call BuildKamailioModule,xmlrpc,XML RPC module,,,))
$(eval $(call BuildKamailioModule,xmpp,SIP-to-XMPP Gateway,,+kamailio-mod-tm +libexpat))
$(eval $(call BuildKamailioModule,xprint,Print messages with specifiers,,))
