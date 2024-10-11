# This is free software, licensed under the Apache License, Version 2.0 .

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Bundle Base
LUCI_DEPENDS:=+bash +fdisk +cfdisk +blockd +sudo +gcc +vim +python3 +python3-bcrypt +python3-venv \
			  +kmod-tcp-bbr +dnsmasq-full +netdata +iperf3 +softethervpn5-server \
			  +openldap-server +openldap-utils +openssh-client +msmtp \
			  +luci +luci-compat +luci-app-ttyd +luci-app-commands \
			  +luci-app-acme +acme-acmesh-dnsapi +acme-sync \
			  +luci-app-ddns +ddns-scripts +ddns-scripts-aliyun +ddns-scripts-cloudflare \
			  +luci-app-openvpn +openvpn-openssl +openvpn-easy-rsa +openvpn-auth \
			  +luci-proto-wireguard +qrencode \
			  +luci-app-adguardhome +luci-app-dnsproxy +luci-app-nlbwmon +luci-app-qos +luci-app-sqm +luci-app-vlmcsd \
			  +luci-app-wol +luci-app-snmpd +luci-app-smartdns \
			  +luci-app-upnp +luci-app-ocserv +luci-app-omcproxy +luci-app-udpxy \
			  +luci-app-aria2 +ariang +rsync +luci-app-samba4 +luci-app-nfs +luci-app-watchcat
# +luci-app-olsr +luci-app-olsr-services +luci-app-olsr-viz +luci-app-acl +luci-app-radicale2

PKG_LICENSE:=Apache-2.0

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature