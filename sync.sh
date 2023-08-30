#!/bin/bash
cd $(cd "$(dirname "$0")"; pwd)

function replace_conffiles(){
    local pkg_name=$1
    local pkg_makefile=$2
    local before_line=$3
    sed -i -e "/^define Package\/${pkg_name}\/conffiles/,/^endef$/d" $pkg_makefile
    sed -i -e "`grep -n "${before_line}" $pkg_makefile | cut -d ":" -f 1`i define Package/${pkg_name}/conffiles\n/etc/config/${pkg_name}\n/etc/${pkg_name}/\nendef" $pkg_makefile
}

# dnsproxy
cp -rv package/dnsproxy/* ../packages/net/dnsproxy/
dnsproxy_makefile=../packages/net/dnsproxy/Makefile
sed -i -e 's|\sUSERID:=dnsproxy=411.*||' $dnsproxy_makefile
replace_conffiles dnsproxy $dnsproxy_makefile '$(eval $(call GoBinPackage,dnsproxy))'

# adguardhome
cp -rv package/adguardhome/* ../packages/net/adguardhome/
adguardhome_makefile=../packages/net/adguardhome/Makefile
replace_conffiles adguardhome $adguardhome_makefile '$(eval $(call GoBinPackage,adguardhome))'
grep -q "\$(INSTALL_DIR) \$(1)/etc/adguardhome" $adguardhome_makefile || sed -i -e "`grep -n '$(call GoPackage/Package/Install/Bin,$(1))' $adguardhome_makefile | cut -d ":" -f 1`a\ \t\$(INSTALL_DIR) \$(1)/etc/adguardhome" $adguardhome_makefile
