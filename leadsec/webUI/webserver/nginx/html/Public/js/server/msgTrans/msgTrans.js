function openEditDialog(id) {
    var url  = 'Function/server/msgTrans/msgTrans.php';
    var data = {
        editId : id
    };
    var title   = '修改消息传输';
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
        height  : 380,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,380)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewDialog() {
    var url   = 'Function/server/msgTrans/msgTrans.php';
    var title = '添加消息传输';
    var data  = {
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
        width   : 600,
        height  : 380,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,380)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function del(id) {
    var url  = 'Function/server/msgTrans/msgTrans.php';
    var data = {
        delId: id
    };
    var title  = '删除消息传输';
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

function openDelDialog(id) {
    var dialog  = loadingScreen('删除消息传输');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        del(id);
        $(this).remove();
        freshTableAndPage();
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
    dialog.setContent("<p>确定要删除序号为" + id + "的消息传输吗?</p>");
    dialog.setOptions(dialogParams);   
}
function switchServerMsg(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	var afterSuccessCallback = function() {
            freshTableAndPage();
        };
        ajaxSubmitForm($('#switchServerMsgForm_' + id), '结果', undefined,
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
    var url = 'Function/server/msgTrans/msgTrans.php';
    freshTable(url, $('#msgTransTable'));
    freshPagination(url, $('.pager'));
}