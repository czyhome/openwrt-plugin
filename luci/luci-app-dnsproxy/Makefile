#
# Copyright 2023 Bruce Chen <a805899926@gmail.com>
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Support for DnsProxy
LUCI_DEPENDS:=+luci-compat +dnsproxy2

PKG_LICENSE:=Apache-2.0

define Package/luci-app-dnsproxy/conffiles
/etc/config/dnsproxy
/etc/init.d/dnsproxy
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
