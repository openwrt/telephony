#
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kamailio3
PKG_VERSION:=3.3.7
PKG_RELEASE:=9

PKG_SOURCE_URL:=http://www.kamailio.org/pub/kamailio/$(PKG_VERSION)/src/
PKG_SOURCE:=kamailio-$(PKG_VERSION)$(PKG_VARIANT)_src.tar.gz
PKG_MD5SUM:=519d1dfbddf7dbead3a020321582d471
PKG_USE_MIPS16:=0

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Jiri Slachta <slachta@cesnet.cz>

INCL_MODULES:=
KAM_MODULES:=

include $(INCLUDE_DIR)/nls.mk
include $(INCLUDE_DIR)/package.mk

TARGET_CFLAGS += $(FPIC)
PREBUILT_STAMP=$(STAGING_DIR)/stamp/.$(PKG_NAME)_prebuilt
TAR_CMD:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components 1 $(TAR_OPTIONS)

define Package/kamailio3/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  URL:=http://www.kamailio.org/
  DEPENDS:=$(ICONV_DEPENDS) +libncurses +libpthread +libreadline
endef

define Package/kamailio3
$(call Package/kamailio3/Default)
  TITLE:=Mature and flexible open source SIP server, v$(PKG_VERSION)
  MENU:=1
endef

define Package/kamailio3/conffiles
/etc/default/kamailio
/etc/kamailio/kamailio.cfg
/etc/kamailio/dictionary.kamailio
/etc/kamailio/kamctlrc
endef

define Package/kamailio3/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/kam{ailio,ctl,dbctl} $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/sercmd $(1)/usr/sbin/

	$(INSTALL_DIR) $(1)/usr/lib/kamailio/modules{,_s,_k}
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/kamailio/lib*.so* $(1)/usr/lib/kamailio/

	$(INSTALL_DIR) $(1)/etc/kamailio
	$(CP) \
		$(PKG_INSTALL_DIR)/etc/kamailio/{dictionary.kamailio,kamailio.cfg,kamctlrc} \
		$(1)/etc/kamailio/

	$(INSTALL_DIR) $(1)/etc/default
	$(CP) \
		./files/kamailio.default \
		$(1)/etc/default/kamailio

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) \
		./files/kamailio.init \
		$(1)/etc/init.d/kamailio

	$(INSTALL_DIR) $(1)/usr/lib/kamailio
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/kamailio/kamctl \
		$(1)/usr/lib/kamailio/
endef

define Package/kamailio3/install/module
	$(INSTALL_DIR) $(1)/usr/lib/kamailio/$(3)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/kamailio/$(3)/*$(2).so* $(1)/usr/lib/kamailio/$(3)/
endef

define Package/kamailio3/install/dbfiles
	$(INSTALL_DIR) $(1)/usr/share/kamailio/$(2)
	$(CP) $(PKG_INSTALL_DIR)/usr/share/kamailio/$(2)/* $(1)/usr/share/kamailio/$(2)/
endef

define BuildKamailio3Module
  define Package/kamailio3-mod-$(subst _,-,$(1))
    $$(call Package/kamailio3/Default)
    TITLE:= kamailio3 $(2) module
    DEPENDS:=kamailio3 $(4)
  endef

  define Package/kamailio3-mod-$(subst _,-,$(1))/description
This package provides support for $(3) in Kamailio.
  endef

  define Package/kamailio3-mod-$(subst _,-,$(1))/install
$(call Package/kamailio3/install/module,$$(1),$(1),$(5))
$(foreach d,$(6),$(call Package/kamailio3/install/dbfiles,$$(1),$(d));)
  endef

  INCL_MODULES+=$(1)
  KAM_MODULES+=kamailio3-mod-$(subst _,-,$(1))
endef

################################
# Kamailio module parameters
# Module params:
# 1 - Name
# 2 - Title
# 3 - Description
# 4 - Dependencies
# 5 - Subdir
# 6 - DB file directories
################################

$(eval $(call BuildKamailio3Module,acc,Accounting,,+kamailio3-mod-tm,modules_k))
$(eval $(call BuildKamailio3Module,alias_db,Database-backend aliases,,+kamailio3-mod-db-sqlite,modules_k))
$(eval $(call BuildKamailio3Module,auth,Authentication Framework,,,modules))
$(eval $(call BuildKamailio3Module,auth_db,Database-backend authentication,,+kamailio3-mod-auth  +kamailio3-mod-db-sqlite,modules_k))
$(eval $(call BuildKamailio3Module,auth_diameter,Diameter-backend authentication,,+kamailio3-mod-sl,modules_k))
$(eval $(call BuildKamailio3Module,avpops,AVP operation,,,modules))
$(eval $(call BuildKamailio3Module,benchmark,Config benchmark,,,modules_k))
$(eval $(call BuildKamailio3Module,cfgutils,Config utilities,,,modules_k))
$(eval $(call BuildKamailio3Module,cfg_db,Load core and module parameters from database,,+kamailio3-mod-db-sqlite,modules))
$(eval $(call BuildKamailio3Module,cfg_rpc,Update core and module parameters at runtime via RPC interface,,,modules))
$(eval $(call BuildKamailio3Module,ctl,BINRPC transport interface,,,modules))
$(eval $(call BuildKamailio3Module,db_flatstore,Fast writing-only text database-backed,,,modules))
$(eval $(call BuildKamailio3Module,db_mysql,MySQL database-backend,,+libmysqlclient,modules,mysql))
$(eval $(call BuildKamailio3Module,db_postgres,PostgreSQL Database-backend,,+libpq,modules,postgres))
$(eval $(call BuildKamailio3Module,db_sqlite,Sqlite DB support,,+libsqlite3,modules_k,db_sqlite))
$(eval $(call BuildKamailio3Module,db_text,Text database-backend,,,modules_k,dbtext/kamailio))
$(eval $(call BuildKamailio3Module,db_unixodbc,UnixODBC Database-backend,,+unixodbc,modules_k))
$(eval $(call BuildKamailio3Module,dialog,Dialog support,,+kamailio3-mod-rr +kamailio3-mod-tm,modules_k))
$(eval $(call BuildKamailio3Module,dialplan,Dialplan management,,+libpcre,modules))
$(eval $(call BuildKamailio3Module,dispatcher,Dispatcher,,,modules_s))
$(eval $(call BuildKamailio3Module,diversion,Diversion header insertion,,,modules_s))
$(eval $(call BuildKamailio3Module,domain,Multi-domain support,,,modules_k))
$(eval $(call BuildKamailio3Module,domainpolicy,Domain policy,,,modules_k))
$(eval $(call BuildKamailio3Module,drouting,Dynamic routing module,,,modules_k))
$(eval $(call BuildKamailio3Module,enum,ENUM lookup,,,modules))
$(eval $(call BuildKamailio3Module,exec,External exec,,,modules_k))
$(eval $(call BuildKamailio3Module,group,Database-backend user-groups,,,modules_k))
$(eval $(call BuildKamailio3Module,h350,H.350,,+kamailio3-mod-ldap +libopenldap,modules_k))
$(eval $(call BuildKamailio3Module,htable,Hash Table,,,modules_k))
$(eval $(call BuildKamailio3Module,imc,IM conferencing,,+kamailio3-mod-db-mysql +kamailio3-mod-tm,modules_k))
$(eval $(call BuildKamailio3Module,ipops,IP and IPv6 operations module,,,modules))
$(eval $(call BuildKamailio3Module,kex,Core extensions,,,modules_k))
$(eval $(call BuildKamailio3Module,lcr,Least Cost Routing,,+kamailio3-mod-tm +libpcre,modules))
$(eval $(call BuildKamailio3Module,ldap,LDAP connector,,+libopenldap,modules_k))
$(eval $(call BuildKamailio3Module,maxfwd,Max-Forward processor,,,modules_k))
$(eval $(call BuildKamailio3Module,mediaproxy,Automatic NAT traversal,,+kamailio3-mod-dialog,modules))
$(eval $(call BuildKamailio3Module,mi_datagram,Datagram support for Management Interface,,,modules_k))
$(eval $(call BuildKamailio3Module,mi_fifo,FIFO support for Management Interface,,,modules_k))
$(eval $(call BuildKamailio3Module,mi_rpc,RPC support for Management Interface,,,modules))
$(eval $(call BuildKamailio3Module,msilo,SIP message silo,,+kamailio3-mod-tm,modules_k))
$(eval $(call BuildKamailio3Module,nat_traversal,NAT traversal,,+kamailio3-mod-dialog +kamailio3-mod-sl +kamailio3-mod-tm,modules_k))
$(eval $(call BuildKamailio3Module,nathelper,NAT traversal helper,,+rtpproxy,modules_k))
$(eval $(call BuildKamailio3Module,path,SIP path insertion,,+kamailio3-mod-rr,modules_k))
$(eval $(call BuildKamailio3Module,pdt,Prefix-to-Domain translator,,,modules_k))
$(eval $(call BuildKamailio3Module,permissions,Permissions control,,,modules_k))
$(eval $(call BuildKamailio3Module,pike,Flood detector,,,modules_k))
$(eval $(call BuildKamailio3Module,presence,Presence server,,+kamailio3-mod-sl +kamailio3-mod-tm +libxml2,modules_k))
$(eval $(call BuildKamailio3Module,presence_dialoginfo,Dialog Event presence,,+kamailio3-mod-presence,modules_k))
$(eval $(call BuildKamailio3Module,presence_mwi,Message Waiting Indication presence,,+kamailio3-mod-presence,modules_k))
$(eval $(call BuildKamailio3Module,presence_xml,XCAP presence,,+kamailio3-mod-presence +kamailio3-mod-xcap-client,modules_k))
$(eval $(call BuildKamailio3Module,pua,Presence User Agent,,+kamailio3-mod-tm +libxml2,modules_k))
$(eval $(call BuildKamailio3Module,pua_bla,Bridged Line Appearence PUA,,+kamailio3-mod-presence +kamailio3-mod-pua +kamailio3-mod-usrloc,modules_k))
$(eval $(call BuildKamailio3Module,pua_dialoginfo,Dialog Event PUA,,+kamailio3-mod-dialog +kamailio3-mod-pua,modules_k))
$(eval $(call BuildKamailio3Module,pua_mi,PUA Management Interface,,+kamailio3-mod-pua,modules_k))
$(eval $(call BuildKamailio3Module,pua_usrloc,PUA User Location,,+kamailio3-mod-pua +kamailio3-mod-usrloc,modules_k))
$(eval $(call BuildKamailio3Module,pua_xmpp,PUA XMPP,,+kamailio3-mod-presence +kamailio3-mod-pua +kamailio3-mod-xmpp,modules_k))
$(eval $(call BuildKamailio3Module,pv,Pseudo-Variables,,,modules_k))
$(eval $(call BuildKamailio3Module,qos,QoS control,,+kamailio3-mod-dialog,modules_k))
$(eval $(call BuildKamailio3Module,ratelimit,Traffic shapping,,,modules))
$(eval $(call BuildKamailio3Module,regex,Regular Expression,,+libpcre,modules_k))
$(eval $(call BuildKamailio3Module,registrar,SIP Registrar,,+kamailio3-mod-usrloc,modules_k))
$(eval $(call BuildKamailio3Module,rls,Resource List Server,,+kamailio3-mod-presence +kamailio3-mod-pua +kamailio3-mod-tm +libxml2,modules_k))
$(eval $(call BuildKamailio3Module,rr,Record-Route and Route,,,modules_k))
$(eval $(call BuildKamailio3Module,rtimer,Routing Timer,,,modules_k))
$(eval $(call BuildKamailio3Module,rtpproxy,RTP proxy,,+kamailio3-mod-tm,modules))
$(eval $(call BuildKamailio3Module,sanity,SIP sanity checks,,+kamailio3-mod-sl,modules))
$(eval $(call BuildKamailio3Module,sipcapture,SIP capture module,,,modules))
$(eval $(call BuildKamailio3Module,siptrace,SIP trace,,,modules_k))
$(eval $(call BuildKamailio3Module,siputils,SIP utilities,,+kamailio3-mod-sl,modules_k))
$(eval $(call BuildKamailio3Module,sl,Stateless replier,,,modules))
$(eval $(call BuildKamailio3Module,sms,SIP-to-SMS IM gateway,,+kamailio3-mod-tm,modules))
$(eval $(call BuildKamailio3Module,speeddial,Per-user speed-dial controller,,,modules_k))
$(eval $(call BuildKamailio3Module,sqlops,SQL operations,,,modules_k))
$(eval $(call BuildKamailio3Module,statistics,Script statistics,,,modules_k))
$(eval $(call BuildKamailio3Module,sst,SIP Session Timer,,+kamailio3-mod-dialog +kamailio3-mod-sl,modules_k))
$(eval $(call BuildKamailio3Module,textops,Text operations,,,modules_k))
$(eval $(call BuildKamailio3Module,tls,TLS operations,,+libopenssl,modules))
$(eval $(call BuildKamailio3Module,tm,Transaction,,,modules))
$(eval $(call BuildKamailio3Module,tmx,Transaction module extensions,,,modules_k))
$(eval $(call BuildKamailio3Module,uac,User Agent Client,,+kamailio3-mod-tm,modules_k))
$(eval $(call BuildKamailio3Module,uac_redirect,User Agent Client redirection,,+kamailio3-mod-tm,modules_k))
$(eval $(call BuildKamailio3Module,uri_db,Database-backend SIP URI checking,,,modules_k))
$(eval $(call BuildKamailio3Module,userblacklist,User blacklists,,,modules_k))
$(eval $(call BuildKamailio3Module,usrloc,User location,,+libxml2,modules_k))
$(eval $(call BuildKamailio3Module,utils,Misc utilities,,+libcurl +libxml2,modules))
$(eval $(call BuildKamailio3Module,xcap_client,XCAP Client,,+libcurl,modules_k))
$(eval $(call BuildKamailio3Module,xlog,Advanced logger,,,modules_k))
$(eval $(call BuildKamailio3Module,xmlrpc,XML RPC module,,+libxml2,modules))
$(eval $(call BuildKamailio3Module,xmpp,SIP-to-XMPP Gateway,,+kamailio3-mod-tm +libexpat +libxml2,modules_k))

PKG_MAKE_ARGS:= \
	prefix=/ \
	cfg_dir=/etc/kamailio/ \
	bin_dir=/usr/sbin/ \
	data_dir=/usr/share/kamailio/ \
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

$(eval $(call BuildPackage,kamailio3))
$(foreach m,$(KAM_MODULES),$(eval $(call BuildPackage,$(m))))
