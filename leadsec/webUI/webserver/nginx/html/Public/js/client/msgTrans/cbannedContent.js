function editBannedContentDialog(blacklist) {
    var url   = 'Function/client/msgTrans/cbannedContent.php';
    var title = '编辑内容黑名单';
    var data  = {
		editId: blacklist
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editBannedContentForm').valid()) {
            ajaxSubmitForm($('#editBannedContentForm'), '结果');
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

function delBannedContent(blacklist) {
    var url  = 'Function/client/msgTrans/cbannedContent.php';
    var data = {
        delId: blacklist
    };
    var title  = '删除内容黑名单';
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

function delBannedContentDialog(blacklist) {
    var dialog  = loadingScreen('删除内容黑名单');
    var buttons = {};
    buttons['Confirm'] = function() {
        delBannedContent(blacklist);
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
    dialog.setContent("<p>确定要删除内容为" + blacklist + "的内容黑名单吗?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewBannedContentDialog() {
    var url   = 'Function/client/msgTrans/cbannedContent.php';
    var title = '内容黑名单';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editBannedContentForm').valid()) {
            openNewBannedContentDialog();
            ajaxSubmitForm($('#editBannedContentForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editBannedContentForm').valid()) {
            ajaxSubmitForm($('#editBannedContentForm'), '结果');
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
    var url = 'Function/client/msgTrans/cbannedContent.php';
    freshTable(url, $('#bannedContentTable'));
    freshPagination(url, $('.pager'));
}

function switchCtl() {
    ajaxSubmitForm($('#ctlForm'), '结果');
}
