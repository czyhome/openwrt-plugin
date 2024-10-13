#!/bin/bash

cd $(cd "$(dirname "$0")"; pwd)

function cp_pkg(){
  pkg_path=$1
  pkg_name=`basename $1`
  cp -rv package/${pkg_name}/files/ ../packages/${pkg_path}
  [ -f "package/${pkg_name}/Makefile.override" ] && cp -rv package/${pkg_name}/Makefile.override ../packages/${pkg_path}/Makefile    
}

function sparse_checkout(){
  feed_dir=$1
  feed_url=$2
  feed_pkg=$3
  rm -rf $feed_dir && mkdir -p $feed_dir
  (
   cd $feed_dir;
   git init
   git remote add origin $feed_url
   git config core.sparsecheckout true
   git sparse-checkout set $feed_pkg
   git pull origin master
  )
}

################################################
if [ "$1" == "update" ];then

  ## 
  lede_dir=feeds/coolsnowwolf/lede
  lede_pkg="package/lean/ddns-scripts_aliyun/update_aliyun_com.sh"
  sparse_checkout $lede_dir "https://github.com/coolsnowwolf/lede" "$lede_pkg"
  cp -rv $lede_dir/package/lean/ddns-scripts_aliyun/update_aliyun_com.sh package/ddns-scripts-aliyun/files/

  ## 
  lede_luci_dir=feeds/coolsnowwolf/luci
  lede_luci_pkg="applications/luci-app-vlmcsd applications/luci-app-socat applications/luci-app-nfs"
  sparse_checkout $lede_luci_dir "https://github.com/coolsnowwolf/luci" "$lede_luci_pkg"

  cp -rv $lede_luci_dir/applications/* luci/

  ## 
  lede_packages_dir=feeds/coolsnowwolf/packages
  lede_packages_pkg="net/vlmcsd"
  sparse_checkout $lede_packages_dir "https://github.com/coolsnowwolf/packages" "$lede_packages_pkg"
  cp -rv $lede_packages_dir/net/* package/

  ##
  immortalwrt_dir=feeds/immortalwrt/immortalwrt
  immortalwrt_pkg="package/emortal/autocore"
  sparse_checkout $immortalwrt_dir "https://github.com/immortalwrt/immortalwrt" "$immortalwrt_pkg"
  cp -rv $immortalwrt_dir/package/emortal/autocore package/

  find -name 'Makefile' -type f -exec sed -i "s|include ../../luci.mk|include $\(TOPDIR\)/feeds/luci/luci.mk|g" {} \;

  for i in $(find -name 'zh-cn' -type d); do
    zh_Hans_dir=$(dirname $i)/zh_Hans
    mkdir -p ${zh_Hans_dir}
    cp -rv $i/* ${zh_Hans_dir}
    rm -rf $i
  done
fi

################################################
if [ "$1" == "install" ];then
  for i in "net/dnsproxy" "net/adguardhome" "libs/openldap"; do
    cp_pkg $i
  done

  # openldap
  sed -i -e 's|$(INSTALL_BIN) ./files/ldap.init $(1)/etc/init.d/ldap|$(INSTALL_BIN) ./files/openldap.init $(1)/etc/init.d/openldap|' ../packages/libs/openldap/Makefile
  # adguardhome
  sed -i -e 's|$(call GoPackage/Package/Install/Bin,$(1))|\0\n\n\t$(INSTALL_DIR) $(1)/etc/adguardhome\n|' ../packages/net/adguardhome/Makefile
  sed -i -e "/define Package\/adguardhome\/conffiles/{:a;N;/endef/!ba;s|\(define Package/adguardhome/conffiles\)\n\(.*\)\n\(endef\)|\1\n/etc/adguardhome/\n/etc/config/adguardhome\n\3|}" ../packages/net/adguardhome/Makefile
  # dnsproxy
dnsproxy_install='\
define Package/dnsproxy/install \
	$(call GoPackage/Package/Install/Bin,$(1)) \
\
	$(INSTALL_DIR) $(1)/etc/dnsproxy \
\
	$(INSTALL_DIR) $(1)/etc/init.d \
	$(INSTALL_BIN) ./files/dnsproxy.init $(1)/etc/init.d/dnsproxy \
\
	$(INSTALL_DIR) $(1)/etc/config \
	$(INSTALL_DATA) ./files/dnsproxy.config $(1)/etc/config/dnsproxy \
endef \
'
  sed -i -e "/define Package\/dnsproxy\/install/{:a;N;/endef/!ba;s|\(define Package/dnsproxy/install\)\n\(.*\)\n\(endef\)||}" ../packages/net/dnsproxy/Makefile
  sed -i -e "/define Package\/dnsproxy\/conffiles/{:a;N;/endef/!ba;s|\(define Package/dnsproxy/conffiles\)\n\(.*\)\n\(endef\)|\1\n/etc/dnsproxy/\n/etc/config/dnsproxy\n\3|}" ../packages/net/dnsproxy/Makefile
  sed -i -e "s|define Package/dnsproxy/conffiles|${dnsproxy_install}\n\0|" -e 's|USERID:=dnsproxy=411:dnsproxy=411||' ../packages/net/dnsproxy/Makefile

  if [ "$2" == "--openwrt-master" ];then
    # set ruby version
    sed -i -e "s|^\(PKG_VERSION\)\(.*\)|\1:=3.2.5|" -e "s|^\(PKG_HASH\)\(.*\)|\1:=ef0610b498f60fb5cfd77b51adb3c10f4ca8ed9a17cb87c61e5bea314ac34a16|" ../packages/lang/ruby/Makefile
  fi
fi

if [ "$1" == "check" ];then
  echo "check"
fi
