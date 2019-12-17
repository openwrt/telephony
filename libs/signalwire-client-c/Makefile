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
PKG_SOURCE_DATE=2019-09-20
PKG_SOURCE_VERSION:=4729b1552e5f3d8a414f5769f5ca85b4e7572305
PKG_RELEASE:=1
PKG_MIRROR_HASH:=eef97655caf076d35ee51b23de6a41b76becb6bf951348b9f981c35bb807d803

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
