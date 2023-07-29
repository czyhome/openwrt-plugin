#!/bin/bash

# example cron: */30 * * * * LOG_TAG=acme-sync /etc/acme/sync.sh -s <source_dir> -t <target_dir> -d example.com -p "echo 'post_shell'"

source_dir=
target_dir=
domains=
post_shell=
while getopts "s:t:d:p:" opt
do
        case $opt in
                s)
                  source_dir=$OPTARG
                ;;
                t)
                  target_dir=$OPTARG
                ;;
                d)
                  domains=$OPTARG
                ;;
                p)
                  post_shell=$OPTARG
                ;;
                *)
                  logger -t "$LOG_TAG" "Usage: $(basename $0) [-s argument] [-t argument]"
                  exit 1
                ;;
    esac
done
domains=(`echo $domains | tr ',' ' '`)
sync_any=false
for i in "${domains[@]}"; do
  logger -t "$LOG_TAG" "${i}"
  source_cer=${source_dir}/${i}/$i.cer
  target_cer=${target_dir}/${i}.cer
  if [ -f "${source_cer}" ];then
    if [ ! -f ${target_cer} ] || [ `md5sum ${source_cer} | awk '{print $1}'` != `md5sum ${target_cer} | awk '{print $1}'` ];then
      find ${source_dir}/$i -name "$i.cer" -o -name "$i.key" -exec sh -c 'f={};logger -t "$LOG_TAG" "$(readlink -f $f)";cp $f ${target_dir}/' \;
      sync_any=true
    fi
  fi
done
if $sync_any;then
  $post_shell
fi