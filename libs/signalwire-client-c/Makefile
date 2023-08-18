# 
# Copyright (C) 2019 Sebastian Kemper <sebastian_ml@gmx.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=signalwire-client-c

PKG_VERSION:=2.0.0
PKG_RELEASE:=1

PKG_SOURCE:=signalwire-c-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/signalwire/signalwire-c/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=7916ad76b2c2c75ff616d19bf044894771b3f8602b80a6f74d8ba26206faef79

PKG_BUILD_DIR:=$(BUILD_DIR)/signalwire-c-$(PKG_VERSION)

PKG_BUILD_PARALLEL:=1
CMAKE_INSTALL:=1

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=copyright

PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/signalwire-client-c
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=SignalWire C client library
  URL:=https://github.com/signalwire/signalwire-c
  ABI_VERSION:=2
  DEPENDS:=+libatomic +libks +libopenssl
endef

# Otherwise OpenWrt's CPPFLAGS are ignored
TARGET_CFLAGS += $(TARGET_CPPFLAGS)

define Package/signalwire-client-c/install/headers
	$(INSTALL_DIR) $(1)/usr/include/signalwire-client-c2/signalwire-client-c/$(2)
	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/include/signalwire-client-c2/signalwire-client-c/$(2)/*.h \
				$(1)/usr/include/signalwire-client-c2/signalwire-client-c/$(2)
endef

define Build/InstallDev
	$(foreach s,./ JSON blade signalwire transport,$(call Package/signalwire-client-c/install/headers,$(1),$(s));)
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig \
		$(1)/usr/include/signalwire-client-c2/signalwire-client-c/cmake
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/signalwire-client-c2/signalwire-client-c/cmake/* \
		$(1)/usr/include/signalwire-client-c2/signalwire-client-c/cmake
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsignalwire_client2.so* $(1)/usr/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/signalwire_client2.pc \
		$(1)/usr/lib/pkgconfig
endef

define Package/signalwire-client-c/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsignalwire_client2.so.$(ABI_VERSION)* \
								$(1)/usr/lib
endef

$(eval $(call BuildPackage,signalwire-client-c))
