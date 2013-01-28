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
    var dialog = ajaxSubmitForm($('#editKeywordFilterForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditKeywordFilterDialog(id) {
    var url  = 'Function/client/safeBrowse/keywordFilter.php';
    var data = {
        tpl    : 'client/safeBrowse/keywordFilter_editDialog.tpl',
        editId : id
    };
    var title   = '管理关键字过滤';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editKeywordFilterForm').valid()) {
        	addOrEditKeywordFilter('edit','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 420,
        buttons : buttons,
        position: ['center', 'top']
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
    buttons['添加下一条'] = function() {
        if ($('#editKeywordFilterForm').valid()) {
        	addOrEditKeywordFilter('next','结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editKeywordFilterForm').valid()) {
        	addOrEditKeywordFilter('add','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 420,
        buttons : buttons,
        position: ['center', 'top']
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

function openDelKeywordFilterDialog(id) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons['确定'] = function() {
        delKeywordFilter(id);
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
    var url = 'Function/client/safeBrowse/keywordFilter.php';
    freshTable(url, $('#keywordFilterTable'));
    freshPagination(url, $('.pager'));
}