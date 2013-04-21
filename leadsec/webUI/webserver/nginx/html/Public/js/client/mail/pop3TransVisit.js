function editPop3TransClientAclDialog(id) {
    var url  = 'Function/client/mail/pop3TransVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改pop3客户端透明访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editPop3TransClientAclForm').valid()) {
            ajaxSubmitForm($('#editPop3TransClientAclForm'), '结果');
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
        position : jQuery.getDialogPosition('680','470'),
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewPop3TransClientAclDialog() {
    var url   = 'Function/client/mail/pop3TransVisit.php';
    var title = '添加POP3客户端透明访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editPop3TransClientAclForm').valid()) {
            openNewPop3TransClientAclDialog();
            ajaxSubmitForm($('#editPop3TransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editPop3TransClientAclForm').valid()) {
            ajaxSubmitForm($('#editPop3TransClientAclForm'), '结果');
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
        position : jQuery.getDialogPosition('680','470'),
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delPop3TransClientAcl(id) {
    var url  = 'Function/client/mail/pop3TransVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除POP3客户端透明访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition('250','170')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delPop3TransClientAclDialog(id) {
    var dialog  = loadingScreen('删除POP3客户端透明访问');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delPop3TransClientAcl(id);
        freshTableAndPage();
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent("<p>确定要删除任务号为" + id + "的POP3客户端透明访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchPop3TransClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        ajaxSubmitForm($('#switchPop3TransClientForm_' + id), '结果');
        freshTableAndPage();
        $(this).remove();
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };

    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '任务[' +  id + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function filterRes() {
    var saOpts  = $('select[name="sa"]');
    var daOpts  = $('select[name="da"]');
    var lipOpts = $('select[name="pop3lip"]');
    saOpts.hideOption('option[value$="_ipv6"]');
    daOpts.hideOption('option[value$="_ipv6"]');
    lipOpts.hideOption('option[value*=":"]');
}

function freshTableAndPage() {
    var url = 'Function/client/mail/pop3TransVisit.php';
    freshTable(url, $('#pop3TransVisitTable'));
    freshPagination(url, $('.pager'));
}
