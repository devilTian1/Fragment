function isInUseCheck(external_name,func) {
    var url  = 'Function/networkManagement/interface/alias.php';
    var data = {
        isInUseCheck  : true,
        checkName : external_name
    };
        var params = {
        type    : 'GET',
        success : function(result) {
            if (result == 'true') {
                OpenTipsDialog(external_name);
            } else {
                func(external_name);
            }
        }
    };    
    //showDialogByAjax(url, data, title, dialogParams);    
    loadAjax(url, data, params);
}

function OpenTipsDialog(external_name) {
    var title   = '提示';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['关闭'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        Height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent('<p>别名设备[' + external_name  + ']正被引用，不能修改或删除此别名。</p>');
    dialog.setOptions(dialogParams);
}

function openEditAliasDialog(external_name) {
    var url  = 'Function/networkManagement/interface/alias.php';
    var data = {
        tpl  : 'networkManagement/interface/editAliasDialog.tpl',
        name : external_name
    };
    var title   = '修改别名设备';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editAliasForm').valid()) {
            $('#external_name').removeAttr('disabled');
            $('#aliasId').removeAttr('disabled');
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editAliasForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 390,
        buttons : buttons,
        position : ['center', 'top'],
        position : jQuery.getDialogPosition('620','390')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewAliasDialog() {
    var url  = 'Function/networkManagement/interface/alias.php';
    var title   = '添加别名设备';
    var data  = {
        tpl : 'networkManagement/interface/editAliasDialog.tpl',
        openNewAliasDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editAliasForm').valid()) {
            openNewAliasDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editAliasForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editAliasForm').valid()) {
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editAliasForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 440,
        buttons : buttons,
        position : ['center', 'top'],
        position : jQuery.getDialogPosition('600','440')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAlias(name) {
    var url  = 'Function/networkManagement/interface/alias.php';
    var data = {
        delName: name
    };
    var title  = '删除别名设备';
    var buttons = {};
    buttons['关闭'] = function() {
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

function openDelAliasDialog(name) {
    var dialog  = loadingScreen('删除别名设备');
    var buttons = {};
    buttons['确定'] = function() {
        delAlias(name);
        $(this).remove();
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的别名设备吗?</p>");
    dialog.setOptions(dialogParams);   
}

function isSwitchCheck(external_name,action,formId,func) {
    var url  = 'Function/networkManagement/interface/alias.php';
    var data = {
        isInUseCheck  : true,
        checkName : external_name
    };
        var params = {
        type    : 'GET',
        success : function(result) {
            if (result == 'true') {
                OpenTipsDialog(external_name);
            } else {
                func(external_name,action,formId);
            }
        }
    };    
    //showDialogByAjax(url, data, title, dialogParams);    
    loadAjax(url, data, params);
}

function switchAliasDev(name, action, formId) {
    var title   = '启动/停止别名设备';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        var afterSuccessCallback = function() {
                freshTableAndPage();
        };
        ajaxSubmitForm($('#switchAliasDevForm_' + formId), '结果', undefined,
                undefined, afterSuccessCallback);
        $(this).remove();
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '别名设备[' + name  + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/networkManagement/interface/alias.php';
    freshTable(url, $('#aliasTable'));
    freshPagination(url, $('.pager'));
}
