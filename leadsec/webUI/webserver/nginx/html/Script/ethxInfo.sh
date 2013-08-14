#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

if [ "$1" = "" ]; then
    exit 1;
fi
if [ "$2" == "" ]; then
    exit 1;
fi
if [ "$3" == "" ]; then
    exit 1;
fi

declare -a result=()

declare -i interval=3

declare -i in_old=0
declare -i in_new=0
declare -i out_old=0
declare -i out_new=0

declare -i in_r=0
declare -i out_r=0

declare -i unit=1

declare -i i=0

oldFile="/usr/local/webserver/nginx/html/Logs/ethInfo/${3}"
newFile='/proc/net/dev'

for eth in $1
do
    in_old=$(grep ${eth}: $oldFile | awk '{FS=" "; print $2;}')
    in_new=$(grep ${eth}: $newFile | awk '{FS=" "; print $2;}')
    out_old=$(grep ${eth}: $oldFile | awk '{FS=" "; print $10;}')
    out_new=$(grep ${eth}: $newFile | awk '{FS=" "; print $10;}')
    
    in_r=`echo "$in_new-$in_old" | bc -l`
    out_r=`echo "$out_new-$out_old" | bc -l`
    
    case $2 in
        "B")
            unit=1
            ;;
        "KB")
            unit=1024
            ;;
        "Mb")
            unit=131072
            ;;
        "MB")
            unit=1048576
            ;;
        "GB")
            unit=1073741824
            ;;
        *)
            exit 1;
            ;;
    esac
    result[$i]=`echo "scale=2; $in_r/$unit/$interval" | bc -l | xargs printf "%.2f\n"`
    i=$(($i+1))
    result[$i]=`echo "scale=2; $out_r/$unit/$interval" | bc -l | xargs printf "%.2f\n"`
    i=$(($i+1))
done

cp -f $newFile $oldFile

echo ${result[@]}
