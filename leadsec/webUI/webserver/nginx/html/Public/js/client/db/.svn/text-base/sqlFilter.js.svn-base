function openEditDialog(id) {
    var url  = 'Function/client/db/sqlFilter.php';
    var data = {
        //tpl    : 'resConf/filterConf/dataVisit_sql_editDialog.tpl',
        editId : id
    };
    var title   = '修改SQL语句过滤';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editForm').valid()) {
            ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 450,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,450)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewDialog() {
    var url   = 'Function/client/db/sqlFilter.php';
    var title = '添加SQL语句过滤';
    var data  = {
        //tpl : 'resConf/filterConf/dataVisit_sql_editDialog.tpl',
		openDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editForm').valid()) {
            openNewDialog();
            ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editForm').valid()) {
            ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 450,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,450)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function del(name) {
    var url  = 'Function/client/db/sqlFilter.php';
    var data = {
        delName: name
    };
    var title  = '删除SQL语句过滤';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelDialog(name,id) {
    var dialog  = loadingScreen('删除SQL语句过滤');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        del(name);
        $(this).remove();
        freshTableAndPage();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的SQL语句过滤吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/client/db/sqlFilter.php';
    freshTable(url, $('#dataVisit_sqlTable'));
    freshPagination(url, $('.pager'));
}