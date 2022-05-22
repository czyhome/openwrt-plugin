# This is free software, licensed under the Apache License, Version 2.0 .

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Basic App Modules
LUCI_DEPENDS:=+luci +luci-compat +sudo +python3 +python3-pip +ddns-scripts-aliyun \
			  +kmod-tcp-bbr \
			  +softethervpn5-bridge +softethervpn5-client +softethervpn5-server \
			  +luci-app-adbyby-plus +luci-app-ddns +luci-app-nlbwmon +luci-app-qos +luci-app-vlmcsd +luci-app-ttyd \
			  +dockerd +docker-compose +luci-app-dockerman

PKG_NAME:=luci-app-bundle-server
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature