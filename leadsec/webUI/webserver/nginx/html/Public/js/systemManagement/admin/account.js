function setExpiredTime(time) {
    ajaxSubmitForm($('#expTimeForm'), '设置超时时间');
}

function showNewAccountDialog() {
    var url   = 'Function/layout/showDialog.php';
    var data  = {
        tpl : 'systemManagement/admin/addNewAccount.tpl'
    };
    var title   = '添加管理员帐号';
    var buttons = {};
    buttons['添加下一条'] = function() {};
    buttons['确定'] = function() {};
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 540,
        height  : 380,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}
