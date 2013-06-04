function selectAll(){
	var obj = document.getElementById("keywordList");	
	if(obj)
	{
		var length = obj.length;
		
		for(var i=0; i<length ; i++)
		{
			obj.options[i].selected = true;
		}
	}
}

function addOrEditKeyword(type, title) {
	selectAll();
    if (type === 'next') {
        openNewKeywordDialog();
    }
    var afterSuccessCallback = function() {
        freshTableAndPage();
    };
    ajaxSubmitForm($('#editKeywordForm'), '结果', undefined,
        undefined, afterSuccessCallback);    
}

function openEditKeywordDialog(id) {
    var url  = 'Function/client/mail/keyword.php';
    var data = {
        tpl    : 'client/mail/keyword_editDialog.tpl',
        editId : id
    };
    var title   = '管理关键字设置';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editKeywordForm').valid()) {
        	addOrEditKeyword('edit','结果');
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

function openNewKeywordDialog() {
    var url   = 'Function/client/mail/keyword.php';
    var title = '管理关键字设置';
    var data  = {
        tpl : 'client/mail/keyword_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editKeywordForm').valid()) {
        	addOrEditKeyword('next','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editKeywordForm').valid()) {
        	addOrEditKeyword('add','结果');
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

function delKeyword(id, name) {
    var url  = 'Function/client/mail/keyword.php';
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

function openDelKeywordDialog(id, name) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delKeyword(id, name);
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
    var url = 'Function/client/mail/keyword.php';
    freshTable(url, $('#keywordTable'));
    freshPagination(url, $('.pager'));
}