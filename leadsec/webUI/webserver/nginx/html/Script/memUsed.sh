#!/bin/sh

free=$(cat /proc/meminfo   | grep 'MemFree'  | awk '{print $2}')
buffer=$(cat /proc/meminfo | grep 'Buffers'  | awk '{print $2}')
cache=$(cat /proc/meminfo  | grep '^Cached'   | awk '{print $2}')
total=$(cat /proc/meminfo  | grep 'MemTotal' | awk '{print $2}')

usage=`expr $total-$free-$buffer-$cache | bc -l`
result=`expr $usage/$total*100 | bc -l`
result=`expr "scale=2;$result/1" | bc -l`
echo $result%
