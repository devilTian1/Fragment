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
            /^\w{1}$/.test(value);
        },
        msg: 'IPV6格式错误.'
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
        },
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
    },
    comment: {
        maxlength: 250
    }
};

// message
var validMsg = {
    expTime: '不能小于60秒或超过86400秒(24小时)',
    account: {
        required: '请填写帐号名.'
    },
    passwd: {
        required: '请填写密码.'
    },
    passwd_again: '两次密码不一致.',
    logAdmin: '请至少选择一个帐号类型.',
    netmask: '子网掩码格式错误',
    comment: '您最多能够输入250个字符.'
};

function validateForm(form) {
    form.validate({
        rules:    validRules ,
        messages: validMsg
    });
}
