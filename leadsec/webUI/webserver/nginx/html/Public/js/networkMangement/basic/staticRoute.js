function openEditStaticRouteDialog(id) {
    var url  = 'Function/networkMangement/basic/staticRoute.php';
    var data = {
        tpl    : 'networkMangement/basic/editStaticRouteDialog.tpl',
        id : id
    };
    var title   = '修改静态路由';
    var buttons = {};
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
        width   : 780,
        height  : 550,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewStaticRouteDialog() {
    var url   = 'Function/layout/showDialog.php';
    var title   = '添加静态路由';
    var data  = {
        tpl : 'networkMangement/basic/editStaticRouteDialog.tpl'
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editStaticRouteForm').valid()) {
            openNewStaticRouteDialog();
            ajaxSubmitForm($('#editStaticRouteForm'), '结果');
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
        height  : 300,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delStaticRoute(name) {
    var url  = 'Function/networkMangement/basic/staticRoute.php';
    var data = {
        delName: name
    };
    var title  = '删除静态路由';
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

function openDelStaticRouteDialog(name) {
    var dialog  = loadingScreen('删除静态路由');
    var buttons = {};
    buttons['Confirm'] = function() {
        delStaticRoute(name);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的静态路由吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/networkMangement/basic/staticRoute.php';
    freshTable(url, $('#staticRouteTable'));
    freshPagination(url, $('.pager'));
}
