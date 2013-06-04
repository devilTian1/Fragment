function openEditDVUserDialog(id) {
    var url  = 'Function/server/db/db.php';
    var data = {
        tpl    : 'server/db/db_editDialog.tpl',
        editId : id
    };
    var title   = '修改普通访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#serverEditForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#serverEditForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 340,
        buttons : buttons,
        position: jQuery.getDialogPosition(680,340)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDbDialog() {
    var url   = 'Function/server/db/db.php';
    var title = '添加普通访问';
    var data  = {
        tpl : 'server/db/db_editDialog.tpl',
		openDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
    	if ($('#serverEditForm').valid()) {
            openDbDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#serverEditForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }        
    };
    buttons[getMessage('Ok')] = function() {
    	if ($('#serverEditForm').valid()) {
    		var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#serverEditForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }       
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 340,
        buttons : buttons,
        position: jQuery.getDialogPosition(680,340)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function del(id) {
    var url  = 'Function/server/db/db.php';
    var data = {
        delId: id
    };
    var title  = '删除普通访问';
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

function openDelDVUserDialog(id) {
    var dialog  = loadingScreen('删除普通访问');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        del(id);
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
    dialog.setContent("<p>确定要删除名称为" + id + "的普通访问吗?</p>");
    dialog.setOptions(dialogParams);   
}
function switchServerCommSer(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	var afterSuccessCallback = function() {
            freshTableAndPage();
        };
        ajaxSubmitForm($('#switchServerCommForm_' + id), '结果', undefined,
            undefined, afterSuccessCallback);
        $(this).remove();
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position: jQuery.getDialogPosition(300,160)
    };

    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '任务[' +  id + ']吗?</p>');
    dialog.setOptions(dialogParams);
}
function freshTableAndPage() {
    var url = 'Function/server/db/db.php';
    freshTable(url, $('#serverDbIdTable'));
    freshPagination(url, $('.pager'));
}
