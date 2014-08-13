#
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kamailio4
PKG_VERSION:=4.1.5
PKG_RELEASE:=3

PKG_SOURCE_URL:=http://www.kamailio.org/pub/kamailio/$(PKG_VERSION)/src/
PKG_SOURCE:=kamailio-$(PKG_VERSION)$(PKG_VARIANT)_src.tar.gz
PKG_MD5SUM:=623b46e969445494655b1aa5ab5ad4b0
PKG_USE_MIPS16:=0

INCL_MODULES:=
KAM_MODULES:=

include $(INCLUDE_DIR)/nls.mk
include $(INCLUDE_DIR)/package.mk

TARGET_CFLAGS += $(FPIC)
PREBUILT_STAMP=$(STAGING_DIR)/stamp/.$(PKG_NAME)_prebuilt
TAR_CMD:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components 1 $(TAR_OPTIONS)

define Package/kamailio4/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  URL:=http://www.kamailio.org/
  MAINTAINER:=Jiri Slachta <slachta@cesnet.cz>
  DEPENDS:=$(ICONV_DEPENDS) +libncurses +libpthread +libreadline +libxml2
endef

define Package/kamailio4
$(call Package/kamailio4/Default)
  TITLE:=Mature and flexible open source SIP server, v$(PKG_VERSION)
  MENU:=1
endef

define Package/kamailio4/conffiles
/etc/default/kamailio
/etc/kamailio/kamailio.cfg
/etc/kamailio/kamailio-advanced.cfg
/etc/kamailio/dictionary.kamailio
endef

define Package/kamailio4-tools
$(call Package/kamailio4/Default)
  TITLE:=Kamailio4 control tools
  DEPENDS:=kamailio4
endef

define Package/kamailio4-tools/conffiles
/etc/kamailio/kamctlrc
endef

define Package/kamailio4/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/sbin/{kamailio,kamcmd} \
		$(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/lib/kamailio/modules
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/lib/kamailio/lib*.so* \
		$(1)/usr/lib/kamailio/
	$(INSTALL_DIR) $(1)/etc/kamailio
	$(CP) \
		$(PKG_INSTALL_DIR)/etc/kamailio/{kamailio-advanced.cfg,kamailio.cfg} \
		$(1)/etc/kamailio/
	$(INSTALL_DIR) $(1)/etc/kamailio
	$(CP) \
		$(PKG_INSTALL_DIR)/etc/kamailio/dictionary.kamailio \
		$(1)/etc/kamailio/
	$(INSTALL_DIR) $(1)/etc/default
	$(CP) \
		./files/kamailio.default \
		$(1)/etc/default/kamailio
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) \
		./files/kamailio.init \
		$(1)/etc/init.d/kamailio
endef

define Package/kamailio4-tools/install
	$(INSTALL_DIR) $(1)/etc/kamailio
	$(CP) \
		$(PKG_BUILD_DIR)/utils/kamctl/kamctlrc \
		$(1)/etc/kamailio/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/sbin/kam{ctl,dbctl} \
		$(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/lib/kamailio
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/kamailio/kamctl \
		$(1)/usr/lib/kamailio/
endef

define BuildPlugin
  define Package/kamailio4-mod-$(1)
    $$(call Package/kamailio4/Default)
    TITLE:= kamailio4 $(3) module
    DEPENDS:=kamailio4 $$(foreach m,$(4),+kamailio4-mod-$$m) $(5)
  endef

  define Package/kamailio4-mod-$(1)/install
	$(INSTALL_DIR) $$(1)/usr/lib/kamailio/modules
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/kamailio/modules/$(2).so $$(1)/usr/lib/kamailio/modules/
  endef

  INCL_MODULES+=$(2)
  KAM_MODULES+=kamailio4-mod-$(1)
endef

################################
# Kamailio modules
# Params:
# 1 - Package subname
# 2 - Module name
# 3 - Module description
# 4 - Dependencies to internal modules
# 5 - Dependencies to external libs/apps
################################

$(eval $(call BuildPlugin,acc,acc,Accounting,tm,))
$(eval $(call BuildPlugin,alias-db,alias_db,Database-backend aliases,db-sqlite,))
$(eval $(call BuildPlugin,auth,auth,Authentication Framework,,))
$(eval $(call BuildPlugin,auth-db,auth_db,Database-backend authentication,auth db-sqlite,))
$(eval $(call BuildPlugin,auth-diameter,auth_diameter,Diameter-backend authentication,sl,))
$(eval $(call BuildPlugin,avpops,avpops,AVP operation,,))
$(eval $(call BuildPlugin,benchmark,benchmark,Config benchmark,,))
$(eval $(call BuildPlugin,cfgutils,cfgutils,Config utilities,,))
$(eval $(call BuildPlugin,cfg-db,cfg_db,Load core and module parameters from database,db-sqlite,))
$(eval $(call BuildPlugin,cfg-rpc,cfg_rpc,Update core and module parameters at runtime via RPC interface,,))
$(eval $(call BuildPlugin,cnxcc,cnxcc,Limit call duration,dialog,))
$(eval $(call BuildPlugin,corex,corex,Legacy functions,,))
$(eval $(call BuildPlugin,ctl,ctl,BINRPC transport interface,,))
$(eval $(call BuildPlugin,db-flatstore,db_flatstore,Fast writing-only text database-backed,,))
$(eval $(call BuildPlugin,db-mysql,db_mysql,MySQL database-backend,,+libmysqlclient))
$(eval $(call BuildPlugin,db-postgres,db_postgres,PostgreSQL Database-backend,,+libpq))
$(eval $(call BuildPlugin,db-sqlite,db_sqlite,Sqlite DB support,,+libsqlite3))
$(eval $(call BuildPlugin,db-text,db_text,Text database-backend,,))
$(eval $(call BuildPlugin,db-unixodbc,db_unixodbc,UnixODBC Database-backend,,+unixodbc))
$(eval $(call BuildPlugin,dialog,dialog,Dialog support,rr tm,))
$(eval $(call BuildPlugin,dialog_ng,dialog,Dialog support,rr tm,))
$(eval $(call BuildPlugin,dialplan,dialplan,Dialplan management,,+libpcre))
$(eval $(call BuildPlugin,dispatcher,dispatcher,Dispatcher,,))
$(eval $(call BuildPlugin,diversion,diversion,Diversion header insertion,,))
$(eval $(call BuildPlugin,domain,domain,Multi-domain support,,))
$(eval $(call BuildPlugin,domainpolicy,domainpolicy,Domain policy,,))
$(eval $(call BuildPlugin,enum,enum,ENUM lookup,,))
$(eval $(call BuildPlugin,exec,exec,External exec,,))
$(eval $(call BuildPlugin,group,group,Database-backend user-groups,,))
$(eval $(call BuildPlugin,h350,h350,H.350,ldap,+libopenldap))
$(eval $(call BuildPlugin,htable,htable,Hash Table,,))
$(eval $(call BuildPlugin,imc,imc,IM conferencing,db-mysql tm,))
$(eval $(call BuildPlugin,ipops,ipops,IP and IPv6 operations,,))
$(eval $(call BuildPlugin,json,json,Access to JSON document attributes,,+libjson))
$(eval $(call BuildPlugin,kex,kex,Core extensions,,))
$(eval $(call BuildPlugin,lcr,lcr,Least Cost Routing,tm,+libpcre))
$(eval $(call BuildPlugin,ldap,ldap,LDAP connector,,+libopenldap))
$(eval $(call BuildPlugin,maxfwd,maxfwd,Max-Forward processor,,))
$(eval $(call BuildPlugin,mediaproxy,mediaproxy,Automatic NAT traversal,dialog,))
$(eval $(call BuildPlugin,mi-datagram,mi_datagram,Datagram support for Management Interface,,))
$(eval $(call BuildPlugin,mi-fifo,mi_fifo,FIFO support for Management Interface,,))
$(eval $(call BuildPlugin,mi-rpc,mi_rpc,RPC support for Management Interface,,))
$(eval $(call BuildPlugin,msilo,msilo,SIP message silo,tm,))
$(eval $(call BuildPlugin,msrp,msrp,MSRP routing engine,tls,))
$(eval $(call BuildPlugin,nathelper,nathelper,NAT helper,usrloc,))
$(eval $(call BuildPlugin,nat_traversal,nat_traversal,NAT traversal,dialog sl tm,))
$(eval $(call BuildPlugin,path,path,SIP path insertion,rr,))
$(eval $(call BuildPlugin,pdt,pdt,Prefix-to-Domain translator,,))
$(eval $(call BuildPlugin,permissions,permissions,Permissions control,,))
$(eval $(call BuildPlugin,pike,pike,Flood detector,,))
$(eval $(call BuildPlugin,presence,presence,Presence server,sl tm,+libxml2))
$(eval $(call BuildPlugin,presence-dialoginfo,presence_dialoginfo,Dialog Event presence,presence,))
$(eval $(call BuildPlugin,presence-mwi,presence_mwi,Message Waiting Indication presence,presence,))
$(eval $(call BuildPlugin,presence-xml,presence_xml,XCAP presence,presence xcap-client,))
$(eval $(call BuildPlugin,pua,pua,Presence User Agent,tm,+libxml2))
$(eval $(call BuildPlugin,pua-bla,pua_bla,Bridged Line Appearence PUA,presence pua usrloc,))
$(eval $(call BuildPlugin,pua-dialoginfo,pua_dialoginfo,Dialog Event PUA,dialog pua,))
$(eval $(call BuildPlugin,pua-mi,pua_mi,PUA Management Interface,pua,))
$(eval $(call BuildPlugin,pua-usrloc,pua_usrloc,PUA User Location,pua usrloc,))
$(eval $(call BuildPlugin,pua-xmpp,pua_xmpp,PUA XMPP,presence pua xmpp,))
$(eval $(call BuildPlugin,pv,pv,Pseudo-Variables,,))
$(eval $(call BuildPlugin,qos,qos,QoS control,dialog,))
$(eval $(call BuildPlugin,ratelimit,ratelimit,Traffic shapping,,))
$(eval $(call BuildPlugin,regex,regex,Regular Expression,,+libpcre))
$(eval $(call BuildPlugin,registrar,registrar,SIP Registrar,usrloc,))
$(eval $(call BuildPlugin,rls,rls,Resource List Server,presence pua tm,+libxml2))
$(eval $(call BuildPlugin,rr,rr,Record-Route and Route,,))
$(eval $(call BuildPlugin,rtimer,rtimer,Routing Timer,,))
$(eval $(call BuildPlugin,rtpproxy,rtpproxy,RTP proxy,tm,))
$(eval $(call BuildPlugin,rtpproxy-ng,rtpproxy-ng,RTP proxy with new control protocol,tm,))
$(eval $(call BuildPlugin,sanity,sanity,SIP sanity checks,sl,))
$(eval $(call BuildPlugin,sipcapture,sipcapture,SIP capture,,))
$(eval $(call BuildPlugin,siptrace,siptrace,SIP trace,,))
$(eval $(call BuildPlugin,siputils,siputils,SIP utilities,sl,))
$(eval $(call BuildPlugin,sl,sl,Stateless replier,,))
$(eval $(call BuildPlugin,sms,sms,SIP-to-SMS IM gateway,tm,))
$(eval $(call BuildPlugin,speeddial,speeddial,Per-user speed-dial controller,,))
$(eval $(call BuildPlugin,sqlops,sqlops,SQL operations,,))
$(eval $(call BuildPlugin,statistics,statistics,Script statistics,,))
$(eval $(call BuildPlugin,stun,stun,STUN server support,,))
$(eval $(call BuildPlugin,sst,sst,SIP Session Timer,dialog sl,))
$(eval $(call BuildPlugin,textops,textops,Text operations,,))
$(eval $(call BuildPlugin,tls,tls,TLS operations,,+libopenssl))
$(eval $(call BuildPlugin,topoh,topoh,Topology hiding,rr,))
$(eval $(call BuildPlugin,tm,tm,Transaction,,))
$(eval $(call BuildPlugin,tmx,tmx,Transaction module extensions,,))
$(eval $(call BuildPlugin,uac,uac,User Agent Client,tm,))
$(eval $(call BuildPlugin,uac-redirect,uac_redirect,User Agent Client redirection,tm,))
$(eval $(call BuildPlugin,uri-db,uri_db,Database-backend SIP URI checking,,))
$(eval $(call BuildPlugin,userblacklist,userblacklist,User blacklists,,))
$(eval $(call BuildPlugin,usrloc,usrloc,User location,,))
$(eval $(call BuildPlugin,utils,utils,Misc utilities,,+libcurl +libxml2))
$(eval $(call BuildPlugin,xcap-client,xcap_client,XCAP Client,,+libcurl))
$(eval $(call BuildPlugin,xlog,xlog,Advanced logger,,))
$(eval $(call BuildPlugin,xmpp,xmpp,SIP-to-XMPP Gateway,tm,+libexpat))

PKG_MAKE_ARGS:= \
	prefix=/ \
	cfg_dir=/etc/kamailio/ \
	bin_dir=/usr/sbin/ \
	data_dir=/var/lib/kamailio/ \
	lib_dir=/usr/lib/kamailio/ \
	modules_dir=/usr/lib/kamailio/ \
	include_modules="$(INCL_MODULES)" \
	cfg_target:=/etc/kamailio/ \
	TLS_HOOKS=1 \
	extra_defs="-DUSE_PTHREAD_MUTEX " \
	CFLAGS="$(TARGET_CFLAGS)" \
	LOCALBASE="$(STAGING_DIR)/usr" \
	SYSBASE="$(STAGING_DIR)/usr" \
	PCREDEFS:="$(TARGET_CPPFLAGS)" \
	PCRELIBS:="$(TARGET_LDFLAGS)" \
	CROSS_COMPILE=$(TARGET_CROSS) \
	CC="$(TARGET_CC)" \
	ARCH="$(ARCH)"  \
	DESTDIR=$(PKG_INSTALL_DIR) \
	quiet=verbose

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) $(PKG_MAKE_ARGS) \
		EXTRA_LIBS=-L$(STAGING_DIR)/usr/lib/ \
		all
	$(MAKE) -C $(PKG_BUILD_DIR) $(PKG_MAKE_ARGS) \
		install
endef

$(eval $(call BuildPackage,kamailio4))
$(eval $(call BuildPackage,kamailio4-tools))
$(foreach m,$(KAM_MODULES),$(eval $(call BuildPackage,$(m))))
