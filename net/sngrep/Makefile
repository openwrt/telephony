#
# Copyright (C) 2016 Daniel Engberg <daniel.engberg.lists@pyret.net>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sngrep

PKG_VERSION:=1.4.8
PKG_RELEASE:=1

PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>
PKG_LICENSE:=GPL-3.0+
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/irontec/sngrep/releases/download/v$(PKG_VERSION)
PKG_HASH:=f39fded8dc9ef0b7a41319f223dd4afa348bb2418bea578ed281557726829728

PKG_RELEASE:=1

PKG_MIRROR_HASH:=94e150cabe3efc6f07d05e3ee348806a0a8fa9335d27dfddce477988b946ed8f

PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

PKG_CONFIG_DEPENDS:=CONFIG_IPV6 CONFIG_SNGREP_ENABLE_EEP CONFIG_SNGREP_WITH_PCRE

include $(INCLUDE_DIR)/package.mk

define Package/sngrep
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Telephony
  DEPENDS:=+libncursesw +libopenssl +libpcap +SNGREP_WITH_PCRE:libpcre
  TITLE:=Ncurses SIP messages flow viewer
  URL:=https://github.com/irontec/sngrep
endef

define Package/sngrep/description
sngrep is a tool for displaying SIP calls message flows from terminal.

It supports live capture to display realtime SIP packets and can also be
used as PCAP viewer.
endef

define Package/sngrep/conffiles
/etc/sngreprc
endef

define Package/sngrep/config
  menu "sngrep configuration"
    depends on PACKAGE_sngrep

    config SNGREP_ENABLE_EEP
      bool "EEP/HEP support"
      default y
      help
        Enable EEP/HEP support

    config SNGREP_WITH_PCRE
      bool "PCRE support"
      default y
      help
        Enable Perl compatible regular expressions
  endmenu
endef

CONFIGURE_ARGS += \
	--$(if $(CONFIG_SNGREP_ENABLE_EEP),en,dis)able-eep \
	--$(if $(CONFIG_IPV6),en,dis)able-ipv6 \
	--enable-unicode \
	--with-openssl \
	--with$(if $(CONFIG_SNGREP_WITH_PCRE),,out)-pcre

define Package/sngrep/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/sngreprc $(1)/etc
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/sngrep $(1)/usr/bin
endef

$(eval $(call BuildPackage,sngrep))
