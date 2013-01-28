function editPop3TransClientAclDialog(id) {
    var url  = 'Function/client/mail/pop3TransVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改pop3客户端透明访问';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editPop3TransClientAclForm').valid()) {
            ajaxSubmitForm($('#editPop3TransClientAclForm'), '结果');
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

function openNewPop3TransClientAclDialog() {
    var url   = 'Function/client/mail/pop3TransVisit.php';
    var title = '添加POP3客户端透明访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editPop3TransClientAclForm').valid()) {
            openNewPop3TransClientAclDialog();
            ajaxSubmitForm($('#editPop3TransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editPop3TransClientAclForm').valid()) {
            ajaxSubmitForm($('#editPop3TransClientAclForm'), '结果');
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

function delPop3TransClientAcl(id) {
    var url  = 'Function/client/mail/pop3TransVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除POP3客户端透明访问';
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

function delPop3TransClientAclDialog(id) {
    var dialog  = loadingScreen('删除POP3客户端透明访问');
    var buttons = {};
    buttons['Confirm'] = function() {
        delPop3TransClientAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的POP3客户端透明访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchPop3TransClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchPop3TransClientForm_' + id), '结果');
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
    var lipOpts = $('select[name="pop3lip"]');
    saOpts.find('option[value$="_ipv6"]').hideOption();
    lipOpts.find('option[value*=":"]').hideOption();
}

function freshTableAndPage() {
    var url = 'Function/client/mail/pop3TransVisit.php';
    freshTable(url, $('#pop3TransVisitTable'));
    freshPagination(url, $('.pager'));
}
