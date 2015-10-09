#
# Copyright (C) 2015 OpenWrt.org
# Copyright (C) 2015 Cesnet, z.s.p.o.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=chan-sccp-b
PKG_REV:=6139
PKG_VERSION:=v4.2-r$(PKG_REV)
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://svn.code.sf.net/p/chan-sccp-b/code/branches/V4.2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=svn

PKG_FIXUP:=autoreconf -fi

PKG_LICENSE:=GPL-1.0
PKG_LICENSE_FILES:=COPYING LICENSE
PKG_MAINTAINER:=Jiri Slachta <slachta@cesnet.cz>

include $(INCLUDE_DIR)/package.mk

define Package/chan-sccp-b/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=SCCP channel provider support
  URL:=http://chan-sccp-b.sourceforge.net/
  DEPENDS:= +libltdl
endef

define Package/asterisk18-chan-sccp-b
$(call Package/chan-sccp-b/Default)
  DEPENDS+= asterisk18
  VARIANT:=asterisk18
  CONFLICTS:=asterisk18-chan-skinny
endef

define Package/asterisk13-chan-sccp-b
$(call Package/chan-sccp-b/Default)
  DEPENDS+= asterisk13
  VARIANT:=asterisk13
  CONFLICTS:=asterisk13-chan-skinny
endef

define Package/asterisk11-chan-sccp-b
$(call Package/chan-sccp-b/Default)
  DEPENDS+= asterisk11 
  VARIANT:=asterisk11
  CONFLICTS:=asterisk11-chan-skinny
endef

define Package/description/Default
 SCCP channel provider for asterisk. It delivers extended functionality for SCCP phones over chan_skinny delivered
 by asterisk by default.
endef

Package/asterisk18-chan-sccp-b/description = $(Package/description/Default)
Package/asterisk11-chan-sccp-b/description = $(Package/description/Default)
Package/asterisk13-chan-sccp-b/description = $(Package/description/Default)

ifeq ($(BUILD_VARIANT),asterisk13)
  CONFIGURE_ARGS += --with-asterisk=$(STAGING_DIR)/usr/include/asterisk-13
endif

ifeq ($(BUILD_VARIANT),asterisk11)
  CONFIGURE_ARGS += --with-asterisk=$(STAGING_DIR)/usr/include/asterisk-11
endif

ifeq ($(BUILD_VARIANT),asterisk18)
  CONFIGURE_ARGS += --with-asterisk=$(STAGING_DIR)/usr/include/asterisk-1.8
endif

define Package/conffiles/Default
/etc/asterisk/sccp.conf
/etc/asterisk/extconfig.conf.sccp_sample
/etc/asterisk/res_config_sqlite3.conf.sccp_sample
/etc/asterisk/sccp_sqlite3.sql
/etc/asterisk/sccp.conf.realtime_sample
endef

Package/asterisk18-chan-sccp-b/conffiles = $(Package/conffiles/Default)
Package/asterisk11-chan-sccp-b/conffiles = $(Package/conffiles/Default)
Package/asterisk13-chan-sccp-b/conffiles = $(Package/conffiles/Default)

define Build/Compile
	$(MAKE) -C "$(PKG_BUILD_DIR)" \
		CFLAGS="$(CFLAGS) -I$(PKG_BUILD_DIR)/src -DLOW_MEMORY -fno-stack-protector" \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Package/Install/Default
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(CP) ./files/sccp.conf $(1)/etc/asterisk/sccp.conf
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/asterisk/modules/chan_sccp.so $(1)/usr/lib/asterisk/modules/
	$(INSTALL_DATA) ./files/extconfig.conf.sccp_sample $(1)/etc/asterisk/extconfig.conf.sccp_sample
	$(INSTALL_DATA) ./files/res_config_sqlite3.conf.sccp_sample $(1)/etc/asterisk/res_config_sqlite3.conf.sccp_sample
	$(INSTALL_DATA) ./files/sccp_sqlite3.sql $(1)/etc/asterisk/sccp_sqlite3.sql
	$(INSTALL_DATA) ./files/sccp.conf.realtime_sample $(1)/etc/asterisk/sccp.conf.realtime_sample
endef

Package/asterisk18-chan-sccp-b/install = $(Package/Install/Default)
Package/asterisk11-chan-sccp-b/install = $(Package/Install/Default)
Package/asterisk13-chan-sccp-b/install = $(Package/Install/Default)

$(eval $(call BuildPackage,asterisk18-chan-sccp-b))
$(eval $(call BuildPackage,asterisk11-chan-sccp-b))
$(eval $(call BuildPackage,asterisk13-chan-sccp-b))
