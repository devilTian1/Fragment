function openAddRealmAddrDialog() {
    var url   = 'Function/layout/showDialog.php';
    var title = '域名地址维护';
    var data  = {
        tpl : 'resConf/addr/editRealmAddrDialog.tpl'
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editRealmAddrForm').valid()) {
            openNewAddrListDialog();
            ajaxSubmitForm($('#editRealmAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editRealmAddrForm').valid()) {
            ajaxSubmitForm($('#editRealmAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 500,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);

}

function openEditRealmAddrDialog(id) {
    var url  = 'Function/resConf/addr/realmAddr.php';
    var data = {
        tpl    : 'resConf/addr/editRealmAddrDialog.tpl',
        editId : id
    };
    var title   = '域名地址维护';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editRealmAddrForm').valid()) {
            ajaxSubmitForm($('#editRealmAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 550,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelRealmAddrDialog() {

}

function freshTableAndPage() {
    var url = 'Function/resConf/addr/realmAddr.php';
    freshTable(url, $('#realmAddrTable'));
    freshPagination(url, $('.pager'));
}
