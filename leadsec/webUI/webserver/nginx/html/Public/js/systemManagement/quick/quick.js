function openNewQuickDialog() {
    var url   = 'Function/layout/showDialog.php';
    var data  = {
        tpl : 'systemManagement/quick/editQuick.tpl'
    };
    var title   = '添加快捷操作';
    var buttons = {};
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 700,
        height  : 400,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}