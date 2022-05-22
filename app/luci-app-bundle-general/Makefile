# This is free software, licensed under the Apache License, Version 2.0 .

include $(TOPDIR)/rules.mk

LUCI_TITLE:=General
LUCI_DEPENDS:=+bash +fdisk +blockd +sudo +python3 +python3-pip \
			  +kmod-tcp-bbr +ddns-scripts-aliyun +softethervpn5-bridge +softethervpn5-client +softethervpn5-server \
			  +luci +luci-compat +luci-app-adbyby-plus +luci-app-ddns +luci-app-nlbwmon +luci-app-qos +luci-app-vlmcsd +luci-app-ttyd

PKG_NAME:=luci-app-bundle-general
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature