function setExpiredTime(time) {
    var url  = 'Function/systemManagement/admin/account.php';
    var data = {
        expTime : time
    };
    var title = '设置超时时间';
    var buttons = {};
    buttons['Ok']  = function() {
        $(this).remove();
    }
    var dialogParams = {
        buttons : buttons,
        width   : 250,
        height  : 170,
    }
    showDialogByAjax(url, data, title, dialogParams);
}

function showNewAccountDialog() {
    var url   = 'Function/layout/showDialog.php';
    var data  = {
        tpl : 'systemManagement/admin/addNewAccount.tpl'
    };
    var title   = '添加管理员帐号';
    var buttons = {};
    buttons['next'] = function() {};
    buttons['确定'] = function() {};
    buttons['取消'] = function() {};
    var dialogParams = {
        width   : 520,
        height  : 410,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}
