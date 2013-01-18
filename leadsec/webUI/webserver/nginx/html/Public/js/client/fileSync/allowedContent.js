function editAllowedContentDialog(id) {
    var url   = 'Function/client/fileSync/allowedContent.php';
    var title = '编辑内容控制';
    var data  = {
		editId: id
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
        height  : 440,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAllowedContent(id) {
    var url  = 'Function/client/fileSync/allowedContent.php';
    var data = {
        delId: id
    };
    var title  = '删除内容控制';
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

function delAllowedContentDialog(id, name) {
    var dialog  = loadingScreen('删除客户端文件同步');
    var buttons = {};
    buttons['Confirm'] = function() {
        delAllowedContent(id);
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
    dialog.setContent("<p>确定要删除内容为" + name + "的内容白名单吗?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewAllowedContentDialog() {
    var url   = 'Function/client/fileSync/allowedContent.php';
    var title = '内容控制';
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
        height  : 440,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/client/fileSync/allowedContent.php';
    freshTable(url, $('#allowedContentTable'));
    freshPagination(url, $('.pager'));
}

function switchCtl() {
    ajaxSubmitForm($('#ctlForm'), '结果');
}
