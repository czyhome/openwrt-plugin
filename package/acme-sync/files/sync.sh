#!/bin/bash

source_dir=
target_dir=
domains=

while getopts "s:t:d:" opt
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
    *)
      logger -t "$LOG_TAG" "Usage: $(basename $0) [-s argument] [-t argument]"
      exit 1
      ;;
    esac
done
domains=(`echo $domains | tr ',' ' '`)

for i in "${domains[@]}"; do
  logger -t "$LOG_TAG" "syncing ${i}"
  source_cer=${source_dir}/${i}/$i.cer
  target_cer=${target_dir}/${i}.cer
  if [ -f "${source_cer}" ];then
    if [ ! -f ${target_cer} ] || [ `md5sum ${source_cer} | awk '{print $1}'` != `md5sum ${target_cer} | awk '{print $1}'` ];then
      find ${source_dir}/$i -name "$i.cer" -o -name "$i.key" -exec sh -c 'f={};logger -t "$LOG_TAG" "$(readlink -f $f)";cp $f ${target_dir}/' \;
      logger -t "$LOG_TAG" "synced ${i}"
    fi
  fi
done