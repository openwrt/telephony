#
# Copyright (C) 2015 OpenWrt.org
# Copyright (C) 2015 Cesnet, z.s.p.o.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pjproject
PKG_VERSION:=2.4
PKG_RELEASE:=1

PKG_SOURCE:=pjproject-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.pjsip.org/release/$(PKG_VERSION)/
PKG_MD5SUM:=39629ca3fcedbdc7dbd8c5a707060095
PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Jiri Slachta <slachta@cesnet.cz>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/pjproject/Default
  SECTION:=lib
  CATEGORY:=Libraries
  SUBMENU:=Telephony
  URL:=http://www.pjsip.org/
  DEPENDS:=+libuuid +libstdcpp +libpthread
endef

define Package/pjproject/install/lib
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/$(2).so* $(1)/usr/lib/
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

CONFIGURE_ARGS += \
	--enable-shared \
	--disable-floating-point \
	--enable-g711-codec \
	--disable-l16-codec \
	--disable-g722-codec \
	--disable-g7221-codec \
	--disable-gsm-codec \
	--disable-ilbc-coder \
	--disable-ipp \
	--disable-ssl \
	--disable-oss \
	--disable-sound \
	--with-external-srtp="$(STAGING_DIR)/usr" \
	--without-external-gsm \
	--disable-small-filter \
	--disable-large-filter \
	--disable-speex-aec \
	--disable-g711-codec \
	--disable-l16-codec \
	--disable-gsm-codec \
	--disable-g722-codec \
	--disable-g7221-codec \
	--disable-speex-codec \
	--disable-ilbc-codec \
	--disable-resample-dll \
	--disable-sdl \
	--disable-ffmpeg \
	--disable-v4l2

TARGET_LDFLAGS+=-lc $(LIBGCC) -lm
TARGET_CFLAGS+=$(EXTRA_CFLAGS) $(TARGET_CPPFLAGS) $(EXTRA_CPPFLAGS)

define Build/Compile
	$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR)
endef

PJPROJECT_LIBS = \
	libpj libpjlib-util libpjmedia-audiodev libpjmedia-codec \
	libpjmedia-videodev libpjmedia libpjnath libpjsip-simple \
	libpjsip-ua libpjsip libpjsua libpjsua2 libresample

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/{include,lib}
	
	$(CP) -R $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/

	$(foreach m,$(PJPROJECT_LIBS),$(CP) $(PKG_INSTALL_DIR)/usr/lib/$(m)* $(1)/usr/lib/;)
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libpjproject.pc $(1)/usr/lib/pkgconfig/
endef

$(eval $(call PJSIPpackage,libpj,libpj,+librt))
$(eval $(call PJSIPpackage,libpjlib-util,libpjlib-util,+libpj +librt))
$(eval $(call PJSIPpackage,libpjmedia,libpjmedia*,+libpj +libpjlib-util +libpjnath +libresample +librt +libspeex +libsrtp))
$(eval $(call PJSIPpackage,libpjnath,libpjnath,+libpj +libpjlib-util +librt))
$(eval $(call PJSIPpackage,libpjsip-simple,libpjsip-simple,+libpj +libpjlib-util +libpjsip +libresample +librt +libspeex +libsrtp))
$(eval $(call PJSIPpackage,libpjsip-ua,libpjsip-ua,+libpj +libpjlib-util +libpjmedia +libpjsip-simple +libpjsip +libresample +librt +libspeex +libsrtp))
$(eval $(call PJSIPpackage,libpjsip,libpjsip,+libpj +libpjlib-util +libresample +librt +libspeex +libsrtp))
$(eval $(call PJSIPpackage,libpjsua,libpjsua,+libpj +libpjlib-util +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsip +libresample +librt +libspeex +libsrtp))
$(eval $(call PJSIPpackage,libpjsua2,libpjsua2,+libpj +libpjlib-util +libpjmedia +libpjnath +libpjsip-simple +libpjsip-ua +libpjsip +libresample +librt +libspeex +libsrtp +libpjsua))
$(eval $(call PJSIPpackage,libresample,libresample,))
