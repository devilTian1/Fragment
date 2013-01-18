function editFtpCommClientAclDialog(id) {
    var url  = 'Function/client/ftp/generalVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改ftp客户端普通访问';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editFtpCommClientAclForm').valid()) {
            ajaxSubmitForm($('#editFtpCommClientAclForm'), '结果');
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

function openNewFtpCommClientAclDialog() {
    var url   = 'Function/client/ftp/generalVisit.php';
    var title = '添加ftp客户端普通访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editFtpCommClientAclForm').valid()) {
            openNewFtpCommClientAclDialog();
            ajaxSubmitForm($('#editFtpCommClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editFtpCommClientAclForm').valid()) {
            ajaxSubmitForm($('#editFtpCommClientAclForm'), '结果');
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

function delFtpCommClientAcl(id) {
    var url  = 'Function/client/ftp/generalVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除ftp客户端普通访问';
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

function delFtpCommClientAclDialog(id) {
    var dialog  = loadingScreen('删除普通访问');
    var buttons = {};
    buttons['Confirm'] = function() {
        delFtpCommClientAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的FTP客户端普通访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchFtpCommClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchFtpCommClientForm_' + id), '结果');
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
    var type    = $('input:radio[name="ipType"]:checked').val();
    var saOpts  = $('select[name="sa"]');
    var lipOpts = $('select[name="lip"]');
    saOpts.children('span').showOption(); 
    lipOpts.children('span').showOption(); 
    if (type === 'ipv4') {
        saOpts.find('option[value$="_ipv6"]').hideOption();
        lipOpts.find('option[value*=":"]').hideOption();
    } else if (type === 'ipv6') {
        saOpts.find('option[value$="_ipv4"]').hideOption();
        lipOpts.find('option[value*="."]').hideOption();
    } else {
    }
}

function freshTableAndPage() {
    var url = 'Function/client/ftp/generalVisit.php';
    freshTable(url, $('#generalVisitTable'));
    freshPagination(url, $('.pager'));
}
