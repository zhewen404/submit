#!/bin/bash
if [ $# -ne 1 ] 
then 
    echo Usage: ./spec17_ws_experiment9.sh procid
    exit
fi
case $1 in
  0)setkey=1;;
  1)setkey=2;;
  2)setkey=3;;
  3)setkey=4;;
  4)setkey=5;;
  5)setkey=6;;
  6)setkey=7;;
  7)setkey=8;;
  8)setkey=13;;
  9)setkey=14;;
  10)setkey=15;;
  11)setkey=16;;
  12)setkey=17;;
  13)setkey=18;;
  14)setkey=19;;
  15)setkey=20;;
  16)setkey=21;;
  17)setkey=22;;
  18)setkey=23;;
  19)setkey=24;;
  20)setkey=25;; 
  *)
    echo "bad procid"
    exit 1;;
esac

core=1
util=100
sync=2
experiment=9
./scripts/ws/run.sh $core $setkey $sync $util $experiment