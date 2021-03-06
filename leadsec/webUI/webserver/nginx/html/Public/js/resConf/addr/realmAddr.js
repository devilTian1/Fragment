function selectedOption() {
    $('#DynamicAddrList option').attr('selected', 'selected');
    $('#staticAddrList option').attr('selected', 'selected');
}

function openNewRealmAddrDialog() {
    var url   = 'Function/layout/showDialog.php';
    var title = '域名地址维护';
    var data  = {
        tpl : 'resConf/addr/editRealmAddrDialog.tpl'
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editRealmAddrForm').valid()) {
            selectedOption();
            openNewRealmAddrDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRealmAddrForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editRealmAddrForm').valid()) {
            selectedOption();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRealmAddrForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 550,
        buttons : buttons,
        position : jQuery.getDialogPosition('620','550')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openEditRealmAddrDialog(id) {
    var url  = 'Function/resConf/addr/realmAddr.php';
    var data = {
        tpl    : 'resConf/addr/editRealmAddrDialog.tpl',
        specId : id
    };
    var title   = '域名地址维护';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editRealmAddrForm').valid()) {
            selectedOption();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRealmAddrForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 550,
        buttons : buttons,
        position : jQuery.getDialogPosition('620','550')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delRealmAddr(name) {
    var url  = 'Function/resConf/addr/realmAddr.php';
    var data = {
        delName: name
    };
    var title  = '删除域名地址';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition('250','170')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelRealmAddrDialog(name,delname) {
    var dialog  = loadingScreen('删除域名地址');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delRealmAddr(delname);
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的域名地址吗?</p>");
    dialog.setOptions(dialogParams);   
}

function refreshRealmAddr(name) {
    var url  = 'Function/resConf/addr/realmAddr.php';
    var data = {
        refreshName: name
    };
    var title  = '刷新域名地址';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition('250','170')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function addStaticAddrList() {
    var newStaticAddrDom = $('#addStaticAddr');
    if ($("#editRealmAddrForm").validate().element(newStaticAddrDom) === true) {
        var isDuplicated = false;
        var ip           = newStaticAddrDom.val();
        if (ip === '') {
            return false;
        }
        var appendToDom  = $('#staticAddrList');
        newStaticAddrDom.val('');
        appendToDom.children('option').each(function() {
            if (ip === $(this).val()) {
                isDuplicated = true;
                return false;
            }
        });
        if (isDuplicated === false) {
            var optionCount = appendToDom.children('option').length;
            $('<option class="multiSelect option" value="' + ip +
                '" id="staticAddrList-' + optionCount + '">' + ip
                +'</option>').appendTo(appendToDom);
        }
    }
}

function deleteStaticAddr() {
    $('#staticAddrList option:selected').remove();
}

function cleanAllStaticAddr() {
    var staticAddrListDom = $('#staticAddrList');
    staticAddrListDom.html('');
}

function freshTableAndPage() {
    var url = 'Function/resConf/addr/realmAddr.php';
    freshTable(url, $('#realmAddrTable'));
    freshPagination(url, $('.pager'));
}
