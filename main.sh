#!/bin/bash

cd $(cd "$(dirname "$0")"; pwd)

function cp_pkg(){
  pkg_path=$1
  pkg_name=`basename $1`
  cp -rv package/${pkg_name}/files/ ../packages/${pkg_path}
  [ -f "package/${pkg_name}/Makefile.override" ] && cp -rv package/${pkg_name}/Makefile.override ../packages/${pkg_path}/Makefile    
}

################################################
if [ "$1" == "update" ];then
  # lede luci
  for i in "applications/luci-app-vlmcsd" "applications/luci-app-socat" "applications/luci-app-nfs"; do
    svn export --force "https://github.com/coolsnowwolf/luci/trunk/$i" luci/$(basename $i)
  done

  # lede packages
  for i in "net/vlmcsd"; do
    svn export --force "https://github.com/coolsnowwolf/packages/trunk/$i" package/$(basename $i)
  done

  # custom
  svn export --force https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_aliyun/update_aliyun_com.sh package/ddns-scripts-aliyun/files/

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
  sed -i -e 's|$(call GoPackage/Package/Install/Bin,$(1))|\0\n\n\t$(INSTALL_DIR) $(1)/etc/adguardhome\n|' -e 's|/etc/adguardhome.yaml|/etc/adguardhome/|' ../packages/net/adguardhome/Makefile
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
  sed -i -e "/define Package\/dnsproxy\/install/{:a;N;/endef/!ba;s|\(define Package/dnsproxy/install\)\n\(.*\)\n\(endef\)||}" \
         -e "s|define Package/dnsproxy/conffiles|${dnsproxy_install}\n\0|" \
         -e "/define Package\/dnsproxy\/conffiles/{:a;N;/endef/!ba;s|\(define Package/dnsproxy/conffiles\)\n\(.*\)\n\(endef\)|\1\n/etc/dnsproxy/\n\3|}" \
         -e 's|USERID:=dnsproxy=411:dnsproxy=411||' ../packages/net/dnsproxy/Makefile
fi

if [ "$1" == "check" ];then
  echo "check"
fi
