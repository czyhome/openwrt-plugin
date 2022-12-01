#!/bin/bash

# lede luci
for i in "applications/luci-app-vlmcsd" "applications/luci-app-socat"; do
  svn export --force "https://github.com/coolsnowwolf/luci/trunk/$i" app/$(basename $i)
done

# lede packages
for i in "net/vlmcsd"; do
  svn export --force "https://github.com/coolsnowwolf/packages/trunk/$i" package/$(basename $i)
done

# custom
svn export --force https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_aliyun/update_aliyun_com.sh package/ddns-scripts-aliyun/files/

find -name 'Makefile' -type f -exec sed -i "s,include ../../luci.mk,include $\(TOPDIR\)/feeds/luci/luci.mk,g" {} \;

for i in $(find -name 'zh-cn' -type d); do
  zh_Hans_dir=$(dirname $i)/zh_Hans
  mkdir -p ${zh_Hans_dir}
  cp -rv $i/* ${zh_Hans_dir}
  rm -rf $i
done
