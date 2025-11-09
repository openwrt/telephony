#
# Copyright (C) 2013-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sipp
PKG_VERSION:=3.7.5
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/SIPp/sipp/releases/download/v$(PKG_VERSION)
PKG_HASH:=0d202f562fcc9f5aee578d5e9383fb321a69e1b04f1785757eccfba2fc5eeefe

PKG_LICENSE:=GPL-2.0+ BSD-3-Clause Zlib
PKG_LICENSE_FILES:=LICENSE.txt

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_INSTALL:=1

define Package/sipp
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  DEPENDS:=+libstdcpp +libncurses +libpcap +libpthread
  TITLE:=test tool / traffic generator for the SIP protocol
  URL:=http://sipp.sourceforge.net/
endef

define Package/sipp/description
 SIPp is a free Open Source test tool / traffic generator for the SIP
 protocol. It includes a few basic SipStone user agent scenarios (UAC and
 UAS) and establishes and releases multiple calls with the INVITE and BYE
 methods.
endef

# Otherwise OpenWrt's CPPFLAGS are ignored
TARGET_CFLAGS += $(TARGET_CPPFLAGS)

# Use "common" options, see build.sh (we don't have gsl though)
CMAKE_OPTIONS += \
	-DUSE_GSL= \
	-DUSE_PCAP=1 \
	-DUSE_SCTP= \
	-DUSE_SSL=

define Package/sipp/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/sipp $(1)/usr/bin
endef

$(eval $(call BuildPackage,sipp))
