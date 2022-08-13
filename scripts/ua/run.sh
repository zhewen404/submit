#!/bin/bash
#run.sh core mix sync util experiment
if [ $# -ne 5 ] 
then 
    echo Usage: ./run.sh core mix sync util experiment
    exit
fi

core=$1
case $2 in
  light) 
    setkey=11
    ;;
  medium) 
    setkey=12
    ;;	
  heavy) 
    setkey=9
    ;;
  hetero) 
    setkey=10
    ;;
  *) 
    echo "bad mix id" ;
    exit 1;; 
esac
sync=$3
case $4 in
  25) util=25;;
  50) util=50;;
  100) util=100;;
  *) 
    echo "bad util option" ;
    exit 1;; 
esac

experiment=$5
case $5 in
  0) 
    name=uniqueAccess;;
  *) 
    echo "bad experiment option" ;
    exit 1;; 
esac

# copy ckpt from staging
echo "cp /staging/zpan52/ckpt/spec2017-speccast_roi/c${core}-${mem}/x86-linux_set${setkey}_sync${sync}_util${util}.tar.gz ./"
cp /staging/zpan52/ckpt/spec2017-speccast_roi/c${core}-${mem}/x86-linux_set${setkey}_sync${sync}_util${util}.tar.gz ./
# untar ckpt
echo "tar -xzvf x86-linux_set${setkey}_sync${sync}_util${util}.tar.gz"
tar -xzvf x86-linux_set${setkey}_sync${sync}_util${util}.tar.gz
# rm tar file
echo "rm x86-linux_set${setkey}_sync${sync}_util${util}.tar.gz"
rm x86-linux_set${setkey}_sync${sync}_util${util}.tar.gz

# untar image
echo "tar -xzvf spec-2017-speccast1.tar.gz"
tar -xzvf spec-2017-speccast1.tar.gz

echo "cd gem5-myfeature"
cd gem5-myfeature
echo "./my_scripts/fs/spec2017-speccast/ckpt_resume_condor.sh ${core} ${setkey} ${sync} ${util} ${experiment}"
./my_scripts/fs/spec2017-speccast/ckpt_resume_condor.sh ${core} ${setkey} ${sync} ${util} ${experiment}
echo "cd .."
cd ..

timestamp=$(date +%Y%m%d-"%H%M%S")
echo "tar -czf ${name}_c${core}_set${setkey}_sync${sync}_u${util}_${timestamp}.tar gem5-myfeature/my_STATS/${name}/c${core}_set${setkey}_sync${sync}_u${util}_${experiment}"
tar -czf ${name}_c${core}_set${setkey}_sync${sync}_u${util}_${timestamp}.tar gem5-myfeature/my_STATS/${name}/c${core}_set${setkey}_sync${sync}_u${util}_${experiment}

# rm diskimage
echo "rm spec-2017-speccast1"
rm spec-2017-speccast1

echo "rm -rf x86-linux_set${setkey}_sync${sync}_util${util}"
rm -rf x86-linux_set${setkey}_sync${sync}_util${util}
