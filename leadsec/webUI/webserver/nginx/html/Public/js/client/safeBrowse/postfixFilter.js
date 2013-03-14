function addOrEditPostfixFilter(type, title) {
    if (type === 'next') {
        openNewPostfixFilterDialog();
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
    var dialog = ajaxSubmitForm($('#editPostfixFilterForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditPostfixFilterDialog(list) {
    var url  = 'Function/client/safeBrowse/postfixFilter.php';
    var data = {
        tpl    : 'client/safeBrowse/postfixFilter_editDialog.tpl',
        editList : list
    };
    var title   = '管理文件名后缀过滤';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editPostfixFilterForm').valid()) {
        	addOrEditPostfixFilter('edit','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 280,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewPostfixFilterDialog() {
    var url   = 'Function/client/safeBrowse/postfixFilter.php';
    var title = '管理文件名后缀过滤';
    var data  = {
        tpl : 'client/safeBrowse/postfixFilter_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editPostfixFilterForm').valid()) {
        	addOrEditPostfixFilter('next','结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editPostfixFilterForm').valid()) {
        	addOrEditPostfixFilter('add','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 280,
        buttons : buttons,
        position: ['center', 'top']
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

function openDelPostfixFilterDialog(list) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons['确定'] = function() {
        delPostfixFilter(list);
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
    var url = 'Function/client/safeBrowse/postfixFilter.php';
    freshTable(url, $('#postfixFilterTable'));
    freshPagination(url, $('.pager'));
}