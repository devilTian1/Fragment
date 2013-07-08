#!/bin/sh  

declare -a totals
 
CPU_1=(`cat /proc/stat | grep -E '^cpu[0-9]+ ' `)

sleep 1

CPU_2=(`cat /proc/stat | grep -E '^cpu[0-9]+ ' `)

i=0
while [ "${CPU_1[i]}" != "" ]
do
    cpu1_total=`expr ${CPU_1[i+1]}+${CPU_1[i+2]}+${CPU_1[i+3]}+${CPU_1[i+4]}+${CPU_1[i+5]}+${CPU_1[i+6]}+${CPU_1[i+7]}+${CPU_1[i+8]}+${CPU_1[i+9]}+${CPU_1[i+10]} | bc -l`
    cpu1_usage=`expr ${CPU_1[i+1]}+${CPU_1[i+2]}+${CPU_1[i+3]}+${CPU_1[i+5]}+${CPU_1[i+6]}+${CPU_1[i+7]}+${CPU_1[i+8]}+${CPU_1[i+9]}+${CPU_1[i+10]} | bc -l`
    cpu2_total=`expr ${CPU_2[i+1]}+${CPU_2[i+2]}+${CPU_2[i+3]}+${CPU_2[i+4]}+${CPU_2[i+5]}+${CPU_2[i+6]}+${CPU_2[i+7]}+${CPU_2[i+8]}+${CPU_2[i+9]}+${CPU_2[i+10]} | bc -l`
    cpu2_usage=`expr ${CPU_2[i+1]}+${CPU_2[i+2]}+${CPU_2[i+3]}+${CPU_2[i+5]}+${CPU_2[i+6]}+${CPU_2[i+7]}+${CPU_2[i+8]}+${CPU_2[i+9]}+${CPU_2[i+10]} | bc -l`

    usage=`expr $cpu2_usage - $cpu1_usage | bc -l`
    total=`expr $cpu2_total - $cpu1_total | bc -l`
    result=`expr $usage/$total*100 | bc -l`

    rate=`echo "scale=2;  if(scale($result) == length($result)) print 0; print $result/1" |bc`  
    echo $rate% 

    i=$(($i+11))
done
