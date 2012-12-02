function openEditAliasDialog(external_name) {
    var url  = 'Function/networkMangement/interface/alias.php';
    var data = {
        tpl    : 'networkMangement/interface/editAliasDialog.tpl',
        external_name : external_name
    };
    var title   = '修改别名设备';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editAliasForm').valid()) {
            ajaxSubmitForm($('#editAliasForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 550,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewAliasDialog() {
    var url   = 'Function/layout/showDialog.php';
    var title   = '添加别名设备';
    var data  = {
        tpl : 'networkMangement/interface/editAliasDialog.tpl'
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editAddrListForm').valid()) {
            openNewAliasDialog();
            ajaxSubmitForm($('#editAliasForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editAliasForm').valid()) {
            ajaxSubmitForm($('#editAliasForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 440,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAlias(name) {
    var url  = 'Function/networkMangement/interface/alias.php';
    var data = {
        delName: name
    };
    var title  = '删除别名设备';
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
    var dialog  = loadingScreen('删除别名设备');
    var buttons = {};
    buttons['Confirm'] = function() {
        delAddr(name);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的别名设备吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/networkMangement/interface/alias.php';
    freshTable(url, $('#aliasTable'));
    freshPagination(url, $('.pager'));
}
