#
# Copyright (C) 2006-2018 OpenWrt.org
# Copyright (C) 2016 Cesnet, z.s.p.o.
# Copyright (C) 2017 - 2018 Jiri Slachta <jiri@slachta.eu>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pjproject
PKG_VERSION:=2.10
PKG_RELEASE:=4

# download "vX.Y.tar.gz" as "pjproject-vX.Y.tar.gz"
PKG_SOURCE_URL_FILE:=$(PKG_VERSION).tar.gz
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_URL_FILE)
PKG_SOURCE_URL:=https://github.com/pjsip/$(PKG_NAME)/archive
PKG_HASH:=936a4c5b98601b52325463a397ddf11ab4106c6a7b04f8dc7cdd377efbb597de
PKG_INSTALL:=1

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Jiri Slachta <jiri@slachta.eu>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_CONFIG_DEPENDS:=CONFIG_SOFT_FLOAT

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk

define Package/pjproject/Default
  SECTION:=lib
  CATEGORY:=Libraries
  SUBMENU:=Telephony
  URL:=https://www.pjsip.org
  DEPENDS:=$(CXX_DEPENDS) +libopenssl +libuuid +libpthread
endef

define Package/pjproject/install/lib
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(2).so* $(1)/usr/lib
endef

define PJSIPpackage
  define Package/$(1)
  $$(call Package/pjproject/Default)
    TITLE:=$(1) library
    DEPENDS+=$(3)
  endef

  define Package/$(1)/install
$(call Package/pjproject/install/lib,$$(1),$2)
  endef

  $$(eval $$(call BuildPackage,$(1)))
endef

CONFIGURE_ARGS+= \
	$(if $(CONFIG_SOFT_FLOAT),--disable-floating-point) \
	--disable-bcg729 \
	--disable-darwin-ssl \
	--disable-ext-sound \
	--disable-ffmpeg \
	--disable-g711-codec \
	--disable-g722-codec \
	--disable-g7221-codec \
	--disable-gsm-codec \
	--disable-ilbc-codec \
	--disable-ipp \
	--disable-l16-codec \
	--disable-libwebrtc \
	--disable-libyuv \
	--disable-opencore-amr \
	--disable-openh264 \
	--disable-opus \
	--disable-resample \
	--disable-sdl \
	--disable-silk \
	--disable-sound \
	--disable-speex-aec \
	--disable-speex-codec \
	--disable-v4l2 \
	--disable-video \
	--enable-shared \
	--with-external-srtp="$(STAGING_DIR)/usr" \
	--with-ssl="$(STAGING_DIR)/usr" \
	--without-external-gsm \
	--without-external-pa \
	--without-external-webrtc

TARGET_CFLAGS+=$(TARGET_CPPFLAGS)

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) dep
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)
endef

PJPROJECT_LIBS:= \
	libpj libpjlib-util libpjmedia libpjnath libpjsip-simple \
	libpjsip-ua libpjsip libpjsua libpjsua2

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/{include,lib}
	
	$(CP) -R $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include

	$(foreach m,$(PJPROJECT_LIBS),$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(m)* $(1)/usr/lib;)

	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(SED) 's|$(TARGET_CFLAGS)||g' $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libpjproject.pc
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libpjproject.pc \
		$(1)/usr/lib/pkgconfig
endef

$(eval $(call PJSIPpackage,libpj,libpj,+librt))
$(eval $(call PJSIPpackage,libpjlib-util,libpjlib-util,+libpj +librt))
$(eval $(call PJSIPpackage,libpjmedia,libpjmedia*,+libpj +libpjlib-util +libpjnath +librt +libsrtp2))
$(eval $(call PJSIPpackage,libpjnath,libpjnath,+libpj +libpjlib-util +librt))
$(eval $(call PJSIPpackage,libpjsip-simple,libpjsip-simple,+libpj +libpjlib-util +libpjsip +librt))
$(eval $(call PJSIPpackage,libpjsip-ua,libpjsip-ua,+libpj +libpjlib-util +libpjmedia +libpjsip-simple +libpjsip +librt))
$(eval $(call PJSIPpackage,libpjsip,libpjsip,+libpj +libpjlib-util +librt +libsrtp2))
$(eval $(call PJSIPpackage,libpjsua,libpjsua,+libpj +libpjlib-util +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsip +librt))
$(eval $(call PJSIPpackage,libpjsua2,libpjsua2,+libpj +libpjlib-util +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsip +librt +libpjsua))
