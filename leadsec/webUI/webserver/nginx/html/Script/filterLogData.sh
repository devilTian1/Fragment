#!/bin/bash
# Program:
#        According searching params, filter and sort log info.
#
# History:
# 2013/5/31        David Tian        First release       
LOG_PATH='/var/log/fw.log'
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

export PATH

declare -A params
declare -i i=0

function getCount() {
    if [ $1 ]; then
        grep $1 $LOG_PATH | wc -l
    else
        cat $LOG_PATH | wc -l
    fi
}

function help() {
    if [ $# -eq 1 -a "$1" = "-h" ]; then
        echo -e '/*\t\t\t\t\t*/'
        echo -e 'Written by DavidTian\n'
        echo -e 'PARAMETER\n'
        echo -e '\t-pri [0-9]{1,3}'
        echo -e '\t\tpriority\n'
        echo -e '\t-logtype [0-8]'
        echo -e '\t\tlogtype\n'
        echo -e '\t-dateSort ASC|DESC'
        echo -e '\t\tORDER BY date\n'
        echo -e '\t-priSort ASC|DESC'
        echo -e '\t\tORDER BY priority\n'
        echo -e '\t-fd [YYYY-MM-DD HH:ii]'
        echo -e '\t\tFrom Date\n'
        echo -e '\t-td [YYYY-MM-DD HH:ii]'
        echo -e '\t\tTo Date\n'
        echo -e '\t-sa [ipv4/6]'
        echo -e '\t\tSource Address\n'
        echo -e '\t-da [ipv4/6]'
        echo -e '\t\tDestination Address\n'
        echo -e '\t-sport [1-65535]'
        echo -e '\t\tSource Port\n'
        echo -e '\t-dport [1-65535]'
        echo -e '\t\tDestination Port\n'
        echo -e '\t-keyword "[.*]"'
        echo -e '\t\tFor searching keyword'
        exit 0;
    fi
}

function validParamKey() {
    for param in pri logtype dateSort priSort fd td sa da sport dport keyword
    do
        if [ "$param" = "$1" ]; then
            return 0
        fi
    done
    exit 2
}

function checkParams() {
    if [ $# -gt 0 -a `echo "$#%2" | bc` = 0 ]; then
        until [ -z "$1" ]
        do
            if [ `echo $1 | cut -c1` = '-' ]; then
                key=`echo $1 | cut -c2-`
                validParamKey $key      
                params[$key]=$2
                shift;shift
            else
                exit 1
            fi
        done
    else
        exit 1
    fi
}

function initSort() {
    shellCmd=''
    if [ "${params['dateSort']}" = 'DESC' ]; then
        echo 'tac $LOG_PATH'
    else
        exit 1
    fi

    #if [ $params['priSort'] = 'ASC' ]; then

    #elif [ $params['priSort'] = 'DESC' ]; then

    #else
    #    exit 1
    #fi
}


#getCount 'logtype=6';
#STEP 1 - help document
help $@

#STEP 2 - check cli params is correct and then save it.
checkParams $@

#STEP 3 - sort by date and priority, init searcha
eval `initSort`

#STEP 4 - search by searching params, specified for Search
#STEP 5 - slice the result by number of limit and offset
#STEP 6 - show

