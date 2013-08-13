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
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editForm'), '结果', undefined,
                undefined, afterSuccessCallback);
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
    var url   = 'index.php?R=firewall/service/basic/openNewDialog';
    var title = '添加服务';
    var data  = {
        //tpl : 'resConf/filterConf/dataVisit_sql_editDialog.tpl',
		openDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editForm').valid()) {
            openNewDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 800,
        height  : 500,
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

function openDelDialog() {
    var dialog  = loadingScreen('确定要删除吗？');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        del(name);
        $(this).remove();
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
    dialog.setContent("确定要删除基本服务吗？");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'index.php?R=firewall/service/basic/showTable';
    freshTable(url, $("#filterTable"));
    freshPagination(url, $('.pager'),$("#filterTable"));
}