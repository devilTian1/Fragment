// Method
jQuery.validator.addMethod("letters",
    function(value, element, params) {
        var regexp = new RegExp("^[a-zA-Z]{" + params[0] + "," + params[1] + "}$");
        return this.optional(element) || regexp.test(value);
    },
    jQuery.format("{0}至{1}位英文字母")
);
jQuery.validator.addMethod("passwd",
    function(value, element, params) {
        var regexp = new RegExp("^[a-zA-Z0-9]{" + params[0] + "," + params[1] + "}$");
        return this.optional(element) || regexp.test(value);
    },
    jQuery.format("{0}至{1}位字母或数字")
);

function countUnchecked(doms) {
    return doms.filter(':unchecked').length;
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
    passwd_again: '两次密码不一致',
    logAdmin: '请至少选择一个帐号类型'
};

function validateForm(form) {
    form.validate({
        rules:    validRules ,
        messages: validMsg
    });
}
