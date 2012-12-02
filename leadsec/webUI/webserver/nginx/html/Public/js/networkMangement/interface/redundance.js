function openEditRedundanceDialog(external_name) {
    var url  = 'Function/networkMangement/interface/redundance.php';
    var data = {
        tpl    : 'networkMangement/interface/editRedundanceDialog.tpl',
        external_name : external_name
    };
    var title   = '修改冗余设备';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editRedundanceForm').valid()) {
            ajaxSubmitForm($('#editRedundanceForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 780,
        height  : 550,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewRedundanceDialog() {
    var url   = 'Function/layout/showDialog.php';
    var title   = '添加冗余设备';
    var data  = {
        tpl : 'networkMangement/interface/editRedundanceDialog.tpl'
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editRedundanceForm').valid()) {
            openNewAliasDialog();
            ajaxSubmitForm($('#editRedundanceForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editrRedundanceForm').valid()) {
            ajaxSubmitForm($('#editRedundanceForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 700,
        height  : 520,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAlias(name) {
    var url  = 'Function/networkMangement/interface/redundance.php';
    var data = {
        delName: name
    };
    var title  = '删除冗余设备';
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
    var dialog  = loadingScreen('删除冗余设备');
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
    dialog.setContent("<p>确定要删除名称为" + name + "的冗余设备吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/networkMangement/interface/redundance.php';
    freshTable(url, $('#redundanceTable'));
    freshPagination(url, $('.pager'));
}
