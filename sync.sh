#!/bin/bash
cd $(cd "$(dirname "$0")"; pwd)

# dnsproxy
cp -rv package/dnsproxy/* ../packages/net/dnsproxy/
sed -i -e 's|\sUSERID:=dnsproxy=411.*||' -e '/^define Package\/dnsproxy\/conffiles/,/^endef$/d' ../packages/net/dnsproxy/Makefile
call_line=`grep -n '$(eval $(call GoBinPackage,dnsproxy))' feeds/packages/net/dnsproxy/Makefile | cut -d ":" -f 1`
sed -i -e "$call_line idefine Package/dnsproxy/conffiles\n/etc/config/dnsproxy\n/etc/dnsproxy/\nendef"
# adguardhome
cp -rv package/adguardhome/* ../packages/net/adguardhome/
sed -e 's|\sUSERID:=dnsproxy=411.*||' -e "/^define Package\/dnsproxy\/conffiles/,/^endef$/d" ../packages/net/adguardhome/Makefile
