#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sipp
PKG_VERSION:=3.3.990
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/sipp
PKG_MD5SUM:=904fffbc277bafce28762ebb041b9620
PKG_CHECK_FORMAT_SECURITY:=0

PKG_LICENSE:=GPL-2.0+ BSD-3-Clause Zlib
PKG_LICENSE_FILES:=LICENSE.txt

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk

define Package/sipp
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  DEPENDS:= +libncurses +libpthread $(CXX_DEPENDS)
  TITLE:=test tool / traffic generator for the SIP protocol
  URL:=http://sipp.sourceforge.net/
endef

define Package/sipp/description
 SIPp is a free Open Source test tool / traffic generator for the SIP
 protocol. It includes a few basic SipStone user agent scenarios (UAC and
 UAS) and establishes and releases multiple calls with the INVITE and BYE
 methods.
endef

TAR_CMD:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components 1 $(TAR_OPTIONS)

CONFIGURE_ARGS+= \
	--build=$(GNU_HOST_NAME) \
	--host=$(GNU_TARGET_NAME) \
	--target=$(GNU_TARGET_NAME) \
	--enable-epoll \
	--without-gsl \
	--without-pcap \
	--with-rtpstream \
	--without-sctp

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
		CC_linux="$(TARGET_CXX)" \
		CPP_linux="$(TARGET_CXX)" \
		CCLINK_linux="$(TARGET_CXX)" \
		CFLAGS="$(TARGET_CFLAGS)" \
		CPPFLAGS_linux="$(TARGET_CPPFLAGS) -fno-rtti" \
		LFLAGS_linux="$(TARGET_LDFLAGS)" \
		LIBS="-lncurses -ldl -lpthread -lm" \
		all
endef

define Package/sipp/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/sipp $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,sipp))
