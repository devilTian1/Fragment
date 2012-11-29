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
    ipValidParam: {
        name: 'ip',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.test(value) ||
            /^(([A-F0-9]){4}:){7}([A-F0-9]){4}$/.test(value)
        },
        msg: 'IP格式错误.'
    },
    netmaskValidParam: {
        name: 'netmask',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}/.test(value);
        },
        msg: '子网掩码格式错误.'
    },
    addrNameValidParam: {
        name: 'addrName',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^[a-zA-Z0-9\-_\.]{1,15}$/.test(value);
        },
        msg: '1-15 字母、数字、减号、下划线、点的组合.'
    },
    dateTimeValidParam: {
        name: 'dateTime',
        validMethod: function(value, element, params) {
            var regexpStr =
                '(0?[0-9]|1[0-9]|2[0-3]):(0?[0-9]|[1-5][0-9])';
            if (params[0] === 'YYYY/MM/DD hh:mm(:ss)') {
                regexpStr = '^[0-9]{4}/(0?[1-9]|1[0-2])/(0?[0-9]|[12][0-9]|3[01]) ' +
                    regexpStr + "(:(0?[0-9]|[1-5][0-9]))?";
            } else if(params[0] === 'hh:mm(:ss)') {
                regexpStr += '(:(0?[0-9]|[1-5][0-9]))?';
            } else {}
            var regexp = new RegExp(regexpStr + '$');
            return this.optional(element) || regexp.test(value);
        },
        msg: jQuery.format("格式为{0}")
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
        msg: "起始时间应小于终止时间"
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
        required: true,
        netmask: true
    },
    ipAddr_r: {
        required: true,
	    ip: true
    },
    range_s: {
        required: true,
	    ip: true
    },
    range_e: {
        required: true,
	    ip: true
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
        required: '请输入起始地址.'
    },
    range_e: {
        required: '请输入结束地址.'
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
        required: '请填写星期一的起始时间.',
    },
    endTime_mon: {
        required: '请填写星期一的终止时间.',
    },
    startTime_tue: {
        required: '请填写星期二的起始时间.',
    },
    endTime_tue: {
        required: '请填写星期二的终止时间.',
    },
    startTime_wed: {
        required: '请填写星期三的起始时间.',
    },
    endTime_wed: {
        required: '请填写星期三的终止时间.',
    },
    startTime_thur: {
        required: '请填写星期四的起始时间.',
    },
    endTime_thur: {
        required: '请填写星期四的终止时间.',
    },
    startTime_fri: {
        required: '请填写星期五的起始时间.',
    },
    endTime_fri: {
        required: '请填写星期五的终止时间.',
    },
    startTime_sat: {
        required: '请填写星期六的起始时间.',
    },
    endTime_sat: {
        required: '请填写星期六的终止时间.',
    },
    startTime_sun: {
        required: '请填写星期日的起始时间.',
    },
    endTime_sun: {
        required: '请填写星期日的终止时间.',
    },
    'timeGrpMember[]': '请至少选择一个时间组成员.',
    timeGroupName: {
        required: '请填写时间组名称.'
    }
};

function validateForm(form) {
    return form.validate({
        rules:    validRules,
        messages: validMsg
    });
}
