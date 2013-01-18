function editFtpTransClientAclDialog(id) {
    var url  = 'Function/client/ftp/transVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改ftp客户端透明访问';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editFtpTransClientAclForm').valid()) {
            ajaxSubmitForm($('#editFtpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 690,
        position: ['center', 'top'],
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewFtpTransClientAclDialog() {
    var url   = 'Function/client/ftp/transVisit.php';
    var title = '添加ftp客户端透明访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editFtpTransClientAclForm').valid()) {
            openNewFtpTransClientAclDialog();
            ajaxSubmitForm($('#editFtpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editFtpTransClientAclForm').valid()) {
            ajaxSubmitForm($('#editFtpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 690,
        position: ['center', 'top'],
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delFtpTransClientAcl(id) {
    var url  = 'Function/client/ftp/transVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除ftp客户端透明访问';
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

function delFtpTransClientAclDialog(id) {
    var dialog  = loadingScreen('删除透明访问');
    var buttons = {};
    buttons['Confirm'] = function() {
        delFtpTransClientAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的FTP客户端透明访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchFtpTransClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchFtpTransClientForm_' + id), '结果');
        freshTableAndPage();
        $(this).remove();
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };

    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '任务[' +  id + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function filterRes() {
    var saOpts  = $('select[name="sa"]');
    var daOpts = $('select[name="da"]');
    saOpts.find('option[value$="_ipv6"]').hideOption();
    daOpts.find('option[value$="_ipv6"]').hideOption();
}

function freshTableAndPage() {
    var url = 'Function/client/ftp/transVisit.php';
    freshTable(url, $('#transVisitTable'));
    freshPagination(url, $('.pager'));
}
