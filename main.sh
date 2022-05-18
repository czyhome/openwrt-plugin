#!/bin/bash

for i in "applications/luci-app-softethervpn" "applications/luci-app-vlmcsd" "applications/luci-app-turboacc"; do
  svn export --force "https://github.com/coolsnowwolf/luci/trunk/$i"
done

svn export --force https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_aliyun/update_aliyun_com.sh ddns-scripts-aliyun/files/

for i in "package/lean/shortcut-fe"; do
  svn export --force "https://github.com/coolsnowwolf/lede/trunk/$i"
done

for i in "net/dns2socks" "net/microsocks" "net/ipt2socks" "net/pdnsd-alt" "net/redsocks2"; do
  svn export --force "https://github.com/immortalwrt/packages/trunk/$i"
done

for i in "net/vlmcsd"; do
  svn export --force "https://github.com/coolsnowwolf/packages/trunk/$i"
done

find -name Makefile -exec sed -i "s,include ../../luci.mk,include $\(TOPDIR\)/feeds/luci/luci.mk,g" {} \;

sleep 3

for i in $(find -name 'zh-cn' -type d); do
  zh_Hans_dir=$(dirname $i)/zh_Hans
  mkdir -p ${zh_Hans_dir}
  cp -rv $i/* ${zh_Hans_dir}
  rm -rf $i
done