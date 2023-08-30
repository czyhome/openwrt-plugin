#!/bin/bash
cd $(cd "$(dirname "$0")"; pwd)

# dnsproxy
cp -rv package/dnsproxy/files/ ../packages/net/dnsproxy/
cp -rv package/dnsproxy/Makefile.override ../packages/net/dnsproxy/Makefile

# adguardhome
cp -rv package/adguardhome/files/ ../packages/net/adguardhome/
cp -rv package/adguardhome/Makefile.override ../packages/net/adguardhome/Makefile
