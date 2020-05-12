# 
# Copyright (C) 2019 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=signalwire-client-c

PKG_VERSION:=1.3.0
PKG_RELEASE:=1

PKG_SOURCE:=signalwire-c-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/signalwire/signalwire-c/tar.gz/$(PKG_VERSION)?
PKG_HASH:=77bc7fbd8405283ef64ccbc22fba6687fc936ed76fafcc15e7e90290e2906884

PKG_BUILD_DIR:=$(BUILD_DIR)/signalwire-c-$(PKG_VERSION)

PKG_BUILD_PARALLEL:=1
CMAKE_INSTALL:=1

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=copyright

PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/$(PKG_NAME)
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=SignalWire C client library
  URL:=https://github.com/signalwire/signalwire-c
  ABI_VERSION:=1
  DEPENDS:=+libatomic +libks +libopenssl
endef

# Otherwise OpenWrt's CPPFLAGS are ignored
TARGET_CFLAGS += $(TARGET_CPPFLAGS)

define Package/$(PKG_NAME)/install/headers
	$(INSTALL_DIR) $(1)/usr/include/$(PKG_NAME)/$(2)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/include/$(PKG_NAME)/$(2)/*.h \
				$(1)/usr/include/$(PKG_NAME)/$(2)
endef

define Build/InstallDev
	$(foreach s,./ JSON blade signalwire transport,$(call Package/$(PKG_NAME)/install/headers,$(1),$(s));)
	$(INSTALL_DIR) $(1)/usr/lib/{cmake/$(PKG_NAME),pkgconfig}
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/$(PKG_NAME)/cmake/* \
		$(1)/usr/lib/cmake/$(PKG_NAME)
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsignalwire_client.so* $(1)/usr/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/signalwire_client.pc \
		$(1)/usr/lib/pkgconfig
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsignalwire_client.so.$(ABI_VERSION)* \
								$(1)/usr/lib
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
