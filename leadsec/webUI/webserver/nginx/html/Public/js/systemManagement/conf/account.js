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
