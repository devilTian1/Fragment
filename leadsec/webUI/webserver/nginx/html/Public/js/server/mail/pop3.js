function editPop3CommServerAclDialog(id) {
    var url  = 'Function/server/mail/pop3.php';
    var data = {
        editId : id
    };
    var title   = '修改POP3普通访问';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editPop3CommServerAclForm').valid()) {
            ajaxSubmitForm($('#editPop3CommServerAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 350,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewPop3CommServerAclDialog() {
    var url   = 'Function/server/mail/pop3.php';
    var title = '添加POP3普通访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editPop3CommServerAclForm').valid()) {
            openNewPop3CommServerAclDialog();
            ajaxSubmitForm($('#editPop3CommServerAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editPop3CommServerAclForm').valid()) {
            ajaxSubmitForm($('#editPop3CommServerAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 350,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delPop3CommServerAcl(id) {
    var url  = 'Function/server/mail/pop3.php';
    var data = {
        delId: id
    };
    var title  = '删除POP3普通访问';
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

function delPop3CommServerAclDialog(id) {
    var dialog  = loadingScreen('删除POP3普通访问');
    var buttons = {};
    buttons['Confirm'] = function() {
        delPop3CommServerAcl(id);
        $(this).remove();
        freshTableAndPage();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除任务号为" + id + "的POP3普通访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchPop3CommServerAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchPop3CommServerForm_' + id), '结果');
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

function freshTableAndPage() {
    var url = 'Function/server/mail/pop3.php';
    freshTable(url, $('#pop3CommServerTable'));
    freshPagination(url, $('.pager'));
}