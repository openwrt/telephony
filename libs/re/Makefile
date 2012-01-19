# 
# Copyright (C) 2010-2011 OpenWrt.org
# Copyright (C) 2010 Alfred E. Heggestad
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=re
PKG_VERSION:=0.4.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.creytiv.com/pub
PKG_MD5SUM:=77469714212b40ec7f224ad8648f91d2

include $(INCLUDE_DIR)/package.mk

define Package/libre
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libopenssl +libpthread
  TITLE:=Generic library for real-time communications with async IO support
  URL:=http://www.creytiv.com/
endef

TARGET_CFLAGS += $(FPIC)

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		HAVE_LIBRESOLV= \
		CC="$(TARGET_CC)" \
		EXTRA_CFLAGS="$(TARGET_CFLAGS) -DOPENWRT" \
		EXTRA_LFLAGS="-lm" \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		SYSROOT="$$$$(echo '#include <pthread.h>' | $(TARGET_CROSS)cpp -x c | sed -ne 's,^# [0-9]* \"\(.*\)/include/pthread\.h\".*,\1,p' | head -n1)" \
		SYSROOT_ALT="$(STAGING_DIR)/usr" \
		RELEASE=1 \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		OS=linux \
		all install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/share/re
	$(CP) $(PKG_BUILD_DIR)/mk/re.mk $(1)/usr/share/re/
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/re $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libre.{a,so} $(1)/usr/lib/
endef

define Package/libre/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libre.so $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libre))
