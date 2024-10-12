# This is free software, licensed under the Apache License, Version 2.0 .

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Bundle Base
LUCI_DEPENDS:=+luci-app-bundle-simple \
			  +fdisk +cfdisk +blockd +sudo +gcc +vim +python3 +python3-bcrypt +python3-venv +rsync \
			  +openldap-server +openldap-utils +msmtp \
			  +luci-app-aria2 +ariang +luci-app-samba4 +luci-app-nfs
# +luci-app-olsr +luci-app-olsr-services +luci-app-olsr-viz +luci-app-acl +luci-app-radicale2

PKG_LICENSE:=Apache-2.0

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature