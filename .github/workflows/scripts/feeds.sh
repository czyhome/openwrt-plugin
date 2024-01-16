#!/bin/bash

unset -v is_reset


while [ $# -gt 0 ];do
  case "$1" in
    --reset)
      is_reset=true
      ;;
     *)
      args+=" $1"
      ;;
  esac
  shift
done

if $is_rese;then
    for t in "feeds/packages";do
        if [ -d "$t/.git" ];then
        `cd $t && git checkout --force && git clean -xdf`
        fi
    done
fi