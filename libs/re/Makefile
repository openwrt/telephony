#
# Copyright (C) 2010-2017 OpenWrt.org
# Copyright (C) 2010 Alfred E. Heggestad
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=re
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/baresip/re/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=bf0abfc511b7278462e7d54aaae39e7231b9f35423d5026c8210a322c7c8ef2f

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=docs/COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libre
  SUBMENU:=Telephony
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libopenssl +zlib
  TITLE:=Generic library for real-time communications with async IO support
  URL:=https://github.com/baresip/re
endef

# re.mk is used for this and all related packages (rem, restund and baresip).
# It relies on SYSROOT and SYSROOT_ALT being set. SYSROOT is used for finding
# toolchain headers (like pthread.h). SYSROOT_ALT is used for finding headers
# from other packages, like openssl etc.
#
# CFLAGS are picked up from the environment, as well as CPPFLAGS (and LD etc.).
# But LDFLAGS aren't picked up, so they need to be handed over via
# EXTRA_LFLAGS.
#
# LD is changed to TARGET_CC to fix build failures on x86 32bit. Without this
# there's no linking to ssp, which results in undefined references.

# used by 001-extend-ninit-nclose-check.patch
TARGET_CFLAGS+=-DOPENWRT

ifneq ($(CONFIG_USE_GLIBC)$(CONFIG_USE_MUSL),)
TARGET_CFLAGS+=-D_GNU_SOURCE
endif

MAKE_FLAGS+= \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	EXTRA_LFLAGS="$(TARGET_LDFLAGS)" \
	LD="$(TARGET_CC)" \
	OS=linux \
	RELEASE=1 \
	SYSROOT="$(shell $(FIND) $(TOOLCHAIN_DIR) -path '*/include/pthread.h' | sed -ne '1s|/include/pthread.h||p')" \
	SYSROOT_ALT="$(STAGING_DIR)/usr"

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/share/re
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/share/re/re.mk $(1)/usr/share/re
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/re $(1)/usr/include
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libre.{a,so} $(1)/usr/lib
endef

define Package/libre/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libre.so $(1)/usr/lib
endef

$(eval $(call BuildPackage,libre))
