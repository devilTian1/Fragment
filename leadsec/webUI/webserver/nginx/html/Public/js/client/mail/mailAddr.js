function selectAll(){
	var obj = document.getElementById("mailList");	
	if(obj)
	{
		var length = obj.length;
		
		for(var i=0; i<length ; i++)
		{
			obj.options[i].selected = true;
		}
	}
}

function addOrEditMailAddr(type, title) {
	selectAll();
    if (type === 'next') {
        openNewMailAddrDialog();
    }
    var resultDialog  = loadingScreen(title);
    resultDialog.dialog('moveToTop');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {    	
        resultDialog.close();
    }
    resultDialog.setOptions({
        width : 250,
        height: 170,
        buttons: buttons,
        position : jQuery.getDialogPosition('250','170')
    });
    var successCallback = function(result, textStatus) {
        resultDialog.setContent($('<p>' + result.msg + '</p>'));
        freshTableAndPage();        
    }
    var dialog = ajaxSubmitForm($('#editMailAddrForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditMailAddrDialog(id) {
    var url  = 'Function/client/mail/mailAddr.php';
    var data = {
        tpl    : 'client/mail/mailAddr_editDialog.tpl',
        editId : id
    };
    var title   = '管理邮件地址过滤';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editMailAddrForm').valid()) {
        	addOrEditMailAddr('edit','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 400,
        buttons : buttons,
        position : jQuery.getDialogPosition('680','400')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewMailAddrDialog() {
    var url   = 'Function/client/mail/mailAddr.php';
    var title = '管理邮件地址过滤';
    var data  = {
        tpl : 'client/mail/mailAddr_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editMailAddrForm').valid()) {
        	addOrEditMailAddr('next','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editMailAddrForm').valid()) {
        	addOrEditMailAddr('add','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 400,
        buttons : buttons,
        position : jQuery.getDialogPosition('680','400')
    };    
    showDialogByAjax(url, data, title, dialogParams);
}

function delMailAddr(id, name) {
    var url  = 'Function/client/mail/mailAddr.php';
    var data = {
        delId: id,
        delName:name
    };
    var title  = '删除';
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

function openDelMailAddrDialog(id, name) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delMailAddr(id, name);
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
    dialog.setContent("<p>确定要删除吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/client/mail/mailAddr.php';
    freshTable(url, $('#mailAddrTable'));
    freshPagination(url, $('.pager'));
}