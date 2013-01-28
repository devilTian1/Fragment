function editSmtpTransClientAclDialog(id) {
    var url  = 'Function/client/mail/smtpTransVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改smtp客户端透明访问';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editSmtpTransClientAclForm').valid()) {
            ajaxSubmitForm($('#editSmtpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
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

function openNewSmtpTransClientAclDialog() {
    var url   = 'Function/client/mail/smtpTransVisit.php';
    var title = '添加SMTP客户端透明访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editSmtpTransClientAclForm').valid()) {
            openNewSmtpTransClientAclDialog();
            ajaxSubmitForm($('#editSmtpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editSmtpTransClientAclForm').valid()) {
            ajaxSubmitForm($('#editSmtpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
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

function delSmtpTransClientAcl(id) {
    var url  = 'Function/client/mail/smtpTransVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除SMTP客户端透明访问';
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

function delSmtpTransClientAclDialog(id) {
    var dialog  = loadingScreen('删除SMTP客户端透明访问');
    var buttons = {};
    buttons['Confirm'] = function() {
        delSmtpTransClientAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的SMTP客户端透明访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchSmtpTransClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchSmtpTransClientForm_' + id), '结果');
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
    var lipOpts = $('select[name="smtplip"]');
    saOpts.find('option[value$="_ipv6"]').hideOption();
    lipOpts.find('option[value*=":"]').hideOption();
}

function freshTableAndPage() {
    var url = 'Function/client/mail/smtpTransVisit.php';
    freshTable(url, $('#smtpTransVisitTable'));
    freshPagination(url, $('.pager'));
}

