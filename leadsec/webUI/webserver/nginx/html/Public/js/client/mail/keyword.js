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
    var dialog = ajaxSubmitForm($('#editKeywordForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditKeywordDialog(id) {
    var url  = 'Function/client/mail/keyword.php';
    var data = {
        tpl    : 'client/mail/keyword_editDialog.tpl',
        editId : id
    };
    var title   = '管理关键字设置';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editKeywordForm').valid()) {
        	addOrEditKeyword('edit','结果');
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

function openNewKeywordDialog() {
    var url   = 'Function/client/mail/keyword.php';
    var title = '管理关键字设置';
    var data  = {
        tpl : 'client/mail/keyword_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editKeywordForm').valid()) {
        	addOrEditKeyword('next','结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editKeywordForm').valid()) {
        	addOrEditKeyword('add','结果');
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

function delKeyword(id) {
    var url  = 'Function/client/mail/keyword.php';
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

function openDelKeywordDialog(id) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons['确定'] = function() {
        delKeyword(id);
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
    var url = 'Function/client/mail/keyword.php';
    freshTable(url, $('#keywordTable'));
    freshPagination(url, $('.pager'));
}