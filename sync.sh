#!/bin/bash
CUR_DIR=$(cd "$(dirname "$0")"; pwd)
cp -rv ${CUR_DIR}/package/dnsproxy/* ${CUR_DIR}/../packages/dnsproxy/
cp -rv ${CUR_DIR}/package/adguardhome/* ${CUR_DIR}/../packages/adguardhome/
sed -i 's|/etc/adguardhome.yaml|/etc/adguardhome/|' ${CUR_DIR}/package/adguardhome/Makefile