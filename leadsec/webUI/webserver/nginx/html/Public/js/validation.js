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
    }
};
for (var i in validMethodParams) {
    addValidMethod(validMethodParams[i]);
}

// rule
var validRules = {
    expTime: {
        required: true,
        min: 60,
        max: 86400
    },
    limitErrNum: {
        required: true,
        min: 1,
        max: 10
    },
    limitErrTime: {
        required: true,
        min: 10,
        max: 86400
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
        min: 1,
        max: 65535
    },
    max_record: {
        required: true,
        min: 1,
        max: 65535
    },
    interval: {
        required: true,
        min: 1,
        max: 65535
    },
    autoParseErrInterval: {
        required: true,
        min: 1,
        max: 65535
    },
    timeListName: {
        required: true,
        addrName: true
    },
    startTime: {
        required: true,
        dateTime: ['YYYY/MM/DD hh:mm(:ss)']
    },
    endTime: {
        required: true,
        dateTime: ['YYYY/MM/DD hh:mm(:ss)']
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
    startTime: {
        required: '请填写起始时间'
    },
    endTime: {
        required: '请填写终止时间'
    }
};

function validateForm(form) {
    return form.validate({
        rules:    validRules,
        messages: validMsg
    });
}
