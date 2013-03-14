function addOrEditLocalUsrManage(type, title) {
    if (type === 'next') {
        openNewLocalUsrManageDialog();
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
    var dialog = ajaxSubmitForm($('#editLocalUsrManageForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditLocalUsrManageDialog(name) {
    var url  = 'Function/client/safeBrowse/localUsrManage.php';
    var data = {
        tpl    : 'client/safeBrowse/localUsrManage_editDialog.tpl',
        editName : name
    };
    var title   = '管理本地用户';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editLocalUsrManageForm').valid()) {
        	addOrEditLocalUsrManage('edit','结果');
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

function openNewLocalUsrManageDialog() {
    var url   = 'Function/client/safeBrowse/localUsrManage.php';
    var title = '管理本地用户';
    var data  = {
        tpl : 'client/safeBrowse/localUsrManage_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editLocalUsrManageForm').valid()) {
        	addOrEditLocalUsrManage('next','结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editLocalUsrManageForm').valid()) {
        	addOrEditLocalUsrManage('add','结果');
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

function delUsr(name) {
    var url  = 'Function/client/safeBrowse/localUsrManage.php';
    var data = {
        delName: name
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

function openDelLocalUsrManageDialog(name) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons['确定'] = function() {
        delUsr(name);
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

function enablePasswd() {
    if ($("#modifyEnable").attr("checked") == 'checked') {
    	$("input[name='psswd1']").removeAttr("disabled");
    	$("input[name='psswd1']").attr("value","");
    	$("input[name='psswd2']").removeAttr("disabled");
    	$("input[name='psswd2']").attr("value","");
    } else {
    	$("input[name='psswd1']").attr("value","********");
    	$("input[name='psswd1']").attr("disabled",'disabled');
    	$("input[name='psswd2']").attr("value","********");
    	$("input[name='psswd2']").attr("disabled",'disabled');    	
    }
}

function freshTableAndPage() {
    var url = 'Function/client/safeBrowse/localUsrManage.php';
    freshTable(url, $('#localUsrManageTable'));
    freshPagination(url, $('.pager'));
}

