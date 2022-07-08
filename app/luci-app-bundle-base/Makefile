# This is free software, licensed under the Apache License, Version 2.0 .

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Bundle Base
LUCI_DEPENDS:=+bash +fdisk +cfdisk +blockd +sudo +vim +python3 +python3-bcrypt \
			  +kmod-tcp-bbr +ddns-scripts-aliyun +softethervpn5-server \
			  +luci +luci-compat +adguardhome \
			  +luci-app-ddns +luci-app-nlbwmon +luci-app-qos +luci-app-vlmcsd +luci-app-ttyd +luci-app-wireguard

PKG_NAME:=luci-app-bundle-base
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature