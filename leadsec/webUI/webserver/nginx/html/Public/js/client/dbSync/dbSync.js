function openEditDialog(id) {
    var url  = 'Function/client/dbSync/dbSync.php';
	var title   = '修改数据库同步';
    var data = {
        editId : id
    };
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editForm').valid()) {
			 var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 470,
        buttons : buttons,
		position: jQuery.getDialogPosition(680,470)
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function openNewDialog() {
    var url   = 'Function/client/dbSync/dbSync.php';
    var title = '添加数据库同步';
    var data  = {
        tpl : 'client/dbSync/dbSync_editDialog.tpl',
		openDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editForm').valid()) {
            openNewDialog();
			var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editForm').valid()) {
			var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 470,
        buttons : buttons,
		position: jQuery.getDialogPosition(680,470)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelDialog(id) {
    var dialog  = loadingScreen('删除客户端数据库同步');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delDbSyncClient(id);
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
    dialog.setContent("<p>确定要删除吗?</p>");
    dialog.setOptions(dialogParams);   
}

function delDbSyncClient(id) {
	var url  = 'Function/client/dbSync/dbSync.php';
    var data = {
		delId : id
    };
    var title   = '删除客户端数据库同步';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
		buttons: buttons,
        position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function toggleCNameDiv() {
    if ($("input:radio[name='ssl']:checked").val() === 'Y') {
        $(".cNameDiv").show();
    } else { 
        $(".cNameDiv").hide();
    }
}

function filterRes() {
    var type    = $('input:radio[name="ipType"]:checked').val();
    var saOpts  = $('select[name="sa"]');
    var lipOpts = $('select[name="clientDbSyncLip"]');
    saOpts.showOption(); 
    lipOpts.showOption(); 
    if (type === 'ipv4') {
        saOpts.hideOption('option[value$="_ipv6"]');
        lipOpts.hideOption('option[value*=":"]');
    } else if (type === 'ipv6') {
        saOpts.hideOption('option[value$="_ipv4"]');
        lipOpts.hideOption('option[value*="."]');
    }
}

function switchPhysicalDev(id, action, formId) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
		var afterSuccessCallback = function() {
                freshTableAndPage();
            };
        ajaxSubmitForm($('#switchForm_' + formId), '结果',undefined,
			undefined,afterSuccessCallback);
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
    dialog.setContent('<p>确定' + str + '任务[' + id  + ']吗?</p>');
    dialog.setOptions(dialogParams);
}


function freshTableAndPage() {
    var url = 'Function/client/dbSync/dbSync.php';
    freshTable(url, $('#dbSyncTable'));
    freshPagination(url, $('.pager'));
}
