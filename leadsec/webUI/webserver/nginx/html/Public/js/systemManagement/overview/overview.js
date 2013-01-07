function openEditDialog(id) {
    var url  = 'Function/systemManagement/overview/overview.php';
    var data = {
        tpl    : 'client/safePass/safePass_editDialog.tpl',
        editId : id
    };
    var title   = '修改安全通道';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editForm').valid()) {
            ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 500,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}
