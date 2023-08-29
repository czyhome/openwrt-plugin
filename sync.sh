#!/bin/bash
cd $(cd "$(dirname "$0")"; pwd)
cp -rv package/dnsproxy/* ../packages/dnsproxy/
cp -rv package/adguardhome/* ../packages/adguardhome/
sed -i 's|/etc/adguardhome.yaml|/etc/adguardhome/|' ../package/adguardhome/Makefile