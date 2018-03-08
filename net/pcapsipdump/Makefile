#
# Copyright (C) 2009-2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pcapsipdump
PKG_VERSION:=0.2
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/pcapsipdump
PKG_HASH:=4d4dc2664963c08de40da47ca0dcd1eeae09edc42241bd6daa7ff8c59089dce9

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk

define Package/pcapsipdump
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  DEPENDS:=+libpcap $(CXX_DEPENDS)
  TITLE:=SIP sessions dumping tool
  URL:=http://sourceforge.net/projects/pcapsipdump/
endef

define Package/pcapsipdump/description
 pcapsipdump is a tool for dumping SIP sessions (+RTP traffic, if available) to disk in a
 fashion similar to "tcpdump -w" (format is exactly the same), but one file per sip session
 (even if there is thousands of concurrect SIP sessions).
endef

MAKE_FLAGS += \
	CC="$(TARGET_CXX)" \
	CPPFLAGS="$(TARGET_CXXFLAGS) -fno-rtti $(TARGET_CPPFLAGS)" \
	LIBS="-lpcap"

define Package/pcapsipdump/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/pcapsipdump $(1)/usr/bin/
endef

$(eval $(call BuildPackage,pcapsipdump))
