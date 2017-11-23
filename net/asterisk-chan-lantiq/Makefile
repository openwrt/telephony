#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=chan-lantiq
PKG_VERSION:=20171111
PKG_RELEASE:=2

LANTIQ_AST13_VERSION:=5adf3d7774a75c88835f2f3daf824e2cda2c6e67

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

LTQ_DIR:=$(TOPDIR)/package/kernel/lantiq

VMMC_PATH:=$(LTQ_DIR)/ltq-vmmc
TAPI_PATH:=$(LTQ_DIR)/ltq-tapi
IFXOS_PATH:=$(LTQ_DIR)/ltq-ifxos

LTQ_MIRROR:=https://mirror2.openwrt.org/sources

IFXOS_HASH:=$(shell cat $(IFXOS_PATH)/Makefile | sed -n '/^PKG_HASH:=/s///p')
IFXOS_VERSION:=$(shell cat $(IFXOS_PATH)/Makefile | sed -n '/^PKG_VERSION:=/s///p')
IFXOS:=lib_ifxos-$(IFXOS_VERSION)
IFXOS_ARCHIVE:=$(IFXOS).tar.gz

TAPI_HASH:=$(shell cat $(TAPI_PATH)/Makefile | sed -n '/^PKG_HASH:=/s///p')
TAPI_VERSION:=$(shell cat $(TAPI_PATH)/Makefile | sed -n '/^PKG_VERSION:=/s///p')
TAPI:=drv_tapi-$(TAPI_VERSION)
TAPI_ARCHIVE:=$(TAPI).tar.bz2

VMMC_HASH:=$(shell cat $(VMMC_PATH)/Makefile | sed -n '/^PKG_HASH:=/s///p')
VMMC_VERSION:=$(shell cat $(VMMC_PATH)/Makefile | sed -n '/^PKG_VERSION:=/s///p')
VMMC:=drv_vmmc-$(VMMC_VERSION)
VMMC_ARCHIVE:=$(VMMC).tar.bz2

define Download/files
define Download/$(1)
  FILE:=$(2)
  HASH:=$(3)
  URL:=$(4)
endef
$$(eval $$(call Download,$(1)))
endef

define Download/github
define Download/$(PKG_NAME)
  VERSION:=$(1)
  SUBDIR:=$(PKG_NAME)
  FILE:=$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)-$(1).tar.xz
  URL:=https://github.com/kochstefan/asterisk_channel_lantiq.git
  PROTO:=git
endef
$$(eval $$(call Download,chan-lantiq))
endef

define Package/$(PKG_NAME)/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Lantiq channel driver
  URL:=https://github.com/kochstefan/asterisk_channel_lantiq
  DEPENDS:=@mips
endef

define Package/asterisk13-$(PKG_NAME)
$(call Package/$(PKG_NAME)/Default)
  DEPENDS+=asterisk13
  VARIANT:=asterisk13
endef

define Package/description/Default
An implementation of a Lantiq TAPI channel driver for Asterisk.
endef

Package/asterisk13-$(PKG_NAME)/description = $(Package/description/Default)

define Package/conffiles/Default
/etc/asterisk/lantiq.conf
endef

Package/asterisk13-$(PKG_NAME)/conffiles = $(Package/conffiles/Default)

define Package/Install/Default
	$(INSTALL_DIR) $(1)/etc/asterisk
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/$(PKG_NAME)/src/configs/samples/lantiq.conf.sample \
		$(1)/etc/asterisk/lantiq.conf
	$(INSTALL_DIR) $(1)/usr/lib/asterisk/modules
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/$(PKG_NAME)/src/channels/chan_lantiq.so \
		$(1)/usr/lib/asterisk/modules
endef

Package/asterisk13-$(PKG_NAME)/install = $(Package/Install/Default)

define Package/postinst/Default
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
  echo
  echo "o-------------------------------------------------------------------o"
  echo "| chan-lantiq note                                                  |"
  echo "o-------------------------------------------------------------------o"
  echo "| Install kmod-ltq-vmmc if you want to use this Asterisk module.    |"
  echo "| Unfortunately the dependency could not be added to the package.   |"
  echo "o-------------------------------------------------------------=^_^=-o"
  echo
fi
exit 0
endef

Package/asterisk13-$(PKG_NAME)/postinst = $(Package/postinst/Default)

ifeq ($(BUILD_VARIANT),asterisk13)
CHAN_LANTIQ_AST_INCLUDES:=-I$(STAGING_DIR)/usr/include/asterisk-13/include
CHAN_LANTIQ_VERSION:=$(LANTIQ_AST13_VERSION)
endif

define Build/Prepare
	$(eval $(call Download/github,$(CHAN_LANTIQ_VERSION)))
	$(TAR) --extract --no-same-owner --no-same-permissions --xz \
		--file=$(DL_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)-$(CHAN_LANTIQ_VERSION).tar.xz \
		--directory=$(PKG_BUILD_DIR)
	$(eval $(call Download/files,ltq-ifxos,$(IFXOS_ARCHIVE),$(IFXOS_HASH),$(LTQ_MIRROR)))
	$(eval $(call Download/files,ltq-tapi,$(TAPI_ARCHIVE),$(TAPI_HASH),$(LTQ_MIRROR)))
	$(eval $(call Download/files,ltq-vmmc,$(VMMC_ARCHIVE),$(VMMC_HASH),$(LTQ_MIRROR)))
	$(TAR) --extract --no-same-owner --no-same-permissions --gzip \
		--file=$(DL_DIR)/$(IFXOS_ARCHIVE) \
		--directory=$(PKG_BUILD_DIR)
	$(TAR) --extract --no-same-owner --no-same-permissions --bzip \
		--file=$(DL_DIR)/$(TAPI_ARCHIVE) \
		--directory=$(PKG_BUILD_DIR)
	$(TAR) --extract --no-same-owner --no-same-permissions --bzip \
		--file=$(DL_DIR)/$(VMMC_ARCHIVE) \
		--directory=$(PKG_BUILD_DIR)
	$(call PatchDir,$(PKG_BUILD_DIR)/$(IFXOS),$(IFXOS_PATH)/patches)
	$(call PatchDir,$(PKG_BUILD_DIR)/$(TAPI),$(TAPI_PATH)/patches)
	$(call PatchDir,$(PKG_BUILD_DIR)/$(VMMC),$(VMMC_PATH)/patches)
	$(INSTALL_DIR) $(PKG_BUILD_DIR)/include
	$(CP) $(PKG_BUILD_DIR)/$(IFXOS)/src/include $(PKG_BUILD_DIR)/include/ifxos
	$(CP) $(PKG_BUILD_DIR)/$(TAPI)/include $(PKG_BUILD_DIR)/include/drv_tapi
	$(CP) $(PKG_BUILD_DIR)/$(VMMC)/include $(PKG_BUILD_DIR)/include/drv_vmmc
	cd $(PKG_BUILD_DIR)/include/drv_tapi && $(LN) ../ifxos/ifx_types.h .
	$(CP) ./files/default.exports \
		$(PKG_BUILD_DIR)/$(PKG_NAME)/src/channels/chan_lantiq.exports
endef

define Build/Configure
endef

# Mark our includes as a system directory, because that's where they would
# normally be. Not doing so results in redefinition warnings.
define Build/Compile
	cd $(PKG_BUILD_DIR)/$(PKG_NAME)/src/channels && \
	$(TARGET_CC) -o chan_lantiq.o -c chan_lantiq.c -MD -MT chan_lantiq.o \
		-MF .chan_lantiq.o.d -MP -pthread \
		$(TARGET_CFLAGS) \
		$(CHAN_LANTIQ_AST_INCLUDES) \
		$(TARGET_CPPFLAGS) \
		-isystem $(PKG_BUILD_DIR)/include \
		-Wall -Wstrict-prototypes -Wmissing-prototypes \
		-Wmissing-declarations $(FPIC) -DAST_MODULE=\"chan_lantiq\" && \
	$(TARGET_CC) -o chan_lantiq.so -pthread $(TARGET_LDFLAGS) -shared \
		-Wl,--version-script,chan_lantiq.exports,--warn-common \
		chan_lantiq.o
endef

$(eval $(call BuildPackage,asterisk13-$(PKG_NAME)))
