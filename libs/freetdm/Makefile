#
# Copyright (C) 2021 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=freetdm
PKG_RELEASE:=3
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/freeswitch/freetdm.git
PKG_SOURCE_DATE:=2021-08-30
PKG_SOURCE_VERSION:=8918ee1c3637cad0f9d41a402d26d3aa076fc202
PKG_MIRROR_HASH:=fd7e658f27bcca67fceeacd72e61bdbb6bea784df2def3ca2659a28ce2079e7b

PKG_FIXUP:=autoreconf

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_LICENSE:= \
	BSD-2-Clause \
	BSD-3-Clause \
	BSD-4-Clause \
	GPL-2.0+ \
	MIT/X11 (BSD like) \
	MPL-1.1

PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=freeswitch

FS_EXAMPLES_DIR:=/usr/share/freeswitch/examples
FS_LIB_DIR:=/usr/lib
FS_MOD_DIR:=$(FS_LIB_DIR)/freeswitch/mod
FS_PKGCONFIG_DIR:=$(FS_LIB_DIR)/pkgconfig

PKG_CONFIG_DEPENDS:= \
	CONFIG_FREETDM_WITH_DEBUG \
	CONFIG_LIBC \
	CONFIG_PACKAGE_libfreetdm-ftmod-libpri \
	CONFIG_PACKAGE_libfreetdm-ftmod-pritap \

include $(INCLUDE_DIR)/package.mk

define Package/libfreetdm/install/ftmod
	$(INSTALL_DIR) $(1)$(FS_MOD_DIR)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)$(FS_MOD_DIR)/ftmod_$(2).so \
						$(1)$(FS_MOD_DIR)
endef

define Package/freetdm/config
	source "$(SOURCE)/Config.in"
endef

define Package/libfreetdm/Default
  SECTION:=libs
  CATEGORY:=Libraries
  SUBMENU:=Telephony
  URL:=https://www.freeswitch.org
endef

define Package/libfreetdm
$(call Package/libfreetdm/Default)
  DEPENDS:=
  TITLE:=TDM signaling and media API
  MENU:=1
endef

define Package/libfreetdm/description
Provides a unified interface to hardware TDM cards and SS7 stacks.
endef

define Package/libfreetdm/install
	$(INSTALL_DIR) $(1)$(FS_LIB_DIR)
	$(CP) $(PKG_INSTALL_DIR)$(FS_LIB_DIR)/libfreetdm.so.* \
					$(1)$(FS_LIB_DIR)
endef

define Package/freeswitch-mod-freetdm
$(call Package/libfreetdm/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  DEPENDS:=freeswitch +libfreetdm
  TITLE:=FreeTDM endpoint module
endef

define Package/freeswitch-mod-freetdm/description
This module is the glue between FreeSWITCH and FreeTDM.
endef

define Package/freeswitch-mod-freetdm/install
	$(INSTALL_DIR) $(1)$(FS_MOD_DIR)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)$(FS_MOD_DIR)/mod_freetdm.so \
							$(1)$(FS_MOD_DIR)
ifeq ($(CONFIG_FS_WITH_MODCONF),y)
	$(INSTALL_DIR) \
		$(1)$(FS_EXAMPLES_DIR)/mod_freetdm/freeswitch/autoload_configs
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/*.conf \
		$(1)$(FS_EXAMPLES_DIR)/mod_freetdm
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/etc/freeswitch/autoload_configs/freetdm.conf.xml \
		$(1)$(FS_EXAMPLES_DIR)/mod_freetdm/freeswitch/autoload_configs
endif
endef

define Package/libfreetdm/FTModule
define Package/libfreetdm-ftmod-$(subst _,-,$(1))
$(call Package/libfreetdm/Default)
  DEPENDS:=libfreetdm \
	  $(patsubst +%,+PACKAGE_libfreetdm-ftmod-$(subst _,-,$(1)):%,$(4))
  TITLE:=$(2) FreeTDM module
endef
define Package/libfreetdm-ftmod-$(subst _,-,$(1))/description
$(subst \n,$(newline),$(3))
endef
define Package/libfreetdm-ftmod-$(subst _,-,$(1))/install
$(call Package/libfreetdm/install/ftmod,$$(1),$(1))
endef
$$(eval $$(call BuildPackage,libfreetdm-ftmod-$(subst _,-,$(1))))
endef

CONFIGURE_ARGS+= \
	--srcdir=$(PKG_BUILD_DIR) \
	--disable-dependency-tracking \
	--disable-static \
	--with-modinstdir=$(FS_MOD_DIR) \
	$(call autoconf_bool,CONFIG_FREETDM_WITH_DEBUG,debug) \
	$(if $(CONFIG_PACKAGE_libfreetdm-ftmod-libpri),--with-libpri="$(STAGING_DIR)/usr",--without-libpri) \
	$(if $(CONFIG_PACKAGE_libfreetdm-ftmod-pritap),--with-pritap,--without-pritap)

$(eval $(call BuildPackage,libfreetdm))
$(eval $(call BuildPackage,freeswitch-mod-freetdm))

################################
# FreeTDM modules
# Params:
# 1 - Package subname
# 2 - Package title
# 3 - Module description
# 4 - Module dependencies
################################

$(eval $(call Package/libfreetdm/FTModule,analog,Analog,Offers generic FXO/FXS support for any type of card supported by FreeTDM.,))
$(eval $(call Package/libfreetdm/FTModule,analog_em,Analog EM,Offers generic E&M signaling for any type of card supported by FreeTDM.,))
$(eval $(call Package/libfreetdm/FTModule,libpri,LibPRI,Offers support for PRI lines using the open source libpri stack for any\ntype of card supported by FreeTDM. Supports both PRI and BRI signalling.,+libpri @!aarch64))
$(eval $(call Package/libfreetdm/FTModule,pritap,PRI tapping,This module is used to tap PRI lines.,+libfreetdm-ftmod-libpri))
$(eval $(call Package/libfreetdm/FTModule,skel,Skeleton,ftmod_skel is an example module.,))
$(eval $(call Package/libfreetdm/FTModule,zt,DAHDI I/O,This module supports the DAHDI interface. The DAHDI interface is used by\nseveral hardware vendors.,))
