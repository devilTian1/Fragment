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
    ipv4ValidParam: {
        name: 'ipv4',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}/.test(value);
        },
        msg: 'IPV4格式错误.'
    },
    ipv6ValidParam: {
        name: 'ipv6',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^(([A-F0-9]){4}(\:|\/\d{1,3}$)){8}/.test(value);
        },
        msg: 'IPV6格式错误.'
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
    ipv4: {
        required: true,
	    ipv4: true
    },
    ipv6: {
        required: true,
        ipv6: true
    },
    netmask: {
        required: true,
        netmask: true
    },
    comment: {
        maxlength: 250
    },
    addrName: {
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
    ipv4: {
        required: '请填写IPV4地址.'
    },
    ipv6: {
        required: '请填写IPV6地址.'
    },
    netmask: {
        required: '请填写子网掩码.'
    },
    comment: '您最多能够输入250个字符.',
    addrName: {
        required: '请填写地址名称.'
    }
};

function validateForm(form) {
    return form.validate({
        rules:    validRules,
        messages: validMsg
    });
}
