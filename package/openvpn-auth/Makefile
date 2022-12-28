#
# Copyright (C) 2010-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openvpn-auth

PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_MAINTAINER:=Bruce CHEN <a805899926@gmail.com>

PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/openvpn-auth
  TITLE:=Open source VPN solution for auth
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  MENU:=1
endef

define Package/openvpn-auth/install
	$(INSTALL_DATA) \
		files/auth.sh \
		/etc/openvpn/auth.sh
endef

$(eval $(call BuildPackage,openvpn-auth))
