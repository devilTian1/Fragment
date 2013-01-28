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
    buttons['Ok'] = function() {    	
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
    buttons['确定'] = function() {
        if ($('#editMailAddrForm').valid()) {
        	addOrEditMailAddr('edit','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 440,
        buttons : buttons,
        position: ['center', 'top']
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
    buttons['添加下一条'] = function() {
        if ($('#editMailAddrForm').valid()) {
        	addOrEditMailAddr('next','结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editMailAddrForm').valid()) {
        	addOrEditMailAddr('add','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 440,
        buttons : buttons,
        position: ['center', 'top']
    };    
    showDialogByAjax(url, data, title, dialogParams);
}

function delMailAddr(id) {
    var url  = 'Function/client/mail/mailAddr.php';
    var data = {
        delId: id
    };
    var title  = '删除';
    var buttons = {};
    buttons['Ok'] = function() {
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

function openDelMailAddrDialog(id) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons['确定'] = function() {
        delMailAddr(id);
        $(this).remove();        
    };
    buttons['取消']  = function() {
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
    var url = 'Function/client/mail/mailAddr.php';
    freshTable(url, $('#mailAddrTable'));
    freshPagination(url, $('.pager'));
}