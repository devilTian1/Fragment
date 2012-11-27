function openNewTimeListDialog() {
    var url   = 'Function/layout/showDialog.php';
    var title   = '定义地址';
    var data  = {
        tpl : 'resConf/time/editTimeListDialog.tpl'
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editAddrListForm').valid()) {
            openNewTimeListDialog();
            ajaxSubmitForm($('#editTimeListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editAddrListForm').valid()) {
            ajaxSubmitForm($('#editTimeListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 500,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openEditTimeListDialog(id) {

}

function openDelTimeListDialog(name) {

}
