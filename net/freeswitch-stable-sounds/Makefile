#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=freeswitch-stable-sounds

PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_MAINTAINER:=Sebastian Kemper <sebastian_ml@gmx.net>

PKG_LICENSE:=MPL-1.1

PRG_URL:=https://files.freeswitch.org/releases/sounds

include $(INCLUDE_DIR)/package.mk

SOUNDS_DIR:=/usr/share/freeswitch/sounds

define Package/$(PKG_NAME)/Default
  SUBMENU:=Telephony
  SECTION:=net
  CATEGORY:=Network
  URL:=https://www.freeswitch.org
  DEPENDS:=freeswitch-stable
  PKGARCH:=all
endef

define Package/$(PKG_NAME)/Sounds
define Package/$(PKG_NAME)-$(1)
$(call Package/$(PKG_NAME)/Default)
  TITLE:=$(2)
  VERSION:=$(6)-$(PKG_RELEASE)
ifneq ($(5),8)
  DEPENDS+=@BROKEN
endif
endef
define Download/$(PKG_NAME)-$(1)
  FILE:=freeswitch-sounds-$(1)-$(6).tar.gz
  URL:=$(PRG_URL)
  MD5SUM:=$(7)
endef
define Package/$(PKG_NAME)-$(1)/description
$(2)
Speaker: $(3)
Locale: $(4)
Frequency: $(5) kHz
endef
define Package/$(PKG_NAME)-$(1)/install
	$(INSTALL_DIR) $$(1)$(SOUNDS_DIR)
	$(TAR) --extract --no-same-owner --no-same-permissions --gzip \
		--file=$(DL_DIR)/freeswitch-sounds-$(1)-$(6).tar.gz \
		--directory=$$(1)$(SOUNDS_DIR)
	$(FIND) $$(1)$(SOUNDS_DIR) -type d -exec chmod 755 {} \;
	$(FIND) $$(1)$(SOUNDS_DIR) -type f -exec chmod 644 {} \;
endef
ifneq ($(CONFIG_PACKAGE_$(PKG_NAME)-$(1)),)
$$(eval $$(call Download,$(PKG_NAME)-$(1)))
endif
$$(eval $$(call BuildPackage,$(PKG_NAME)-$(1)))
endef

define Build/Prepare
endef

define Build/Compile
endef

################################
# FreeSWITCH sound packs
# Params:
# 1 - Package subname
# 2 - Package content
# 3 - Speaker
# 4 - Locale
# 5 - Frequency
# 6 - Source version
# 7 - Source SHA256SUM
################################

$(eval $(call Package/$(PKG_NAME)/Sounds,en-ca-june-8000,Sound prompts,June,en-CA,8,1.0.51,9aaa9d73cfecfdab7a1fa2d63d65b922b86a405ebb9a31b09b15e58a2af9260a))
$(eval $(call Package/$(PKG_NAME)/Sounds,en-ca-june-16000,Sound prompts,June,en-CA,16,1.0.51,8d0091a2c98e5e06afea6bdd9f6cf2942e937786016037207b85757218b0f7a7))
$(eval $(call Package/$(PKG_NAME)/Sounds,en-ca-june-32000,Sound prompts,June,en-CA,32,1.0.51,8720b363995724792ff4723e1c8218ef95b27cb36208b7258f93bdda72123387))
$(eval $(call Package/$(PKG_NAME)/Sounds,en-ca-june-48000,Sound prompts,June,en-CA,48,1.0.51,d2fce478a95b8d9500a544a00253c81d7e9f639e21980bd689910fac87f30871))
$(eval $(call Package/$(PKG_NAME)/Sounds,en-us-callie-8000,Sound prompts,Callie,en-US,8,1.0.51,e48a63bd69e6253d294ce43a941d603b02467feb5d92ee57a536ccc5f849a4a8))
$(eval $(call Package/$(PKG_NAME)/Sounds,en-us-callie-16000,Sound prompts,Callie,en-US,16,1.0.51,324b1ab5ab754db5697963e9bf6a2f9c7aeb1463755e86bbb6dc4d6a77329da2))
$(eval $(call Package/$(PKG_NAME)/Sounds,en-us-callie-32000,Sound prompts,Callie,en-US,32,1.0.51,06fd6b8aec937556bf5303ab19a212c60daf00546d395cf269dfe324ac9c6838))
$(eval $(call Package/$(PKG_NAME)/Sounds,en-us-callie-48000,Sound prompts,Callie,en-US,48,1.0.51,cfc50f1d9b5d43cb87a9a2c0ce136c37ee85ac3b0e5be930d8dc2c913c4495aa))
$(eval $(call Package/$(PKG_NAME)/Sounds,fr-ca-june-8000,Sound prompts,June,fr-CA,8,1.0.51,eada67c61bd62ec420eb017df7524d10de286fba0c2da4800516b9f62c00e78c))
$(eval $(call Package/$(PKG_NAME)/Sounds,fr-ca-june-16000,Sound prompts,June,fr-CA,16,1.0.51,f942980ad359951ef3f69a324a3299ef86cdb4f8d2c62adaf73a1b95fb39fcc6))
$(eval $(call Package/$(PKG_NAME)/Sounds,fr-ca-june-32000,Sound prompts,June,fr-CA,32,1.0.51,8966a0c4daf666018cca6d8ba0f7708e251bed952b015d0ca6a0792341fe531b))
$(eval $(call Package/$(PKG_NAME)/Sounds,fr-ca-june-48000,Sound prompts,June,fr-CA,48,1.0.51,abaea558fb5485abdd01d0b1186e03cf508f96ac90492814cc7ed4475e99a1e0))
$(eval $(call Package/$(PKG_NAME)/Sounds,music-8000,Music on Hold,,,8,1.0.52,2491dcb92a69c629b03ea070d2483908a52e2c530dd77791f49a45a4d70aaa07))
$(eval $(call Package/$(PKG_NAME)/Sounds,music-16000,Music on Hold,,,16,1.0.52,93e0bf31797f4847dc19a94605c039ad4f0763616b6d819f5bddbfb6dd09718a))
$(eval $(call Package/$(PKG_NAME)/Sounds,music-32000,Music on Hold,,,32,1.0.52,4129788a638b77c5f85ff35abfcd69793d8aeb9d7833a75c74ec77355b2657a9))
$(eval $(call Package/$(PKG_NAME)/Sounds,music-48000,Music on Hold,,,48,1.0.52,cc31cdb5b1bd653850bf6e054d963314bcf7c1706a9bf05f5a69bcbd00858d2a))
$(eval $(call Package/$(PKG_NAME)/Sounds,pl-pl-espeak-8000,Sound prompts,espeak,pl-PL,8,0.1.0,4bc7a772edde56d76f618fe4b33d71e47314cf36fc632c94a22d34dd581cbfc0))
$(eval $(call Package/$(PKG_NAME)/Sounds,pl-pl-espeak-16000,Sound prompts,espeak,pl-PL,16,0.1.0,824f28092913e3be8a042347b20bf0c425c7889de54cfa0740767c1431e66a93))
$(eval $(call Package/$(PKG_NAME)/Sounds,pt-BR-karina-8000,Sound prompts,Karina,pr-BR,8,1.0.51,ba9b5d7f97675c560823a6f94804a6716dac66efe203dd1779952518c3944a77))
$(eval $(call Package/$(PKG_NAME)/Sounds,pt-BR-karina-16000,Sound prompts,Karina,pr-BR,16,1.0.51,80432c1027f57e464cd899ed92216936cf48a3993dc1c168b1be2545b8f97aed))
$(eval $(call Package/$(PKG_NAME)/Sounds,pt-BR-karina-32000,Sound prompts,Karina,pr-BR,32,1.0.51,e80a8653585cf9a4fe9cf1c0004279602542d15894ba13f2104d990cefdee567))
$(eval $(call Package/$(PKG_NAME)/Sounds,pt-BR-karina-48000,Sound prompts,Karina,pr-BR,48,1.0.51,51ef9cac2dc4dd70d81c18f8e65bfd11de44207e8fac9961a68aa0d50d539870))
$(eval $(call Package/$(PKG_NAME)/Sounds,ru-RU-elena-8000,Sound prompts,Elena,ru-RU,8,1.0.51,d2679503eb1f4dc1716df5f8c4b5a7b721f087b17e96a02b1a92480311074c66))
$(eval $(call Package/$(PKG_NAME)/Sounds,ru-RU-elena-16000,Sound prompts,Elena,ru-RU,16,1.0.51,e5a354cd10401208291f1d0e668a8cf8215d3cdcb93f2cbd4b83dd134425e60b))
$(eval $(call Package/$(PKG_NAME)/Sounds,ru-RU-elena-32000,Sound prompts,Elena,ru-RU,32,1.0.51,a2b43f20246f376d55dd73d269eb238cbeb6a961a40716d2f79a5835344aabfc))
$(eval $(call Package/$(PKG_NAME)/Sounds,ru-RU-elena-48000,Sound prompts,Elena,ru-RU,48,1.0.51,ffd7d34907f6b6ac861e7898d2237ad763f242a17cd23811da28fd7745d3350d))
$(eval $(call Package/$(PKG_NAME)/Sounds,sv-se-jakob-8000,Sound prompts,Jakob,sv-SE,8,1.0.50,aa81c97b2954b36d5625d556d2c6764ee79d0c925284ba5ff4c60cb479936b48))
$(eval $(call Package/$(PKG_NAME)/Sounds,sv-se-jakob-16000,Sound prompts,Jakob,sv-SE,16,1.0.50,52da670c651ff598815aed655644b44b891ee158f4c67d048da90056a36ddcf6))
$(eval $(call Package/$(PKG_NAME)/Sounds,sv-se-jakob-32000,Sound prompts,Jakob,sv-SE,32,1.0.50,160de01069afa827c830595e521b53d95de4b415b48061fb843a1c4025fa17f2))
$(eval $(call Package/$(PKG_NAME)/Sounds,sv-se-jakob-48000,Sound prompts,Jakob,sv-SE,48,1.0.50,059889d75926b8e1f39e8d2c33f0e8f744a43c094bbe213a1caa9f26ae9a2799))
$(eval $(call Package/$(PKG_NAME)/Sounds,zh-cn-sinmei-8000,Sound prompts,Sinmei,zh-CN,8,1.0.51,764985f39313426ef4a0ea4dd848f05faaced37b91b2c9a22f17d3f77235fae3))
$(eval $(call Package/$(PKG_NAME)/Sounds,zh-cn-sinmei-16000,Sound prompts,Sinmei,zh-CN,16,1.0.51,d849a5818ac6630d7c572d728dcd48176a6877defd8c239cb12011528e95c2cd))
$(eval $(call Package/$(PKG_NAME)/Sounds,zh-cn-sinmei-32000,Sound prompts,Sinmei,zh-CN,32,1.0.51,903fda016d2ac053ffe6bc2d4eaf816a66c8043ddc3383d48b7b14335d9ea98e))
$(eval $(call Package/$(PKG_NAME)/Sounds,zh-cn-sinmei-48000,Sound prompts,Sinmei,zh-CN,48,1.0.51,95b9064acec13a0a32b15ea0b44dc408094b4d9dee84b183c5d9150a77e9bb23))
$(eval $(call Package/$(PKG_NAME)/Sounds,zh-hk-sinmei-8000,Sound prompts,Sinmei,zh-HK,8,1.0.51,917d08c80969bdaf30f2a63a3b69f542b143614d42c6241503ac655d13864eb0))
$(eval $(call Package/$(PKG_NAME)/Sounds,zh-hk-sinmei-16000,Sound prompts,Sinmei,zh-HK,16,1.0.51,0950e1d971b4f2ba4decd949406ccd0198fe9c686f246e175c70aafdf9783f30))
$(eval $(call Package/$(PKG_NAME)/Sounds,zh-hk-sinmei-32000,Sound prompts,Sinmei,zh-HK,32,1.0.51,97d846ab06b5c84d2c46bec64560556acbfc88eb2080bd325b2c5259a5ae80d0))
$(eval $(call Package/$(PKG_NAME)/Sounds,zh-hk-sinmei-48000,Sound prompts,Sinmei,zh-HK,48,1.0.51,bd605be7e536e11f8f67229a95513ef3f177263587c5bca75ccae647f43962a1))
