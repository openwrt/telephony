#
# Copyright (C) 2021 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=coturn
PKG_VERSION:=4.6.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/coturn/coturn
PKG_MIRROR_HASH:=55a7d63edfde6548cd6d6f1b62f6997beeebc66e0ff07b0afd175829434cbf3a

PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>, Sebastian Kemper <sebastian_ml@gmx.net>
PKG_LICENSE:=BSD-COTURN-CITRIX COMBINED-CITRIX-VIVOCHA-BSD MIT-HASH
PKG_LICENSE_FILES:=LICENSE src/apps/relay/dbdrivers/* src/server/ns_turn_khash.h
PKG_CPE_ID:=cpe:/a:coturn_project:coturn

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

PKG_CONFIG_DEPENDS+= \
	CONFIG_COTURN_ENABLE_MYSQL \
	CONFIG_COTURN_ENABLE_POSTGRESQL \
	CONFIG_COTURN_ENABLE_REDIS \
	CONFIG_COTURN_ENABLE_SQLITE

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/coturn
  TITLE:=coturn TURN and STUN Server
  CATEGORY:=Network
  SECTION:=net
  SUBMENU:=Telephony
  URL:=https://github.com/coturn/coturn
  USERID:=turnserver=379:turnserver=379
  DEPENDS := \
	  +libevent2 \
	  +libevent2-extra \
	  +libevent2-pthreads \
	  +libevent2-openssl \
	  +libopenssl \
	  +COTURN_ENABLE_MYSQL:libmariadb \
	  +COTURN_ENABLE_POSTGRESQL:libpq \
	  +COTURN_ENABLE_REDIS:libhiredis \
	  +COTURN_ENABLE_SQLITE:libsqlite3
  FILE_MODES:=/etc/turnserver:turnserver:turnserver:0750
endef

define Package/coturn/conffiles
/etc/config/turnserver
/etc/init.d/turnserver
/etc/turnserver.conf
/etc/turnserver
endef

define Package/coturn/config
  menu "coturn configuration"
    depends on PACKAGE_coturn

    config COTURN_ENABLE_SQLITE
      bool "SQLite support"
      default y
      help
        Enable SQLite support

    config COTURN_ENABLE_MYSQL
      bool "MySQL support"
      default n
      help
        Enable MySQL support

    config COTURN_ENABLE_POSTGRESQL
      bool "PostgreSQL support"
      default n
      help
        Enable PostgreSQL support

    config COTURN_ENABLE_REDIS
      bool "Redis support"
      default n
      help
        Enable Redis support

  endmenu
endef

define Package/coturn/description
The TURN Server is a VoIP media traffic NAT traversal server and
gateway. It can be used as a general-purpose network traffic TURN server
and gateway, too.
endef

define Package/coturn/install
	$(INSTALL_DIR) \
		$(1)/etc/{config,init.d,turnserver} $(1)/usr/{bin,share/coturn}
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/turnserver.conf.default \
		$(1)/etc/turnserver.conf
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/turn* $(1)/usr/bin
	$(INSTALL_BIN) ./files/turnserver.init \
		$(1)/etc/init.d/turnserver
	$(INSTALL_CONF) ./files/turnserver.conf \
		$(1)/etc/config/turnserver
ifneq ($(CONFIG_COTURN_ENABLE_MYSQL)$(CONFIG_COTURN_ENABLE_POSTGRESQL)$(CONFIG_COTURN_ENABLE_SQLITE),)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/share/coturn/{schema,testsqldbsetup}.sql \
		$(1)/usr/share/coturn
endif
ifneq ($(CONFIG_COTURN_ENABLE_REDIS),)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/share/coturn/schema.{stats,userdb}.redis \
		$(1)/usr/share/coturn
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/share/coturn/testredisdbsetup.sh \
		$(1)/usr/share/coturn
endif
endef

CONFIGURE_ARGS+= \
	--disable-rpath \
	--schemadir=/usr/share/coturn \
	--turndbdir=/etc/turnserver

CONFIGURE_VARS+= \
	ARCHIVERCMD="$(TARGET_AR) -r" \
	LIBEV_OK=1 \
	TURN_NO_PROMETHEUS=1 \
	TURN_NO_SCTP=1 \
	TURN_NO_SYSTEMD=1 \
	TURN_NO_MONGO=1 \
	$(if $(CONFIG_COTURN_ENABLE_MYSQL),,TURN_NO_MYSQL=1) \
	$(if $(CONFIG_COTURN_ENABLE_POSTGRESQL),,TURN_NO_PQ=1) \
	$(if $(CONFIG_COTURN_ENABLE_REDIS),,TURN_NO_HIREDIS=1) \
	$(if $(CONFIG_COTURN_ENABLE_SQLITE),,TURN_NO_SQLITE=1)

define Build/InstallDev
endef

$(eval $(call BuildPackage,coturn))
