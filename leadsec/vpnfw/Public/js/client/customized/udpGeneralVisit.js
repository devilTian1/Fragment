function editUdpCommClientAclDialog(id) {
    var url  = 'Function/client/customized/udpGeneralVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改UDP普通访问';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editUdpCommClientAclForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editUdpCommClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 520,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,520)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewUdpCommClientAclDialog() {
    var url   = 'Function/client/customized/udpGeneralVisit.php';
    var title = '添加UDP普通访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editUdpCommClientAclForm').valid()) {
            openNewUdpCommClientAclDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editUdpCommClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editUdpCommClientAclForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editUdpCommClientAclForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 520,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,520)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delUdpCommClientAcl(id) {
    var url  = 'Function/client/customized/udpGeneralVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除UDP普通访问';
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

function delUdpCommClientAclDialog(id) {
    var dialog  = loadingScreen('删除UDP普通访问');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delUdpCommClientAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的UDP普通访问吗？</p>");
    dialog.setOptions(dialogParams);   
}

function switchUdpCommClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	var afterSuccessCallback = function() {
            freshTableAndPage();
        };
        ajaxSubmitForm($('#switchUdpCommClientForm_' + id), '结果', undefined,
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
    var lipOpts = $('#udpGeneralLip');
    saOpts.showOption(); 
    lipOpts.showOption(); 
    if (type === 'ipv4') {
        saOpts.hideOption('option[value$="_ipv6"]');
        lipOpts.hideOption('option[value*=":"]');
        $('.mul').show();
    } else if (type === 'ipv6') {
        saOpts.hideOption('option[value$="_ipv4"]');
        lipOpts.hideOption('option[value*="."]');
        $('.mul').hide();
        $('input[name="mulIp"]').val('');
    } else {
    }
}

function toggleMulMode() {
    var mode = $("input:radio[name='mulMode']:checked").val();
    if (mode === 'unicast') {
        $('#mulIp, #mulSrc').hide();
    } else if (mode === 'multicast') {
        $('#mulIp, #mulSrc').show();
    } else if (mode === 'multiv2') {
        $('#mulIp').show();
        $('#mulSrc').hide();
    }
}

function freshTableAndPage() {
    var url = 'Function/client/customized/udpGeneralVisit.php';
    freshTable(url, $('#udpGeneralVisitTable'));
    freshPagination(url, $('.pager'));
}
