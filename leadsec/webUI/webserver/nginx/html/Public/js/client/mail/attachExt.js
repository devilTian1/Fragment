function selectAll(){
	var obj = document.getElementById("attachList");	
	if(obj)
	{
		var length = obj.length;
		
		for(var i=0; i<length ; i++)
		{
			obj.options[i].selected = true;
		}
	}
}

function addOrEditAttachExt(type, title) {
	selectAll();
    if (type === 'next') {
        openNewAttachExtDialog();
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
        buttons: buttons
    });
    var successCallback = function(result, textStatus) {
        resultDialog.setContent($('<p>' + result.msg + '</p>'));
        freshTableAndPage();        
    }
    var dialog = ajaxSubmitForm($('#editAttachExtForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditAttachExtDialog(id) {
    var url  = 'Function/client/mail/attachExt.php';
    var data = {
        tpl    : 'client/mail/attachExt_editDialog.tpl',
        editId : id
    };
    var title   = '管理附件扩展名';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editAttachExtForm').valid()) {
        	addOrEditAttachExt('edit','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 370,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewAttachExtDialog() {
    var url   = 'Function/client/mail/attachExt.php';
    var title = '管理附件扩展名';
    var data  = {
        tpl : 'client/mail/attachExt_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editAttachExtForm').valid()) {
        	addOrEditAttachExt('next','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editAttachExtForm').valid()) {
        	addOrEditAttachExt('add','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 370,
        buttons : buttons,
        position: ['center', 'top']
    };    
    showDialogByAjax(url, data, title, dialogParams);
}

function delAttachExt(id) {
    var url  = 'Function/client/mail/attachExt.php';
    var data = {
        delId: id
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
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelAttachExtDialog(id) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delAttachExt(id);
        $(this).remove();        
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/client/mail/attachExt.php';
    freshTable(url, $('#attachExtTable'));
    freshPagination(url, $('.pager'));
}