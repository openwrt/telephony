# 
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pwlib
PKG_VERSION:=1_11_1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-v$(PKG_VERSION)-src.tar.gz
PKG_SOURCE_URL:=@SF/openh323/
PKG_MD5SUM:=8b7a7a2ed8da6792006922476dd3b2f3

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)_v$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/pwlib
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=Portable Windows library
  URL:=http://www.voxgratia.org/
endef

define Package/pwlib/description
 PWLib is a moderately large class library that was created as a method to 
 produce applications that run on both Microsoft Windows and the X Window 
 System.
endef

TARGET_CFLAGS += $(FPIC) -fpermissive

CONFIGURE_ARGS += \
	--enable-minsize \
	--enable-openh323 \
	--enable-opal \
	--disable-internalregex \
	--disable-plugins \
	--enable-audio \
	--disable-alsa \
	--enable-asn \
	--disable-avc \
	--disable-dc \
	--disable-dtmf \
	--disable-expat \
	--disable-ftp \
	--enable-http \
	--disable-httpsvc \
	--disable-jabber \
	--disable-openldap \
	--disable-openssl \
	--disable-oss \
	--disable-pipechan \
	--disable-pop3smtp \
	--disable-remconn \
	--disable-resolver \
	--disable-qos \
	--disable-sasl \
	--disable-sdl \
	--disable-serial \
	--disable-shm-video \
	--disable-snmp \
	--disable-soap \
	--disable-socks \
	--enable-stun \
	--disable-telnet \
	--disable-tts \
	--disable-v4l \
	--disable-v4l2 \
	--disable-bsdvideo \
	--disable-video \
	--disable-vxml \
	--disable-wavfile \
	--disable-xmlrpc

CONFIGURE_VARS += \
	STDCXXFLAGS="$(TARGET_CFLAGS) -fno-builtin"

MAKE_FLAGS += optnoshared

define Build/InstallDev
	ln -sf $(PKG_NAME)_v$(PKG_VERSION) $(BUILD_DIR)/$(PKG_NAME)
	$(SED) 's|//\(#include <ptlib/sound.h>\)|\1|' $(PKG_BUILD_DIR)/include/ptlib.h
endef

$(eval $(call BuildPackage,pwlib))
