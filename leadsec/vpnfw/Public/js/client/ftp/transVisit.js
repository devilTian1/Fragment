function editFtpTransClientAclDialog(id) {
    var url  = 'Function/client/ftp/transVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改ftp客户端透明访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editFtpTransClientAclForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editFtpTransClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 440,
        position: jQuery.getDialogPosition(680,440),
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewFtpTransClientAclDialog() {
    var url   = 'Function/client/ftp/transVisit.php';
    var title = '添加ftp客户端透明访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {    	
    	var value = $('#da').val();
    	if(value === ''){
    		showErrorDialog('目的地址不能为空，请先定义地址对象，选择后再添加任务.');
    	}else{    	
	        if ($('#editFtpTransClientAclForm').valid()) {
	            openNewFtpTransClientAclDialog();
	            var afterSuccessCallback = function() {
	                freshTableAndPage();
	            };
	            ajaxSubmitForm($('#editFtpTransClientAclForm'), '结果', undefined,
	                undefined, afterSuccessCallback);
	            $(this).remove();
	        }
      }
    };
    buttons[getMessage('Ok')] = function() {
    	var value = $('#da').val();
    	if(value === ''){
    		showErrorDialog('目的地址不能为空，请先定义地址对象，选择后再添加任务..');
    	}else{
	        if ($('#editFtpTransClientAclForm').valid()) {
	        	var afterSuccessCallback = function() {
	                freshTableAndPage();
	            };
	            ajaxSubmitForm($('#editFtpTransClientAclForm'), '结果', undefined,
	                undefined, afterSuccessCallback);
	            $(this).remove();
	        }
    	}
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 440,
        position: jQuery.getDialogPosition(680,440),
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delFtpTransClientAcl(id) {
    var url  = 'Function/client/ftp/transVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除ftp客户端透明访问';
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

function delFtpTransClientAclDialog(id) {
    var dialog  = loadingScreen('删除透明访问');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delFtpTransClientAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的FTP客户端透明访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchFtpTransClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	var afterSuccessCallback = function() {
            freshTableAndPage();
        };
        ajaxSubmitForm($('#switchFtpTransClientForm_' + id), '结果', undefined,
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

function filterRes() {
    var saOpts  = $('select[name="sa"]');
    var daOpts = $('select[name="da"]');
    saOpts.hideOption('option[value$="_ipv6"]');
    daOpts.hideOption('option[value$="_ipv6"]');
}

function freshTableAndPage() {
    var url = 'Function/client/ftp/transVisit.php';
    freshTable(url, $('#transVisitTable'));
    freshPagination(url, $('.pager'));
}
