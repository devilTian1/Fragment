function editTcpCommClientAclDialog(id) {
    var url  = 'Function/client/customized/tcpGeneralVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改TCP普通访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editTcpCommClientAclForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editTcpCommClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 460,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,460)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewTcpCommClientAclDialog() {
    var url   = 'Function/client/customized/tcpGeneralVisit.php';
    var title = '添加TCP普通访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editTcpCommClientAclForm').valid()) {
            openNewTcpCommClientAclDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editTcpCommClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editTcpCommClientAclForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editTcpCommClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 460,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,460)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delTcpCommClientAcl(id) {
    var url  = 'Function/client/customized/tcpGeneralVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除TCP普通访问';
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

function delTcpCommClientAclDialog(id) {
    var dialog  = loadingScreen('删除TCP普通访问');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delTcpCommClientAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的TCP普通访问吗？</p>");
    dialog.setOptions(dialogParams);   
}

function switchTcpCommClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	var afterSuccessCallback = function() {
            freshTableAndPage();
        };
        ajaxSubmitForm($('#switchTcpCommClientForm_' + id), '结果', undefined,
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
    var type    = $('input:radio[name="ipType"]:checked').val();
    var saOpts  = $('select[name="sa"]');
    var lipOpts = $('#tcpGeneralLip');
    saOpts.showOption(); 
    lipOpts.showOption(); 
    if (type === 'ipv4') {
        saOpts.hideOption('option[value$="_ipv6"]');
        lipOpts.hideOption('option[value*=":"]');
    } else if (type === 'ipv6') {
        saOpts.hideOption('option[value$="_ipv4"]');
        lipOpts.hideOption('option[value*="."]');
    } else {
    }
}

function freshTableAndPage() {
    var url = 'Function/client/customized/tcpGeneralVisit.php';
    freshTable(url, $('#tcpGeneralVisitTable'));
    freshPagination(url, $('.pager'));
}
