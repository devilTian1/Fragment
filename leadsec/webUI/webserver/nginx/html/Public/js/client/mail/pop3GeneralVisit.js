function editPop3CommClientAclDialog(id) {
    var url  = 'Function/client/mail/pop3GeneralVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改pop3客户端普通访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editPop3CommClientAclForm').valid()) {
            ajaxSubmitForm($('#editPop3CommClientAclForm'), '结果');
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

function openNewPop3CommClientAclDialog() {
    var url   = 'Function/client/mail/pop3GeneralVisit.php';
    var title = '添加POP3客户端普通访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editPop3CommClientAclForm').valid()) {
            openNewPop3CommClientAclDialog();
            ajaxSubmitForm($('#editPop3CommClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editPop3CommClientAclForm').valid()) {
            ajaxSubmitForm($('#editPop3CommClientAclForm'), '结果');
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

function delPop3CommClientAcl(id) {
    var url  = 'Function/client/mail/pop3GeneralVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除POP3客户端普通访问';
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

function delPop3CommClientAclDialog(id) {
    var dialog  = loadingScreen('删除POP3客户端普通访问');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delPop3CommClientAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的POP3客户端普通访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchPop3CommClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        ajaxSubmitForm($('#switchPop3CommClientForm_' + id), '结果');
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
    var type    = $('input:radio[name="ipType"]:checked').val();
    var saOpts  = $('select[name="sa"]');
    var lipOpts = $('select[name="pop3lip"]');
    saOpts.showOption();
    lipOpts.showOption();
    if (type === 'ipv4') {
        saOpts.hideOption('option[value$="_ipv6"]');
        lipOpts.hideOption('option[value*=":"]');
    } else if (type === 'ipv6') {
        saOpts.hideOption('option[value$="_ipv4"]');
        lipOpts.hideOption('option[value*="."]');
    }
}

function freshTableAndPage() {
    var url = 'Function/client/mail/pop3GeneralVisit.php';
    freshTable(url, $('#pop3GeneralVisitTable'));
    freshPagination(url, $('.pager'));
}
