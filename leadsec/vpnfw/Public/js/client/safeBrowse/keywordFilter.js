function selectAll(){
	var obj = document.getElementById("contextList");	
	if(obj)
	{
		var length = obj.length;
		
		for(var i=0; i<length ; i++)
		{
			obj.options[i].selected = true;
		}
	}
}

function addOrEditKeywordFilter(type, title) {
	selectAll();
    if (type === 'next') {
        openNewKeywordFilterDialog();
    }
    var buttons = {};
	var afterSuccessCallback = function(result, textStatus){
		if (result.status =='0') { 
			freshTableAndPage(); 
		}
	}
	ajaxSubmitForm($('#editKeywordFilterForm'), '结果', undefined,
         undefined,afterSuccessCallback);
	$(this).remove();
}

function openEditKeywordFilterDialog(id) {
    var url  = 'Function/client/safeBrowse/keywordFilter.php';
    var data = {
        tpl    : 'client/safeBrowse/keywordFilter_editDialog.tpl',
        editId : id
    };
    var title   = '管理关键字过滤';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editKeywordFilterForm').valid()) {
        	addOrEditKeywordFilter('edit','结果');
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

function openNewKeywordFilterDialog() {
    var url   = 'Function/client/safeBrowse/keywordFilter.php';
    var title = '管理关键字过滤';
    var data  = {
        tpl : 'client/safeBrowse/keywordFilter_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editKeywordFilterForm').valid()) {
        	addOrEditKeywordFilter('next','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editKeywordFilterForm').valid()) {
        	addOrEditKeywordFilter('add','结果');
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

function delKeywordFilter(id) {
    var url  = 'Function/client/safeBrowse/keywordFilter.php';
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
        buttons : buttons,
        position : jQuery.getDialogPosition('250','170')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelKeywordFilterDialog(id) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delKeywordFilter(id);
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
    var url = 'Function/client/safeBrowse/keywordFilter.php';
    freshTable(url, $('#keywordFilterTable'));
    freshPagination(url, $('.pager'));
}