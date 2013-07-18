function openNewipDialog() {
    var url  = 'Function/networkManagement/HA/ipDetect.php';
    var title   = '添加IP探测列表';
    var data  = {
        openNewIpDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editIpDetectForm').valid()) {
			openNewipDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editIpDetectForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editIpDetectForm').valid()) {
			var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editIpDetectForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 310,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,310)
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function openIpDetectDialog(ip) {
    var url  = 'Function/networkManagement/HA/ipDetect.php';
    var title   = '修改虚拟地址';
    var data  = {
        editIp : ip
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editIpDetectForm').valid()) {
			var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editIpDetectForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 310,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,310)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delIpDetect(ip) {
    var url  = 'Function/networkManagement/HA/ipDetect.php';
    var data = {
        delip: ip
    };
    var title  = '删除虚拟地址';
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

function openDelIpDetectDialog(ip) {
    var dialog  = loadingScreen('删除IP探测列表');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delIpDetect(ip);
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
    dialog.setContent("<p>确定要删除吗?</p>");
    dialog.setOptions(dialogParams);   

}

function freshTableAndPage() {
    var url = 'Function/networkManagement/HA/ipDetect.php';
    freshTable(url, $('#ipDetectTable'));
    freshPagination(url, $('.pager'));
}
