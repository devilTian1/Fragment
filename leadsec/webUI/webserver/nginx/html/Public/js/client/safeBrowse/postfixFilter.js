function addOrEditPostfixFilter(type, title) {
    if (type === 'next') {
        openNewPostfixFilterDialog();
    }
    var buttons = {};
    var afterSuccessCallback = function(result, textStatus){
		if (result.status =='0') { 
			freshTableAndPage(); 
		}
	}
	ajaxSubmitForm($('#editPostfixFilterForm'), '结果', undefined,
         undefined,afterSuccessCallback);
	$(this).remove();
}

function openEditPostfixFilterDialog(list) {
    var url  = 'Function/client/safeBrowse/postfixFilter.php';
    var data = {
        tpl    : 'client/safeBrowse/postfixFilter_editDialog.tpl',
        editList : list
    };
    var title   = '管理后缀名过滤';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editPostfixFilterForm').valid()) {
        	addOrEditPostfixFilter('edit','结果');
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

function openNewPostfixFilterDialog() {
    var url   = 'Function/client/safeBrowse/postfixFilter.php';
    var title = '管理后缀名过滤';
    var data  = {
        tpl : 'client/safeBrowse/postfixFilter_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editPostfixFilterForm').valid()) {
        	addOrEditPostfixFilter('next','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editPostfixFilterForm').valid()) {
        	addOrEditPostfixFilter('add','结果');
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

function delPostfixFilter(list) {
    var url  = 'Function/client/safeBrowse/postfixFilter.php';
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

function openDelPostfixFilterDialog(list) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delPostfixFilter(list);
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
    var url = 'Function/client/safeBrowse/postfixFilter.php';
    freshTable(url, $('#postfixFilterTable'));
    freshPagination(url, $('.pager'));
}