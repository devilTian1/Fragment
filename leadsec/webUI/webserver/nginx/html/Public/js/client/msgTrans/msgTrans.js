function openEditDialog(id) {
    var url  = 'Function/client/msgTrans/msgTrans.php';
    var data = {
        //tpl    : 'client/msgTrans/msgTrans_editDialog.tpl',
        editId : id
    };
    var title   = '修改消息传输';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editForm').valid()) {
            ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 480,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,480)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewDialog() {
    var url   = 'Function/client/msgTrans/msgTrans.php';
    var title = '添加消息传输';
    var data  = {
        //tpl : 'client/msgTrans/msgTrans_editDialog.tpl',
		openDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
    	if ($('#editForm').valid()) {
    		openNewDialog();
    	    ajaxSubmitForm($('#editForm'), '结果');
    	    freshTableAndPage();
    	    $(this).remove();
    	 }       
    };
    buttons[getMessage('Ok')] = function() {
    	if ($('#editForm').valid()) {
    		ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }       
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 480,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,480)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function del(id) {
    var url  = 'Function/client/msgTrans/msgTrans.php';
    var data = {
        delId: id
    };
    var title  = '删除消息传输';
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

function openDelDialog(id) {
    var dialog  = loadingScreen('删除消息传输');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        del(id);
        $(this).remove();
        freshTableAndPage();
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
    dialog.setContent("<p>确定要删除序号为" + id + "的消息传输吗?</p>");
    dialog.setOptions(dialogParams);   
}
function switchmsgTrans(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        ajaxSubmitForm($('#switchmsgTransForm_' + id), '结果');
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
        position: jQuery.getDialogPosition(300,160)
    };

    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '任务[' +  id + ']吗?</p>');
    dialog.setOptions(dialogParams);
}
function filterRes() {
    var type    = $('input:radio[name="ipType"]:checked').val();
    var saOpts  = $('select[name="sAddress"]');
    var lipOpts = $('select[name="cmsgLip"]');
    saOpts.showOption(); 
    lipOpts.showOption(); 
    if (type === 'ipv4') {
        saOpts.hideOption('option[value$="_ipv6"]');
        lipOpts.hideOption('option[value*=":"]');
    } else if (type === 'ipv6') {
        saOpts.hideOption('option[value$="_ipv4"]');
        lipOpts.hideOption('option[value*="."]');
    } else {
    	saOpts.hideOption('option[value$="_ipv6"]');
        lipOpts.hideOption('option[value*=":"]');
    }
}
function freshTableAndPage() {
    var url = 'Function/client/msgTrans/msgTrans.php';
    freshTable(url, $('#msgTransTable'));
    freshPagination(url, $('.pager'));
}
