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
declare -a priArr=(0 1 2 3 4 5 6 7)
declare -i limit=10
declare -i offset=1

function help() {
    if [ $# -eq 1 -a "$1" = "-h" ]; then
        echo -e '/*\t\t\t\t\t*/'
        echo -e 'Written by DavidTian\n'
        echo -e 'PARAMETER\n'
        echo -e '\t-dateSort ASC|DESC'
        echo -e '\t\tORDER BY date\n'
        echo -e '\t-priSort ASC|DESC'
        echo -e '\t\tORDER BY priority\n'
        echo -e '\t-pri [0-9]{1,3}'
        echo -e '\t\tpriority\n'
        echo -e '\t-biz [1|0]'
        echo -e '\t\tOnly show business log.\n'
        echo -e '\t-adm [1|0]'
        echo -e '\t\tOnly show Admin log.\n'
        echo -e '\t-logtype [0-8]'
        echo -e '\t\tlogtype\n'
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
        echo -e '\t\tFor searching keyword\n'
        echo -e '\t-act [login|logout|show|set]'
        echo -e '\t\tSpecified for admLog, user action. '
        exit 0;
    fi
}

function validParamKey() {
    for param in pri logtype dateSort priSort fd td sa da sport dport keyword biz adm act offset limit
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
            if [ `echo "$1" | cut -c1` = '-' ]; then
                key=`echo "$1" | cut -c2-`
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
    cmd=''
    if [ -z "${params['limit']}" -o -z "${params['offset']}" ]; then
        exit 1
    else
        limit=${params['limit']}
        offset=${params['offset']}+1
    fi

    if [ "${params['dateSort']}" = "DESC" ]; then
        cmd="tac $LOG_PATH"
    else
        cmd="cat $LOG_PATH"
    fi

    if [ "${params['adm']}" = "1" ]; then
        cmd=${cmd}" | egrep 'devid=[0-9]+ date=\"[^\"]+\" dname=[^[:space:]]+ \
            logtype=9 pri=[0-7] mod=[^[:space:]]+ event=\".*\"'"
        if [ "${params['act']}" ]; then
            cmd=${cmd}" | grep 'act=\"${params['act']}\"'"
        fi
    elif [ "${params['biz']}" = "1" ]; then
        cmd=${cmd}" | egrep 'devid=[0-9]+ date=\"[^\"]+\" dname=[^[:space:]]+ \
            logtype=([0-8]+|[0-9]{2,3}) pri=[0-7] mod=[^[:space:]]+ event=\".*\"'"
    else
        cmd=${cmd}" | egrep 'devid=[0-9]+ date=\"[^\"]+\" dname=[^[:space:]]+ \
            logtype=[0-9]+ pri=[0-7] mod=[^[:space:]]+ event=\".*\"'"
    fi
    
    if [ "${params['logtype']}" ]; then
        cmd=${cmd}" | egrep 'logtype=${params['logtype']}[[:space:]]'"
    fi
    
    if [ "${params['sa']}" ]; then
        cmd=${cmd}" | grep sa=${params['sa']}"
    fi
    if [ "${params['da']}" ]; then
        cmd=${cmd}" | grep da=${params['da']}"
    fi
    if [ "${params['sport']}" ]; then
        cmd=${cmd}" | grep sport=${params['sport']}"
    fi
    if [ "${params['dport']}" ]; then
        cmd=${cmd}" | grep dport=${params['dport']}"
    fi

    if [ "${params['keyword']}" ]; then
        cmd=${cmd}" | grep -e event=\".*${params['keyword']}.*\""
    fi

    if [ "${params['pri']}" ]; then
        cmd=${cmd}" | grep pri=${params['pri']}"
    fi

    if [ "${params['fd']}" -a "${params['td']}" ]; then
        declare -i fromDateSec=`date +%s -d "${params['fd']}"`
        declare -i toDateSec=`date +%s -d "${params['td']}"`
    else
        declare -i fromDateSec=0
        declare -i toDateSec=0
    fi

    eval ${cmd} | gawk -v fd="$fromDateSec" -v td="$toDateSec" \
        -v priSort="${params['priSort']}"  \
        -v limit=$limit -v offset=$offset  \
        'BEGIN { FS="\""; i=1 } { \
            date=$2; \
            gsub(/[:\/]/, " ", date); \
            pri=substr($0, index($0, "pri=")+4, 1); \
            date=mktime(date);\
            if ((fd == 0 && td == 0) || (date >= fd && date <= td)) {\
                arr[i++]=pri"@"$0;\
            }\
        } END {\
            sum=0; \
            if (priSort=="DESC") {\
                len=asort(arr);\
                for(i=1; i<=len; i++) {\
                    if (sum==limit) {break;}\
                    if(i>=offset) {print arr[i]; sum++;}\
                    else {continue;} \
                }\
            } else if (priSort=="ASC") {\
                len=asort(arr);\
                for(i=len; i>=1; i--) {\
                    if (sum==limit) {break;}\
                    if((len-i+1)>=offset) {print arr[i]; sum++;}\
                    else {continue;} \
                }\
            } else {
                len=length(arr);\
                for(i=1; i<=len; i++) {\
                    if (sum==limit) {break;}\
                    if(i>=offset) {print arr[i]; sum++;}\
                    else {continue;} \
                }\
            }\
            print len;
        }'
}

#STEP 1 - help document
help $@

#STEP 2 - check cli params is correct and then save it.
checkParams "$@"

#STEP 3 - sort by date and priority, init searcha
#       - search by searching params, specified for Search
#       - slice the result by number of limit and offset
#eval `initSort`
initSort
