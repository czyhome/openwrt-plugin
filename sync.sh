#!/bin/bash
cd $(cd "$(dirname "$0")"; pwd)
cp -rv package/dnsproxy/* ../packages/net/dnsproxy/
cp -rv package/adguardhome/* ../packages/net/adguardhome/
sed -i 's|/etc/adguardhome.yaml|/etc/adguardhome/|' ../packages/net/adguardhome/Makefile