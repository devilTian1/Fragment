function editAllowedFileDialog(id) {
    var url   = 'Function/client/msgTrans/callowedFile.php';
    var title = '编辑文件名控制';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editAllowedFileForm').valid()) {
            ajaxSubmitForm($('#editAllowedFileForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 240,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAllowedFile(name) {
    var url  = 'Function/client/msgTrans/callowedFile.php';
    var data = {
        delId: name
    };
    var title  = '删除文件名控制';
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

function delAllowedFileDialog(name) {
    var dialog  = loadingScreen('删除文件名控制');
    var buttons = {};
    buttons['Confirm'] = function() {
        delAllowedFile(name);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的文件名控制吗?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewAllowedFileDialog() {
    var url   = 'Function/client/msgTrans/callowedFile.php';
    var title = '添加文件名控制';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editAllowedFileForm').valid()) {
            openNewAllowedFileDialog();
            ajaxSubmitForm($('#editAllowedFileForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editAllowedFileForm').valid()) {
            ajaxSubmitForm($('#editAllowedFileForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 240,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/client/msgTrans/callowedFile.php';
    freshTable(url, $('#allowedFileTable'));
    freshPagination(url, $('.pager'));
}

function switchCtl() {
    ajaxSubmitForm($('#ctlForm'), '结果');
}
