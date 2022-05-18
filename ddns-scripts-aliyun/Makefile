include $(TOPDIR)/rules.mk

PKG_NAME:=ddns-scripts-aliyun
PKG_VERSION:=1.0.3
PKG_RELEASE:=1

PKG_LICENSE:=GPLv2
PKG_MAINTAINER:=Sense <sensec@gmail.com>

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ddns-scripts-aliyun
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=DDNS extension for AliYun.com
  PKGARCH:=all
  DEPENDS:=+ddns-scripts +wget +openssl-util
endef

define Package/ddns-scripts-aliyun/description
  Dynamic DNS Client scripts extension for AliYun.com
endef

define Package/ddns-scripts-aliyun/install
	$(INSTALL_DIR) $(1)/usr/lib/ddns
	$(INSTALL_BIN) ./update_aliyun_com.sh $(1)/usr/lib/ddns
endef

$(eval $(call BuildPackage,ddns-scripts-aliyun))
