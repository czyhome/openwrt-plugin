#!/bin/bash

# example cron: 0 0 * * * LOG_TAG=acme-sync /etc/acme/sync.sh -s <source_dir> -t <target_dir> -d example.com -p "echo 'post_shell'"
LOG_TAG=${LOG_TAG-"acme-sync"}

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
mkdir -p ${target_dir}
for i in "${domains[@]}"; do
  logger -t "$LOG_TAG" "${i}"
  source_cer=${source_dir}/${i}/$i.cer
  target_cer=${target_dir}/${i}.cer
  if [[ -f ${source_cer} && ! -f ${target_cer} || -f ${source_cer} && -f ${target_cer} && ! -z `diff -q ${source_cer} ${target_cer}` ]];then
    for f in `find ${source_dir}/$i -name "$i.cer" -o -name "$i.key"`;do
      logger -t "$LOG_TAG" "$(readlink -f $f) ->  ${target_dir}";
      cp $f ${target_dir}
    done
    sync_any=true
  fi
done
if $sync_any;then
  $post_shell
fi