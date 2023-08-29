#!/bin/bash
CUR_DIR=$(cd "$(dirname "$0")"; pwd)
cp -rv ${CUR_DIR}/package/dnsproxy/* ${CUR_DIR}/../packages/dnsproxy/