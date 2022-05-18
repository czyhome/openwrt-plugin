#!/bin/bash

# svn export --force https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_aliyun/update_aliyun_com.sh ddns-scripts-aliyun

# for i in "dns2socks" "microsocks" "ipt2socks" "pdnsd-alt" "redsocks2"; do
#   svn export --force "https://github.com/immortalwrt/packages/trunk/net/$i"
# done

# for i in "applications/luci-app-softethervpn" "applications/luci-app-vlmcsd"; do
#   svn export --force "https://github.com/coolsnowwolf/luci/trunk/$i"
# done

# for i in "net/vlmcsd"; do
#   svn export --force "https://github.com/coolsnowwolf/packages/trunk/$i"
# done

find -name Makefile -exec sed -i "s,include ../../luci.mk,include $\(TOPDIR\)/feeds/luci/luci.mk,g" {} \;