function switchModStat() {
    var buttons = {};
    var domClass = $('#modechk').attr('class');
    if (domClass.indexOf('on') != -1) {
        var active = 'stop';
    } else if (domClass.indexOf('off') != -1) {
        var active = 'start';
    }
        var dialogParamsDisable = {
            width : 250,
            height: 170,
            closeOnEscape: false,
            position : jQuery.getDialogPosition('250','170')
        };
    buttons[getMessage('Ok')] = function() {
        var dialog_waiting = loadingScreen(getMessage('Switch Module'));
        dialog_waiting.setContent('<p>' + getMessage('loading') + '</p>');
        dialog_waiting.setOptions(dialogParamsDisable);
        $(".ui-dialog-titlebar-close").hide();
        var frag = $('#modechk').attr('name').split('|');
        var data = {
            switchModStat : true,
            serv          : frag[2],
            active        : active
        }
        var params = {
            dataType: 'JSON',
            success: function(result) {
                dialog_waiting.close();
                if (result.status === 0) {
                    var ledDom = $('#modechk');
                    var ledClass =
                        active === 'start' ? 'modelchk_on' : 'modelchk_off';
                    ledDom.removeClass('modelchk_off modelchk_on')
                          .addClass(ledClass);
                   var tip =
                        active === 'start' ? '点击后将关闭服务。' : '点击后将启动服务。';
                    $("#modechk").removeAttr("title");
                    $("#modechk").attr("title",tip);
                    $("#modechk").tooltip();
                } else {
                    showErrorDialog(result.msg);
                }
           }
        }
        loadAjax('Function/modStatus.php', data, params);
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogOptions = {
        buttons: buttons
    };
    var dialog = loadingScreen(getMessage('Switch Module'));
    var msg = getMessage('Do you confirm to ' + active + ' this service');
    dialog.setContent('<p>' + msg + '?</p>');
    dialog.setOptions(dialogOptions);
}

function findSubServName(l2, link) {
    if (link.indexOf('pop3') !== -1) {
        return 'pop3';
    } else if (link.indexOf('smtp') !== -1) {
        return 'smtp';
    } else if (link.indexOf('tcp') !== -1) {
        return 'tcp';
    } else if (link.indexOf('udp') !== -1) {
        return 'udp';
    } else {
        return l2;
    }
}

function isHideLed(l2) {
    if (l2.indexOf('mail') !== -1 || l2.indexOf('customized') !== -1) {
        return true;
    } else {
        return false;
    }
}

function freshModStat(baseurl, link) {
    var arr  = baseurl.split('/');
    var l1   = arr[0].toLowerCase();
    var l2   = findSubServName(arr[1], link);

    var ledDom = $('#modechk');
    ledDom.removeClass('modelchk_off modelchk_on');
    if (isHideLed(l2)) {
        return false;
    }
    if ((l1 == 'client' || l1 == 'server') && ledDom.length === 1) {
        var data = {
            getModStatus : true,
            l1           : l1,
            l2           : l2
        };
        var params = {
            dataType: 'JSON',
            success: function(result) {
                var domName = 'modechk|' + l2 + '|' + result.serv;
                ledDom.attr('name', domName);
                if (result.active === 'on') {
                    ledDom.addClass('modelchk_on');
                } else if (result.active === 'off') {
                    ledDom.addClass('modelchk_off');
                } else {
                    // false
                }
            }
        };
        loadAjax('Function/modStatus.php', data, params);
    }
    return true;
}
