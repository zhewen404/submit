#!/bin/bash
if [ $# -ne 1 ] 
then 
    echo Usage: ./spec17_heavy_util100_sync4.sh procid
    exit
fi
case $1 in
  0)
    core=64
    mix=heavy
    sync=4
    util=100
    ;;
  *)
    echo "bad procid"
    exit 1;;
esac

./scripts/ua/run.sh $core $mix $sync $util 0