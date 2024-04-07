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
PKG_MIRROR_HASH:=563050f47c7962de377cab17478a86d3ea6726a331a7c77be62cb3f5488e519a
PKG_SOURCE_VERSION:=157
PKG_SOURCE_DATE=2020-03-03
PKG_RELEASE:=1

PKG_LICENSE:=GPL-2.0+
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/pcapsipdump
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Telephony
  DEPENDS:=+libstdcpp +USE_GLIBC:libbsd +libpcap
  TITLE:=SIP Sessions Dumping Tool
  URL:=http://sourceforge.net/projects/pcapsipdump/
endef

define Package/pcapsipdump/description
 pcapsipdump is a tool for dumping SIP sessions (plus RTP traffic, if
 available) to disk in a fashion similar to "tcpdump -w" (format is
 exactly the same), but one file per SIP session (even if there are
 thousands of concurrent SIP sessions).
endef

MAKE_FLAGS+=LIBS="-lpcap"

define Package/pcapsipdump/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/pcapsipdump $(1)/usr/bin/
endef

$(eval $(call BuildPackage,pcapsipdump))
