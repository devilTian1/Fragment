// Use anonymous function to avoid variable "strings" to be accessed by public
(function() {
    var strings = {
        'loading': {
            'zh_CN': '正在读取中, 请稍候.'
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
            'zh_CN': '确定要删除用户[%1s]吗?'
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
