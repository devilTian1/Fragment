#!/bin/sh
sysUsed=512000

free=$(cat /proc/meminfo | head -n 2 | tail -n 1 | awk '{print $2}')
total=$(cat /proc/meminfo | head -n 1 | awk '{print $2}')

usage=`expr $total-$free-$sysUsed | bc -l`
result=`expr $usage/$total*100 | bc -l`
result=`expr "scale=2;$result/1" | bc -l`
echo $result%
