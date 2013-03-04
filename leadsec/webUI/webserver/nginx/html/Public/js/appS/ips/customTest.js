function openEditCustomTestDialog(external_name) {
    var url  = 'Function/appS/ips/customTest.php';
    var data = {
        tpl  : 'appS/ips/editCustomTestDialog.tpl',
        name : external_name
    };
    var title   = '修改检测规则';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editAliasForm').valid()) {
            $('#external_name').removeAttr('disabled');
            $('#aliasId').removeAttr('disabled');
            ajaxSubmitForm($('#editAliasForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 800,
        height  : 600,
        buttons : buttons,
        position : ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewCustomTestDialog() {
    var url  = 'Function/appS/ips/customTest.php';
    var title   = '添加检测规则';
    var data  = {
        tpl : 'appS/ips/editCustomTestDialog.tpl',
        openNewCustomTestDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editCustomTestForm').valid()) {
            openNewCustomTestDialog();
            ajaxSubmitForm($('#editCustomTestForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editCustomTestForm').valid()) {
            ajaxSubmitForm($('#editCustomTestForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 800,
        height  : 600,
        buttons : buttons,
        position : ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAlias(name) {
    var url  = 'Function/appS/ips/customTest.php';
    var data = {
        delName: name
    };
    var title  = '删除检测规则';
    var buttons = {};
    buttons['Ok'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelAliasDialog(name) {
    var dialog  = loadingScreen('删除检测规则');
    var buttons = {};
    buttons['Confirm'] = function() {
        delAlias(name);
        $(this).remove();
        freshTableAndPage();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的检测规则吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchAliasDev(name, action, formId) {
    var title   = '启动/停止检测规则';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchAliasDevForm_' + formId), '结果');
        freshTableAndPage();
        $(this).remove();
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '检测规则[' + name  + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/appS/ips/customTest.php';
    freshTable(url, $('#customTestTable'));
    freshPagination(url, $('.pager'));
}
