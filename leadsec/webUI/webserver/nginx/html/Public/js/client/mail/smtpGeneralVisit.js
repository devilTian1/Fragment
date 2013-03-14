function editSmtpCommClientAclDialog(id) {
    var url  = 'Function/client/mail/smtpGeneralVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改smtp客户端普通访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editSmtpCommClientAclForm').valid()) {
            ajaxSubmitForm($('#editSmtpCommClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 470,
        position: ['center', 'top'],
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewSmtpCommClientAclDialog() {
    var url   = 'Function/client/mail/smtpGeneralVisit.php';
    var title = '添加SMTP客户端普通访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editSmtpCommClientAclForm').valid()) {
            openNewSmtpCommClientAclDialog();
            ajaxSubmitForm($('#editSmtpCommClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editSmtpCommClientAclForm').valid()) {
            ajaxSubmitForm($('#editSmtpCommClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 470,
        position: ['center', 'top'],
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delSmtpCommClientAcl(id) {
    var url  = 'Function/client/mail/smtpGeneralVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除SMTP客户端普通访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
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

function delSmtpCommClientAclDialog(id) {
    var dialog  = loadingScreen('删除SMTP客户端普通访问');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delSmtpCommClientAcl(id);
        freshTableAndPage();
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除任务号为" + id + "的SMTP客户端普通访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchSmtpCommClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        ajaxSubmitForm($('#switchSmtpCommClientForm_' + id), '结果');
        freshTableAndPage();
        $(this).remove();
    };
    buttons[getMessage('Cancel')] = function() {
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
    var lipOpts = $('select[name="smtplip"]');
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
    var url = 'Function/client/mail/smtpGeneralVisit.php';
    freshTable(url, $('#smtpGeneralVisitTable'));
    freshPagination(url, $('.pager'));
}
