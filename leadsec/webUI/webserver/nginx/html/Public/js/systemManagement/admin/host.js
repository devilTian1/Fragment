function openEditHostDialog(hostId) {
    var url  = 'Function/systemManagement/admin/host.php';
    var data = {
        tpl        : 'systemManagement/admin/editHostDialog.tpl',
        editHostId : hostId
    };
    var title   = '修改管理主机信息';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editHostForm').valid()) {
            ajaxSubmitForm($('#editHostForm'), '结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 590,
        height  : 460,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewHostDialog() {
    var url   = 'Function/layout/showDialog.php';
    var data  = {
        tpl : 'systemManagement/admin/editHostDialog.tpl'
    };
    var title   = '添加管理主机';
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editHostForm').valid()) {
            openNewHostDialog();
            ajaxSubmitForm($('#editHostForm'), '结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editHostForm').valid()) {
            ajaxSubmitForm($('#editHostForm'), '结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 590,
        height  : 460,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelHostDialog(ip, netmask) {
    var dialog  = loadingScreen('删除管理主机');
    var buttons = {};
    buttons['Confirm'] = function() {
        delHost(ip, netmask);
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
    dialog.setContent("<p>确定要删除管理主机[" + ip + "]?</p>");
    dialog.setOptions(dialogParams);
}

function delHost(ip, netmask) {
    var url    = 'Function/systemManagement/admin/host.php';
    var data = {
        delHostIp: ip,
        delHostNetmask: netmask
    };
    var title  = '删除主机';
    var buttons = {};
    buttons['Ok'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openSnmpDialog() {

}


function changeIpType() {
    var type = $(":radio[name='ipType']:checked").val();
    $('#ip').attr('name', type);
    if (type === "ipv6") {
        $('#netmask').attr('disabled', 'disabled');
    } else {
        $('#netmask').removeAttr('disabled');
    }
}
