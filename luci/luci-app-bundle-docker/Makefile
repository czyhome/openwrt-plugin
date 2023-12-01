# This is free software, licensed under the Apache License, Version 2.0 .

include $(TOPDIR)/rules.mk

LUCI_TITLE:=Docker
LUCI_DEPENDS:=+kmod-macvlan +dockerd +docker-compose +luci-app-dockerman

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature