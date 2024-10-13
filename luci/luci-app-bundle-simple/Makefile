# This is free software, licensed under the Apache License, Version 2.0 .

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Bundle Simple
LUCI_DEPENDS:=+bash +kmod-tcp-bbr +dnsmasq-full +netdata +iperf3 +softethervpn5-server +openssh-client +autocore \
			  +luci +luci-compat \
			  +luci-proto-wireguard +qrencode +luci-app-nlbwmon +luci-app-snmpd +luci-app-qos +luci-app-sqm +luci-app-upnp +luci-app-wol +luci-app-vlmcsd \
			  +luci-app-adguardhome +luci-app-dnsproxy +luci-app-smartdns \
			  +luci-app-openvpn +openvpn-openssl +openvpn-easy-rsa +openvpn-auth +luci-app-ocserv \
			  +luci-app-acme +acme-acmesh-dnsapi +acme-sync +luci-app-omcproxy +luci-app-udpxy +luci-app-watchcat \
			  +luci-app-ttyd +luci-app-commands

PKG_LICENSE:=Apache-2.0

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature