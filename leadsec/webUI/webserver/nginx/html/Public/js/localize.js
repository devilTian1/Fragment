// Use anonymous function to avoid variable "strings" to be accessed by public
(function() {
    var strings = {
        'loading': {
            'zh_CN': '正在读取中，请稍候'
        },
        'error': {
            'zh_CN': '错误'
        },
        'Ok': {
            'zh_CN': '确定'
        },
        'Cancel': {
            'zh_CN': '取消'
        },
        'Add Next': {
            'zh_CN': '添加下一条'
        },
        'CPU Used': {
            'zh_CN': 'CPU利用率'
        },
        'Mem Used': {
            'zh_CN': '内存利用率'
        },
        'Resource Status': {
            'zh_CN': '资源监控图'
        },
        'Confirm': {
            'zh_CN': '确认'
        },
        'Reach Upper Limit 1000': {
            'zh_CN': '到达上限1000个'
        },
        'Delete Account': {
            'zh_CN': '删除用户'
        },
        'Do you confirm to delete account [%1s]?': {
            'zh_CN': '确定要删除用户[%1s]吗？'
        },
        'Switch Module': {
            'zh_CN': '模块启停'
        },
        'Do you confirm to start this service': {
            'zh_CN': '确定要启动此服务吗'
        },
        'Do you confirm to stop this service': {
            'zh_CN': '确定要停止此服务吗'
        },
        'Required': {
            'zh_CN': '必填'
        },
        'Please enter only digits': {
            'zh_CN': '请填写有效数字'
        },
        'Task id range between 1 and 1000': {
            'zh_CN': '任务号范围是1至1000'
        },
        'Task id range between 1 and 500': {
            'zh_CN': '任务号范围是1至500'
        },
        'Task id range between 1 and 20': {
            'zh_CN': '任务号范围是1至20'
        },
        'This id has been used': {
            'zh_CN': '此任务号已被使用'
        },
        'This port has been used': {
            'zh_CN': '此端口号已被使用'
        },
        'Task id plus dport exist': {
            'zh_CN': '任务号+目的端口号的和已存在'
        },
        'Port range between 1 and 65535': {
            'zh_CN': '端口号范围是1至65535'
        },
        'The combination of lip and lport has been used': {
            'zh_CN': '此本机地址和端口的组合已被使用'
        },
        'Task id range between 1 and 200': {
            'zh_CN': '任务号范围是1至200'
        },
        'normal format': {
            'zh_CN': '正常格式'
        },
        'encrypt format': {
            'zh_CN': '加密格式'
        },
        'readable format': {
            'zh_CN': '可读格式'
        },
        'config file format': {
            'zh_CN': '配置文件的保存格式？'
        },
        'Task Id + dport  >= 65535': {
            'zh_CN': '任务号 + 目的地址 >= 65535'
        },
        'Result' : {
            'zh_CN': '结果'
        },
        'ERROR' : {
            'zh_CN': '错误'
        },
        'request error': {
            'zh_CN': '请求出错'
        },
        'Respone text': {
            'zh_CN': '返回信息'
        },
        'error msg': {
            'zh_CN': '错误信息'
        },
        'id+port+%1s<=65535': {
            'zh_CN': '任务号+端口号+%1s不大于65535'
        },
        'Rebooting. It will take two or three mins and then please relogin.': {
            'zh_CN': '安全隔离网闸正在重启,将耗时2-3分钟.请不要进行任何操作,请重新登录。'
        },
        'None': {
            'zh_CN': '空'
        },
        'destPort is required': {
            'zh_CN': '目的端口必填'
        }
    };

    /*
     * Get localized string.
     * @param id
     *  Translation string ID
     * @param prop
     *  Optional. An array of string, substitute %1s, %2s, ... in translated string
     * @return
     *  Translated string.
     */
    window.getMessage = function(id, prop) {
        locale = getCookie('web_locale');
        // if the corresponding locale string is undefined, return the id, just as 
        // what gettext does. Common for english.
        if (strings[id] == undefined) {
            str = id;
        } else {
            // We check the full locale (eg. zh_CN.UTF-8) first.
            if (strings[id][locale] == undefined) {
                // If undefined, check the short locale (eg. zh_CN)
                locale = locale.split('.', 1);
            }
            if (strings[id][locale] == undefined) {
                str = id;
            } else {
                str = strings[id][locale];
            }
        }

        if (prop == undefined) {
            return str;
        } else {
            // string substitution
            var i = 1;
            for (key in prop) {
                str = str.replace("%" + i + "s", prop[key]);
                i++;
            }
            return str;
        }
    }
})();
