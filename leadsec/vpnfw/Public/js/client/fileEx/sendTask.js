function editSendTaskDialog(id) {
    var url   = 'Function/client/fileEx/sendTask.php';
    var title = '编辑任务';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editSendTaskForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editSendTaskForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 600,
        buttons : buttons,
        position : jQuery.getDialogPosition('660','600')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delSendTask(id) {
    var url  = 'Function/client/fileEx/sendTask.php';
    var data = {
        delId: id
    };
    var title  = '结果';
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

function delSendTaskDialog(id) {
    var dialog  = loadingScreen('删除发送任务');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delSendTask(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的发送任务?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewSendTaskDialog() {
    var url   = 'Function/client/fileEx/sendTask.php';
    var title = '配置任务';
    var dialog = loadingScreen(title);
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editSendTaskForm').valid()) {
            openNewSendTaskDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editSendTaskForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editSendTaskForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editSendTaskForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 600,
        buttons : buttons,
        position : jQuery.getDialogPosition('660','600')
    };

    var buttonsLim = {};
    buttonsLim[getMessage('Ok')] = function() {
        $(this).remove();
    };
    var dialogParamsLim = {
        width : 250,
        height: 170,
        buttons : buttonsLim
    };
    var successCallback = function(result, textStatus) {
        dialog.setContent(result.msg);
        if (result.status == -1) {
            dialog.setOptions(dialogParamsLim);
        } else {
            dialog.setOptions(dialogParams);
        }
    }
    var dc = showDialogByAjax(url, data, title, dialogParams, undefined,
        successCallback);
    dc.close();
}

function switchSendMethod() {
    $('div.changenameDiv').show();
    var fs = $('input:radio[name="sendMethod"]:checked').val();
    if (fs !== 'C') {
        $('div.changenameDiv').hide();
    }
}

function switchFs(port) {
    $('div.smbDiv').show();
    var fs = $('input:radio[name="fs"]:checked').val();
    $('input[name="sendTaskPort"]').val(445);
    if (fs !== 'smbfs') {
        $('input[name="sendTaskPort"]').val(2049);
        $('div.smbDiv').hide();
    }
    if (port != undefined) {
        $('input[name="sendTaskPort"]').val(port);
    }
}

function switchSendTaskAcl(id, action) {
    var title   = '启动/停止发送任务';

    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	var afterSuccessCallback = function() {
            freshTableAndPage();
        };
        ajaxSubmitForm($('#switchSendTaskForm_' + id), '结果', undefined,
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
        position : jQuery.getDialogPosition('300','160')
    };

    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '任务[' +  id + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function filterRes() {
    var lipOpts = $('select[name="lip"]');
    lipOpts.hideOption('option[value*=":"]');
}

function freshTableAndPage() {
    var url = 'Function/client/fileEx/sendTask.php';
    freshTable(url, $('#sendTaskTable'));
    freshPagination(url, $('.pager'));
}
