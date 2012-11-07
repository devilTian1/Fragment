function openEditHostDialog(hostId) {

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
            openNewAccountDialog();
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

function openDelHostDialog(hostId) {

}

function openSnmpDialog() {

}


function changeIpType(type) {
    $('#ip').attr('name', type);
}
