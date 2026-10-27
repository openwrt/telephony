include $(TOPDIR)/rules.mk

PKG_NAME:=baresip-apps
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/baresip/baresip-apps.git
PKG_SOURCE_VERSION:=45d835b68386484672268d24386cd8a25af21ef6
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_HASH:=8f453ff24a12e2ca68bf3ae7efd8ad0aae832d07c1cd29d8d79dfb8cccacf63f

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=docs/COPYING
PKG_MAINTAINER:=Daniel Danzberger <dd@embedd.com>

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/baresip-app/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  URL:=https://github.com/baresip/baresip-apps
endef

baresip-apps:= \
	auloop \
	autotest \
	b2bua \
	intercom \
	kaoptions \
	multicast \
	parcall \
	qualify \
	vidloop

empty:=
space:= $(empty) $(empty)

MODULES:=$(foreach m,$(baresip-apps),$(if $(CONFIG_PACKAGE_baresip-app-$(m)),$(m)))
MODULES:=$(strip $(MODULES))
MODULES:=$(subst $(space),;,$(MODULES))

CMAKE_OPTIONS += -DMODULES="$(MODULES)"

define BuildPlugin
  define Package/baresip-app-$(1)
    $$(call Package/baresip-app/Default)
    TITLE:=$(2)
    DEPENDS:=+baresip $(patsubst +%,+PACKAGE_$(PKG_NAME)-app-$(1):%,$(3))
  endef
  define Package/baresip-app-$(1)/install
	$(INSTALL_DIR) $$(1)/usr/lib/baresip/modules
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/baresip/modules/$(1).so \
			$$(1)/usr/lib/baresip/modules
  endef
  $$(eval $$(call BuildPackage,baresip-app-$(1)))
endef

$(eval $(call BuildPlugin,auloop,Audio Looping,))
$(eval $(call BuildPlugin,autotest,Auto Test Module,))
$(eval $(call BuildPlugin,b2bua,Back-to-Back User-Agent,))
$(eval $(call BuildPlugin,intercom,Intercom Module,))
$(eval $(call BuildPlugin,kaoptions,Keepalive via SIP OPTIONS message,))
$(eval $(call BuildPlugin,multicast,Mulitcast Support,))
$(eval $(call BuildPlugin,parcall,Parallel call module,))
$(eval $(call BuildPlugin,qualify,Pinging of peer in CALL_STATE_INCOMING via SIP OPTIONS,))
$(eval $(call BuildPlugin,vidloop,Video Loop,))
