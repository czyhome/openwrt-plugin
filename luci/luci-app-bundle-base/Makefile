# This is free software, licensed under the Apache License, Version 2.0 .

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Bundle Base
LUCI_DEPENDS:=+bash +fdisk +cfdisk +blockd +sudo +gcc +vim +python3 +python3-bcrypt \
			  +kmod-tcp-bbr +kmod-macvlan +ddns-scripts-aliyun +netdata +iperf3 +softethervpn5-server \
			  +openvpn-openssl +openvpn-easy-rsa +openvpn-auth +openldap-server +openldap-utils \
			  +luci +luci-compat +adguardhome +luci-app-ttyd +luci-app-commands \
			  +luci-app-ddns +luci-app-nlbwmon +luci-app-qos +luci-app-vlmcsd +luci-app-wireguard +qrencode \
			  +luci-app-wol +luci-app-socat +luci-app-snmpd +luci-app-smartdns \
			  +luci-app-upnp +luci-app-openvpn +luci-app-ocserv +luci-app-sqm +luci-app-acme +acme-dnsapi +acme-sync +luci-app-omcproxy +luci-app-udpxy \
			  +luci-app-aria2 +ariang +rsync +luci-app-samba4 +luci-app-nfs
# +luci-app-olsr +luci-app-olsr-services +luci-app-olsr-viz +luci-app-acl +luci-app-radicale2
PKG_NAME:=luci-app-bundle-base
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature