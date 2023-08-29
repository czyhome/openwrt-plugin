#!/bin/bash
cd $(cd "$(dirname "$0")"; pwd)

# dnsproxy
cp -rv package/dnsproxy/* ../packages/net/dnsproxy/
sed -i -e 's|\sUSERID:=dnsproxy=411.*||' -e '/^define Package\/dnsproxy\/conffiles/,/^endef$/d' ../packages/net/dnsproxy/Makefile
sed -i -e "`grep -n '$(eval $(call GoBinPackage,dnsproxy))' ../packages/net/dnsproxy/Makefile | cut -d ":" -f 1` idefine Package/dnsproxy/conffiles\n/etc/config/dnsproxy\n/etc/dnsproxy/\nendef" ../packages/net/dnsproxy/Makefile

# adguardhome
cp -rv package/adguardhome/* ../packages/net/adguardhome/
sed -i -e '/^define Package\/adguardhome\/conffiles/,/^endef$/d' ../packages/net/adguardhome/Makefile
sed -i -e "`grep -n '$(eval $(call GoBinPackage,adguardhome))' ../packages/net/adguardhome/Makefile | cut -d ":" -f 1` idefine Package/adguardhome/conffiles\n/etc/config/adguardhome\n/etc/adguardhome/\nendef" ../packages/net/adguardhome/Makefile
