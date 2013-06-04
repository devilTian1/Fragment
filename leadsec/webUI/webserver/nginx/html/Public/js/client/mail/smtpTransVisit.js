function editSmtpTransClientAclDialog(id) {
    var url  = 'Function/client/mail/smtpTransVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改smtp客户端透明访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editSmtpTransClientAclForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editSmtpTransClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);   
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

function openNewSmtpTransClientAclDialog() {
    var url   = 'Function/client/mail/smtpTransVisit.php';
    var title = '添加SMTP客户端透明访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editSmtpTransClientAclForm').valid()) {
            openNewSmtpTransClientAclDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editSmtpTransClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback); 
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editSmtpTransClientAclForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editSmtpTransClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback); 
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

function delSmtpTransClientAcl(id) {
    var url  = 'Function/client/mail/smtpTransVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除SMTP客户端透明访问';
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

function delSmtpTransClientAclDialog(id) {
    var dialog  = loadingScreen('删除SMTP客户端透明访问');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delSmtpTransClientAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的SMTP客户端透明访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchSmtpTransClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	var afterSuccessCallback = function() {
            freshTableAndPage();
        };
        ajaxSubmitForm($('#switchSmtpTransClientForm_' + id), '结果', undefined,
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
        position : jQuery.getDialogPosition('300','160')
    };

    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '任务[' +  id + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function filterRes() {
    var saOpts  = $('select[name="sa"]');
    var daOpts  = $('select[name="da"]');
    var lipOpts = $('select[name="smtplip"]');
    saOpts.hideOption('option[value$="_ipv6"]');
    daOpts.hideOption('option[value$="_ipv6"]');
    lipOpts.hideOption('option[value*=":"]');
}

function freshTableAndPage() {
    var url = 'Function/client/mail/smtpTransVisit.php';
    freshTable(url, $('#smtpTransVisitTable'));
    freshPagination(url, $('.pager'));
}

