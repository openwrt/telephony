#
# Copyright (C) 2009-2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pcapsipdump

PKG_SOURCE_PROTO:=svn
PKG_SOURCE_URL:=https://svn.code.sf.net/p/pcapsipdump/code/trunk
PKG_SOURCE_VERSION:=151
PKG_SOURCE_DATE=2019-10-07
PKG_RELEASE:=2
PKG_MIRROR_HASH:=a029b29946f0492220fc9c60ef3e7f0a7a0c660f0047957eab6802ae6b9f9ed4

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk

define Package/pcapsipdump
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  DEPENDS:=$(CXX_DEPENDS) +USE_GLIBC:libbsd +libpcap
  TITLE:=SIP sessions dumping tool
  URL:=http://sourceforge.net/projects/pcapsipdump/
endef

define Package/pcapsipdump/description
 pcapsipdump is a tool for dumping SIP sessions (+RTP traffic, if available) to disk in a
 fashion similar to "tcpdump -w" (format is exactly the same), but one file per sip session
 (even if there is thousands of concurrect SIP sessions).
endef

MAKE_FLAGS+=LIBS="-lpcap"

define Package/pcapsipdump/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/pcapsipdump $(1)/usr/bin/
endef

$(eval $(call BuildPackage,pcapsipdump))
