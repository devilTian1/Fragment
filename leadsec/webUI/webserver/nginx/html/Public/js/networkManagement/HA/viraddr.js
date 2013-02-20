function openEditViraddrDialog(sid) {
    var url  = 'Function/networkManagement/HA/viraddr.php';
    var data = {
        tpl    : 'networkManagement/HA/editViraddrDialog.tpl',
        sid : sid
    };
    var title   = '修改虚拟地此';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editViraddrForm').valid()) {
            ajaxSubmitForm($('#editViraddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 260,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewViraddrDialog() {
    var url   = 'Function/networkManagement/HA/viraddr.php';
    var title   = '添加虚拟地此';
    var data  = {
        tpl : 'networkManagement/HA/editViraddrDialog.tpl',
		type: 'showAdd'
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editStaticRouteForm').valid()) {
            openNewViraddrDialog();
            ajaxSubmitForm($('#editViraddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editStaticRouteForm').valid()) {
            ajaxSubmitForm($('#editStaticRouteForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 260,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delStaticRoute(delid) {
    var url  = 'Function/networkManagement/HA/viraddr.php';
    var data = {
        delid: delid
    };
    var title  = '删除虚拟地此';
    var buttons = {};
    buttons['Ok'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelViraddrDialog(id) {
    var dialog  = loadingScreen('删除虚拟地此');
    var buttons = {};
    buttons['Confirm'] = function() {
        delStaticRoute(id);
        $(this).remove();
        freshTableAndPage();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除该虚拟地此吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/networkManagement/HA/viraddr.php';
    freshTable(url, $('#viraddrTable'));
    freshPagination(url, $('.pager'));
}
