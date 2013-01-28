function addOrEditFilter(type, title) {
    if (type === 'next') {
        openNewFilterDialog();
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
    var dialog = ajaxSubmitForm($('#editFilterForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditFilterDialog(id) {
    var url  = 'Function/client/mail/filter.php';
    var data = {
        tpl    : 'client/mail/filter_editDialog.tpl',
        editId : id
    };
    var title   = '管理过滤选项集配置';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editFilterForm').valid()) {
        	addOrEditFilter('edit','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 550,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewFilterDialog() {
    var url   = 'Function/client/mail/filter.php';
    var title = '管理过滤选项集配置';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editFilterForm').valid()) {
        	addOrEditFilter('next','结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editFilterForm').valid()) {
        	addOrEditFilter('add','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 560,
        buttons : buttons,
        position: ['center', 'top']
    };    
    showDialogByAjax(url, data, title, dialogParams);
}

function delFilter(id) {
    var url  = 'Function/client/mail/filter.php';
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

function openDelFilterDialog(id) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons['确定'] = function() {
        delFilter(id);
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
    var url = 'Function/client/mail/filter.php';
    freshTable(url, $('#filterTable'));
    freshPagination(url, $('.pager'));
}
