function editAllowedContentDialog(whitelist) {
    var url   = 'Function/client/msgTrans/callowedContent.php';
    var title = '编辑内容白名单';
    var data  = {
		editId: whitelist
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editAllowedContentForm').valid()) {
            ajaxSubmitForm($('#editAllowedContentForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 300,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delBannedContent(whitelist) {
    var url  = 'Function/client/msgTrans/callowedContent.php';
    var data = {
        delId: whitelist
    };
    var title  = '删除内容白名单';
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

function delAllowedContentDialog(whitelist) {
    var dialog  = loadingScreen('删除内容白名单');
    var buttons = {};
    buttons['Confirm'] = function() {
        delBannedContent(whitelist);
        freshTableAndPage();
        $(this).remove();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除内容为" + whitelist + "的内容白名单吗?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewAllowedContentDialog() {
    var url   = 'Function/client/msgTrans/callowedContent.php';
    var title = '添加内容白名单';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editAllowedContentForm').valid()) {
        	openNewAllowedContentDialog();
            ajaxSubmitForm($('#editAllowedContentForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editAllowedContentForm').valid()) {
            ajaxSubmitForm($('#editAllowedContentForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 300,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/client/msgTrans/callowedContent.php';
    freshTable(url, $('#allowedContentTable'));
    freshPagination(url, $('.pager'));
}

function switchCtl() {
    ajaxSubmitForm($('#ctlForm'), '结果');
}
