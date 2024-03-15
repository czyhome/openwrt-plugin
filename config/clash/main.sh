#!/bin/bash
cd $(cd "$(dirname "$0")"; pwd)

# rm -rf metatube-sdk-go
# git clone https://github.com/metatube-community/metatube-sdk-go.git

find ./metatube-sdk-go/provider -name '*.go' -exec sh -c 'sed -n "s|baseURL\(.*\)\"\(.*\)\"|\2|p" {} | cut -d"/" -f3 | sed -e "s|/.*$||g" -re "s|^.*\.([^\.]+\.[^\.]+$)|\1|g" -e "/github/d"'  \; | sort | uniq | sed -e "s|^|DOMAIN-SUFFIX,|" > MetaTube.list