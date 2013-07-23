function editTcpTransClientAclDialog(id) {
    var url  = 'Function/client/customized/tcpTransVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改TCP透明访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editTcpTransClientAclForm').valid()) {
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editTcpTransClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 435,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,435)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewTcpTransClientAclDialog() {
    var url   = 'Function/client/customized/tcpTransVisit.php';
    var title = '管理TCP透明访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editTcpTransClientAclForm').valid()) {
            openNewTcpTransClientAclDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editTcpTransClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editTcpTransClientAclForm').valid()) {
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editTcpTransClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 435,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,435)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delTcpTransClientAcl(id) {
    var url  = 'Function/client/customized/tcpTransVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除TCP透明访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delTcpTransClientAclDialog(id) {
    var dialog  = loadingScreen('删除TCP透明访问');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delTcpTransClientAcl(id);
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除任务号为" + id + "的TCP透明访问吗？</p>");
    dialog.setOptions(dialogParams);   
}

function switchTcpTransClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        var afterSuccessCallback = function() {
            freshTableAndPage();
        };
        ajaxSubmitForm($('#switchTcpTransClientForm_' + id), '结果', undefined,
            undefined, afterSuccessCallback);
        $(this).remove();
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position: jQuery.getDialogPosition(300,160)
    };

    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '任务[' +  id + ']吗？</p>');
    dialog.setOptions(dialogParams);
}

function filterRes() {
    var saOpts  = $('select[name="sa"]');
    var daOpts  = $('select[name="da"]');
    saOpts.hideOption('option[value$="_ipv6"]');
    daOpts.hideOption('option[value$="_ipv6"]');
}

function freshTableAndPage() {
    var url = 'Function/client/customized/tcpTransVisit.php';
    freshTable(url, $('#tcpTransVisitTable'));
    freshPagination(url, $('.pager'));
}
