function openNewFtpFilterOptionsDialog() {
    var url   = 'Function/resConf/filterConf/ftp.php';
    var title = '添加FTP过滤选项';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editFtpFilterOptionForm').valid()) {
            openNewFtpFilterOptionsDialog();
            ajaxSubmitForm($('#editFtpFilterOptionForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editFtpFilterOptionForm').valid()) {
            ajaxSubmitForm($('#editFtpFilterOptionForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 690,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function editFtpFilterOptionsDialog(id) {
    var url   = 'Function/resConf/filterConf/ftp.php';
    var title = '修改FTP过滤选项';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editFtpFilterOptionForm').valid()) {
            ajaxSubmitForm($('#editFtpFilterOptionForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 690,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delFtpFilterOptions(id) {
    var url  = 'Function/resConf/filterConf/ftp.php';
    var data = {
        delId: id
    };
    var title  = '删除FTP过滤';
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

function delFtpFilterOptionsDialog(id, name) {
    var dialog  = loadingScreen('删除FTP过滤选项');
    var buttons = {};
    buttons['Confirm'] = function() {
        delFtpFilterOptions(id);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的FTP过滤选项吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/resConf/filterConf/ftp.php';
    freshTable(url, $('#ftpFilterOptionsTable'));
    freshPagination(url, $('.pager'));
}
