# 
# Copyright (C) 2019 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=signalwire-client-c

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/signalwire/signalwire-c.git
PKG_SOURCE_DATE=2020-04-06
PKG_SOURCE_VERSION:=e2f3abf59c800c6d39234e9f0a85fb15d1486d8d
PKG_RELEASE:=1
PKG_MIRROR_HASH:=f70c6131fa7ea6291c31c543d1c8e77f5658d5a14f5d30b2d742fb6cb224f2ff

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
