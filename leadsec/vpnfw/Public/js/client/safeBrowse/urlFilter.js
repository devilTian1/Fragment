function addOrEditUrlFilter(type, title) {
    if (type === 'next') {
        openNewUrlFilterDialog();
    }
    var buttons = {};
    buttons[getMessage('Ok')] = function() {    	
        resultDialog.close();
    }
	var afterSuccessCallback = function(result, textStatus){
		if (result.status =='0') { 
			freshTableAndPage(); 
		}
	}
	ajaxSubmitForm($('#editUrlFilterForm'), '结果', undefined,
         undefined,afterSuccessCallback);
	$(this).remove();
}

function openEditUrlFilterDialog(list) {
    var url  = 'Function/client/safeBrowse/urlFilter.php';
    var data = {
        tpl    : 'client/safeBrowse/urlFilter_editDialog.tpl',
        editList : list
    };
    var title   = '管理URL过滤';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editUrlFilterForm').valid()) {
        	addOrEditUrlFilter('edit','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 280,
        buttons : buttons,
        position : jQuery.getDialogPosition('680','280')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewUrlFilterDialog() {
    var url   = 'Function/client/safeBrowse/urlFilter.php';
    var title = '管理URL过滤';
    var data  = {
        tpl : 'client/safeBrowse/urlFilter_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editUrlFilterForm').valid()) {
        	addOrEditUrlFilter('next','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editUrlFilterForm').valid()) {
        	addOrEditUrlFilter('add','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 280,
        buttons : buttons,
        position : jQuery.getDialogPosition('680','280')
    };    
    showDialogByAjax(url, data, title, dialogParams);
}

function delUrlFilter(list) {
    var url  = 'Function/client/safeBrowse/urlFilter.php';
    var data = {
        delList: list
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

function openDelUrlFilterDialog(list) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delUrlFilter(list);
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
    var url = 'Function/client/safeBrowse/urlFilter.php';
    freshTable(url, $('#urlFilterTable'));
    freshPagination(url, $('.pager'));
}