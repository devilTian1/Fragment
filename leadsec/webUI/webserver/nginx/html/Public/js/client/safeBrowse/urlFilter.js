function addOrEditUrlFilter(type, title) {
    if (type === 'next') {
        openNewUrlFilterDialog();
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
    var dialog = ajaxSubmitForm($('#editUrlFilterForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditUrlFilterDialog(list) {
    var url  = 'Function/client/safeBrowse/urlFilter.php';
    var data = {
        tpl    : 'client/safeBrowse/urlFilter_editDialog.tpl',
        editList : list
    };
    var title   = '管理URL过滤';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editUrlFilterForm').valid()) {
        	addOrEditUrlFilter('edit','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 300,
        buttons : buttons,
        position: ['center', 'top']
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
    buttons['添加下一条'] = function() {
        if ($('#editUrlFilterForm').valid()) {
        	addOrEditUrlFilter('next','结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editUrlFilterForm').valid()) {
        	addOrEditUrlFilter('add','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 300,
        buttons : buttons,
        position: ['center', 'top']
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

function openDelUrlFilterDialog(list) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons['确定'] = function() {
        delUrlFilter(list);
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
    var url = 'Function/client/safeBrowse/urlFilter.php';
    freshTable(url, $('#urlFilterTable'));
    freshPagination(url, $('.pager'));
}