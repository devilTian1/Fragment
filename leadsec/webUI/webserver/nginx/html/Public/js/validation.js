var perlipv6regex = "^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$";

var perlipv4regex = '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$';

// Custom Validation Method
function addValidMethod(params) {
    jQuery.validator.addMethod(params.name, params.validMethod, params.msg);
}

function countUnchecked(doms) {
    return doms.filter(':unchecked').length;
}

// Custom Validation Method Params
var validMethodParams = {
    letterValidParam: {
        name: 'letters',
        validMethod: function(value, element, params) {
            var regexp = new RegExp("^[a-zA-Z]{" + 
                params[0] + "," + params[1] + "}$");
            return this.optional(element) || regexp.test(value);
        },
        msg: jQuery.format("{0}至{1}位英文字母")
    },
    passwdValidParam: {
        name: 'passwd',
        validMethod: function(value, element, params) {
            var regexp =
	        new RegExp("^[a-zA-Z0-9]{" + params[0] + "," + params[1] + "}$");
            return this.optional(element) || regexp.test(value);
        },
        msg: jQuery.format("{0}至{1}位字母或数字")
    },
    UserPasswdValidParam: {
        name: 'passwd_user',
        validMethod: function(value, element) {
            return this.optional(element) ||
                /^([0-9]{10,20}|[a-zA-Z\W]{9,20}|.{12,20})$/.test(value);
        },
        msg: jQuery.format('9-20个英文字母或非字母字符<br/>10个基本数字<br/>口令达到12个字符长度')
    },   
    ipValidParam: {
        name: 'ip',
        validMethod: function(value, element, params) {
            var ipv4regex = new RegExp(perlipv4regex);
            var ipv6regex = new RegExp(perlipv6regex);
            return this.optional(element) || ipv4regex.test(value) ||
                ipv6regex.test(value) || /^fe80/i.test(value)
        },
        msg: 'IP格式错误.'
    },
    ipv4ValidParam: {
        name: 'ipv4',
        validMethod: function(value, element, params) {
            var ipv4regex = new RegExp(perlipv4regex);
            return this.optional(element) ||
            ipv4regex.test(value)
        },
        msg: 'IPV4格式错误.'
    },
    ipv6ValidParam: {
        name: 'ipv6',
        validMethod: function(value, element, params) {
            var ipv6regex =
            new RegExp(perlipv6regex);
            return this.optional(element) || ipv6regex.test(value) || /^fe80/i.test(value)
        },
        msg: 'IPV6格式错误.'
    },
    macValidParam: {
        name: 'mac',
        validMethod: function(value, element) {
            return this.optional(element) ||
            /^(([A-Fa-f0-9]){2}:){5}([A-Fa-f0-9]){2}$/.test(value);
        },
        msg: 'MAC地址格式错误.'
    },
    netmaskValidParam: {
        name: 'netmask',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}/.test(value) ||
            (value >=1 && value <= 128)
        },
        msg: '子网掩码格式错误.'
    },
    ipv4NetmaskValidParam: {
        name: 'ipv4Netmask',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}/.test(value)
            || (value >=1 && value <= 32)
        },
        msg: 'IPV4子网掩码格式错误.'
    },
    ipv6NetmaskValidParam: {
        name: 'ipv6Netmask',
        validMethod: function(value, element, params) {
            return this.optional(element) || (value >=1 && value <= 128)
        },
        msg: 'ipv6子网掩码格式错误.'
    },
    addrNameValidParam: {
        name: 'addrName',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^[a-zA-Z0-9\-_\.]{1,15}$/.test(value);
        },
        msg: '1-15个字母、数字、减号、下划线、点的组合.'
    },
    realNameValidParam: {
        name: 'realName',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^[a-zA-Z0-9\-_]{1,15}$/.test(value);
        },
        msg: '1-15个字母、数字、减号、下划线的组合.'
    },
    dateTimeValidParam: {
        name: 'dateTime',
        validMethod: function(value, element, params) {
            var regexpStr = '';

            var yyyymmdd  = 
                '[0-9]{4}/(0?[1-9]|1[0-2])/(0?[0-9]|[12][0-9]|3[01])';
            var hhmm      = '(0?[0-9]|1[0-9]|2[0-3]):(0?[0-9]|[1-5][0-9])';
            var hhmm_ss   = hhmm + '(:(0?[0-9]|[1-5][0-9]))?';

            if (params[0] === 'YYYY/MM/DD hh:mm(:ss)') {
                regexpStr = yyyymmdd + ' ' + hhmm_ss;
            } else if (params[0] === 'YYYY/MM/DD hh:mm') {
                regexpStr = yyyymmdd + ' ' + hhmm;
            } else if (params[0] === 'hh:mm(:ss)') {
                regexpStr = hhmm_ss;
            } else {
                regexpStr = yyyymmdd + ' ' + hhmm_ss;
            }
            var regexp = new RegExp('^' + regexpStr + '$');
            return this.optional(element) || regexp.test(value);
        },
        msg: jQuery.format("格式为{0}. ")
    },
    startOrEndFullDateValidParam: {
        name: 'fullDate_s_or_e',
        validMethod: function(value, element, params) {
            var sv = $(params[0]).val();
            var ev = $(params[1]).val();
            if (sv == '' && ev == '') {
                return true;
            }
            var st = new Date(sv);
            var et = new Date(ev);
            return Date.parse(sv) < Date.parse(ev);
        },
        msg: "起始时间应小于终止时间."
    },
    startOrEndTimeValidParam: {
        name: 'time_s_or_e',
        validMethod: function(value, element, params) {
            var sv = $(params[0]).val();
            var ev = $(params[1]).val();
            if (sv == '' && ev == '') {
                return true;
            }
            var hms_s = sv.split(':');
            var hms_e = ev.split(':');
            if (hms_s[0] < hms_e[0]) {
                return true;
            } else if (hms_s[0] == hms_e[0]) {
                if (hms_s[1] < hms_e[1]) {
                    return true;
                } else if (hms_s[1] == hms_e[1]) {
                    var s_s = hms_s[2] === undefined ? 0 : hms_s[2];
                    var s_e = hms_e[2] === undefined ? 0 : hms_e[2];
                    if (s_s < s_e) {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            } else {
                return false;
            }
        },
        msg: "起始时间应小于终止时间"
    },
    filledValidParam: {
        name: 'isFilled',
        validMethod: function(value, element, params) {
            return $(params[0] + ':filled').length > 0;
        },
        msg: jQuery.format("{1}")
    }
};
for (var i in validMethodParams) {
    addValidMethod(validMethodParams[i]);
}

// rule
var validRules = {
    expTime: {
        required: true,
        range: [60, 86400]
    },
    limitErrNum: {
        required: true,
        range: [1, 10]
    },
    limitErrTime: {
        required: true,
        range: [60, 86400]
    },
    account: {
        required: true,
        letters: [1, 15]
    },
    passwd: {
        required: true,
        passwd: [8, 15]
    },
    passwd_again: {
        required: true,
        equalTo: "#passwd"
    },
    logAdmin: {
        required: function() {
            return (countUnchecked($('.roles')) === 3);
        }
    },
    ip: {
        required: true,
	    ip: true
    },
    netmask: {
        required: 'input[name="ip"]:filled',
        netmask: true
    },
    ipv4: {
        required: 'input[name="ipv6"]:blank',
	    ipv4: true
    },
    ipv4Netmask: {
        required: 'input[name="ipv4"]:filled',
        ipv4Netmask: true
    },
    ipv6: {
        required: 'input[name="ipv4"]:blank',
	    ipv6: true
    },
    ipv6Netmask: {
        required: 'input[name="ipv6"]:filled',
        ipv6Netmask: true
    },
    ipAddr_r: {
        required: true,
	    ip: true
    },
    range_s: {
        required: true,
        ipv4: true
    },
    range_e: {
        required: true,
        ipv4: true
    },
    comment: {
        maxlength: 250
    },
    addrName: {
        required: true,
        addrName: true
    },
    addrGrpName : {
        required: true,
        addrName: true
    },
    'addrGrpMember[]': {
        required: function() {
            return $('select[name="addrGrpMember[]"] option').length === 0;
        }
    },
    netname: {
        required: true,
        maxlength: 20
    },
    record_type_mx: {
        required: function() {
            return (countUnchecked($(".record_type")) === 2);
        }
    },
    addStaticAddr: {
        ip: true
    },
    ntpSyncInterval: {
        required: true,
        range: [1, 65535]
    },
    max_record: {
        required: true,
        range: [1, 65535]
    },
    interval: {
        required: true,
        range: [1, 65535]
    },
    autoParseErrInterval: {
        required: true,
        range: [1, 65535]
    },
    primaryDns: {
        ip: true
    },
    slaveDns: {
        ip: true
    },
    timeListName: {
        required: true,
        addrName: true
    },
    startTime_f: {
        required: true,
        dateTime: ['YYYY/MM/DD hh:mm(:ss)']
    },
    endTime_f: {
        required: true,
        dateTime: ['YYYY/MM/DD hh:mm(:ss)'],
        fullDate_s_or_e: ['#startTime_f', '#endTime_f']
    },
    startTime_mon: {
        required: '#endTime_mon:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_mon: {
        required: '#startTime_mon:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_mon', '#endTime_mon']
    },
    startTime_tue: {
        required: '#endTime_tue:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_tue: {
        required: '#startTime_tue:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_tue', '#endTime_tue']
    },
    startTime_wed: {
        required: '#endTime_wed:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_wed: {
        required: '#startTime_wed:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_wed', '#endTime_wed']
    },
    startTime_thur: {
        required: '#endTime_thur:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_thur: {
        required: '#startTime_thur:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_thur', '#endTime_thur']
    },
    startTime_fri: {
        required: '#endTime_fri:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_fri: {
        required: '#startTime_fre:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_fri', '#endTime_fri']
    },
    startTime_sat: {
        required: '#endTime_sat:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_sat: {
        required: '#startTime_sat:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_sat', '#endTime_sat']
    },
    startTime_sun: {
        required: '#endTime_sun:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_sun: {
        required: '#startTime_sun:filled',
        isFilled: ['.weekDiv :text', '请至少输入一天的起始时间.'],
        time_s_or_e: ['#startTime_sun', '#endTime_sun'],
        dateTime: ['hh:mm(:ss)']
    },
    'timeGrpMember[]': {
        required: function() {
            return $('select[name="timeGrpMember[]"] option').length === 0;
        }
    },
    timeGroupName: {
        required: true,
        addrName: true
    },
	dnssrv: {
        ip: true,
        required: '#dnssrv2:filled'
    },
	dnssrv2: {
        ip: true
    },
	destip: {
        required: true,
	    ip: true
    },
	nexthopip: {
        required: true,
	    ip: true
    },
    mac_address: {
        mac: true,
        required: true
    },
    mtu: {
        required: true,
        range: [64, 16128]
    },
    manuFile: {
        required: true
    },
    upgradeFile: {
        required: true
    },
    realName: {
        realName: true
    },
    bindIp: {
        ip: true
    },
    bindMac: {
        mac: true
    },
    validTime: {
        range: [0, 3650]
    },
    validTime_pwd: {
        range: [0, 3650]
    },
    passwd_user: {
        required: true,
        passwd_user: true
    },
    passwd_user_again: {
        equalTo: "#passwd_user"
    },
    userListName: {
        required: true,
        realName: true
    },
    authType: {
        required: true
    },
    twofaType: {
        required: true
    },
    lockTime: {
        required: true,
        range: [0, 3650]
    },
    importFile: {
        required: true
    },
    licenseFile: {
        required:true
    },
    startTime_log: {
        required: '#endTime_log:filled',
        dateTime: ['YYYY/MM/DD hh:mm']
    },
    endTime_log: {
        required: '#startTime_log:filled',
        dateTime: ['YYYY/MM/DD hh:mm']
    },
    sAddr: {
        ip: true   
    }, 
    dAddr: {
        ip: true   
    },
    sport: {
        range: [1, 65535]
    },
    dport: {
        range: [1, 65535]
    },
    roleName: {
        required: true,
        realName: true
    },
    allocatedTime: {
        range: [0, 525600]
    },
	batchToolExportFile: {
		required: true
	},
    hostComment: {
    	maxlength: 20
    },
    managerName: {
    	maxlength: 20
    },
    managerTel: {
    	maxlength: 20
    },
    CPU: {
    	range: [1,100]
    },
    memory: {
    	range: [1,100]
    },
    disk: {
    	range: [1,100]
    },
    trapStr: {
    	maxlength: 32
    },
    readOnly: {
    	maxlength: 32
    },
    writeAndReady: {
    	maxlength: 32
    },
    v3Usrname: {
    	required: '#snmpChk:checked',
    	maxlength: 32
    },
    authPhrase: {
    	required: '#snmpChk:checked',
    	minlength: 8,
    	maxlength: 32
    },
    privPhrase: {
    	required: '#snmpChk:checked',
    	minlength: 8,
    	maxlength: 32
    },
    serverip: {
    	ip: true
    },
    upPort: {
    	required: true,
        range: [1, 65535]
    },
    upAddr: {
    	required: true
    },
    updateFile: {
    	required: true
    },
    gateway: {
        required: true,
	    ip: true
    },
    customId: {
        required: true,
        digits: true,
        remote: {
            url: 'Function/client/customized/tcpTransVisit.php',
            data: {
                checkExistId: true
            }
        }
    },
    lportReq: {
        required: true,
        range: [1, 65535]
    },
    dportReq: {
        required: true,
        range: [1, 65535]
    },
    sportReq: {
        required: true,
        range: [1, 65535]
    },
    lip: {
        required: true
    },
    serverIp: {
        required: true,
        ip: true
    }
};

// message
var validMsg = {
    expTime: '不能小于60秒或超过86400秒(24小时)',
    limitErrNum: '登录错误次数不能小于1次或超过10次',
    limitErrTime: '间隔时间不能小于10秒或超过86400秒(24小时)',
    account: {
        required: '请填写帐号名.'
    },
    passwd: {
        required: '请填写密码.'
    },
    passwd_again: '两次密码不一致.',
    logAdmin: '请至少选择一个帐号类型.',
    ip: {
        required: '请填写IP地址.'
    },
    netmask: {
        required: '请填写子网掩码.'
    },
    comment: '您最多能够输入250个字符.',
    addrName: {
        required: '请填写地址名称.'
    },
    addrGrpName: {
        required: '请填写地址组名称.'
    },
    'addrGrpMember[]': '请至少选择一个地址组成员.',
    ipAddr_r: {
        required: '请输入反IP地址.'
    },
    range_s: {
        required: '请输入起始地址.',
        ipv4: '起始地址只支持IPV4地址.'
    },
    range_e: {
        required: '请输入结束地址.',
        ipv4: '结束地址只支持IPV4地址.'
    },
    netname: '1-20 个ASCII字符.',
    record_type_mx: '请至少选择一个帐号类型.',
    addStaticAddr: '请填写IP地址.',
    ntpSyncInterval: '不能小于1分钟或超过65535分钟.',
    max_record: '请填写最大记录数.',
    interval: '请填写自动解析间隔.',
    autoParseErrInterval: '请填写自动解析记录失效间隔.',
    timeListName: {
        required: '请填写时间列表名称.'
    },
    startTime_f: {
        required: '请填写起始时间.'
    },
    endTime_f: {
        required: '请填写终止时间.'
    },
    startTime_mon: {
        required: '请填写星期一的起始时间.'
    },
    endTime_mon: {
        required: '请填写星期一的终止时间.'
    },
    startTime_tue: {
        required: '请填写星期二的起始时间.'
    },
    endTime_tue: {
        required: '请填写星期二的终止时间.'
    },
    startTime_wed: {
        required: '请填写星期三的起始时间.'
    },
    endTime_wed: {
        required: '请填写星期三的终止时间.'
    },
    startTime_thur: {
        required: '请填写星期四的起始时间.'
    },
    endTime_thur: {
        required: '请填写星期四的终止时间.'
    },
    startTime_fri: {
        required: '请填写星期五的起始时间.'
    },
    endTime_fri: {
        required: '请填写星期五的终止时间.'
    },
    startTime_sat: {
        required: '请填写星期六的起始时间.'
    },
    endTime_sat: {
        required: '请填写星期六的终止时间.'
    },
    startTime_sun: {
        required: '请填写星期日的起始时间.'
    },
    endTime_sun: {
        required: '请填写星期日的终止时间.'
    },
    'timeGrpMember[]': '请至少选择一个时间组成员.',
    timeGroupName: {
        required: '请填写时间组名称.'
    },
	destip: {
        required: '目的地此不能为空'
    },
	nexthopip: {
        required: '下一跳地此不能为空'
    },
    mac_address: {
        required: '请填写MAC地址.'
    },
    mtu: '千兆设备的范围是64-16128',
    manuFile: '请选择要上传的配置文件',
    upgradeFile:'请选择要升级的文件',
    validTime: '0表示永久生效, 要求在0到3650之间',
    validTime_pwd: '0表示永久生效, 要求在0到3650之间',
    passwd_user: {
        required: '请填写密码.'
    },
    passwd_user_again: '两次密码不一致.',
    userListName: {
        required: '用户名称不允许为空.'
    },
    authType: {
        required: '选择任意一种认证方式.'
    },
    twofaType: {
        required: '选择任意一种认证方式.'
    },
    lockTime: {
        required: '请输入锁定时间.',
        range: '0到3650分钟,0表示永久锁定.'
    },
    importFile: '请选择文件',
    licenseFile: '请选择证书',
    startTime_log: {
        required: '请填写起始时间.'
    },
    endTime_log: {
        required: '请填写截至时间.'
    },
    sAddr: {
        ip: '源地址格式错误.'
    },
    dAddr: {
        ip: '目的地址格式错误.'
    },
    sport: '源端口范围1 - 65535',
    dport: '目的端口1 - 65535',
    dnssrv: {
        ip: '域名服务器IP1格式错误.',
        required: '域名服务器IP1不能为空.'
    },
    dnssrv2: '域名服务器IP2格式错误.',
	batchToolExportFile: '请选择要上传的文件',
    v3Usrname: '用户名称不能超过32个字符且不能为空',
    hostComment: '本机备注不能超过20个字符',
    managerName: '负责人姓名不能超过20个字符',
    managerTel: '负责人电话不能超过20个字符',
    CPU: 'CPU 利用率阈值范围1 - 100 %',
    memory: '内存利用率阈值范围1 - 100 %',
    disk: '磁盘利用率阈值本机地址不能为空.范围1 - 100 %',
    trapStr: 'Trap发送字符串不能超过32个字符',
    readOnly: '只读团体字符串不能超过32个字符',
    writeAndReady: '读写团体字符串不能超过32个字符',
    authPhrase: '认证密码不能超过32个字符且不能少于8个字符',
    privPhrase: '加秘密码不能超过32个字符且不能少于8个字符',
    serverip: '管理主机 IP格式错误.',
    ipv4: {
        required: '请填写IPV4或者IPV6地址.'
    },
    ipv6: {
        required: '请填写IPV4或者IPV6地址.'
    },
    ipv4Netmask : {
        required: '请填写IPV4地址的子网掩码.'
    },
    ipv6Netmask : {
        required: '请填写IPV6地址的子网掩码.'
    },
    upPort: {
    	required: '请输入服务器端口.',
    	range: '无效的升级服务器端口.'
    },
    upAddr: '请输入升级服务器地址.',
    updateFile: '请选择要升级的文件',
    gateway : {
        required: '请填写IP地址.'
    },
    customId: {
        required: '请输入任务号.',
        digits: '请填写有效数字.',
        remote: '任务号已存在.'
    },
    dportReq: '目的端口1 - 65535.',
    lip: '本机地址不能为空.',
    lportReq: '本机端口1 - 65535.',
    sportReq: '服务器端口1 - 65535.',
    serverIp: {
        required: '请输入服务器地址.'
    }
};

function validateForm(form, displayId) {
    var options = {
        rules:    validRules,
        messages: validMsg,
        errorClass: 'errorLabel'
    };

    if (displayId !== undefined) {
        options['wrapper']             = 'li';
        options['errorLabelContainer'] = '#' + displayId;
        options['errorClass'] = 'errorContainer';
    }

    return form.validate(options);
}
