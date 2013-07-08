function editFtpCommServerAclDialog(id) {
    var url  = 'Function/server/ftp/generalVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改FTP普通访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editFtpCommServerAclForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editFtpCommServerAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 330,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,330)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewFtpCommServerAclDialog() {
    var url   = 'Function/server/ftp/generalVisit.php';
    var title = '添加FTP普通访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editFtpCommServerAclForm').valid()) {
            openNewFtpCommServerAclDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editFtpCommServerAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editFtpCommServerAclForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editFtpCommServerAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 330,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,330)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delFtpCommServerAcl(id) {
    var url  = 'Function/server/ftp/generalVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除FTP普通访问';
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

function delFtpCommServerAclDialog(id) {
    var dialog  = loadingScreen('删除FTP普通访问');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delFtpCommServerAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的FTP普通访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchFtpCommServerAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	var afterSuccessCallback = function() {
            freshTableAndPage();
        };
        ajaxSubmitForm($('#switchFtpCommServerForm_' + id), '结果', undefined,
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
    var url = 'Function/server/ftp/generalVisit.php';
    freshTable(url, $('#ftpCommServerTable'));
    freshPagination(url, $('.pager'));
}
