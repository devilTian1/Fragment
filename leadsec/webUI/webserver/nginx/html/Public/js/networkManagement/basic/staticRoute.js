function defaultGatewayData() {
    if($('#defaultRouteForm').valid()){
        ajaxSubmitForm($('#defaultRouteForm'), '添加默认网关 ');
    }
}
function openEditStaticRouteDialog(sid) {
    var url  = 'Function/networkManagement/basic/staticRoute.php';
    var data = {
        tpl    : 'networkManagement/basic/editStaticRouteDialog.tpl',
        sid : sid
    };
    var title   = '修改静态路由';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editStaticRouteForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editStaticRouteForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 300,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,300)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewStaticRouteDialog() {
    var url   = 'Function/networkManagement/basic/staticRoute.php';
    var title   = '添加静态路由';
    var data  = {
        tpl : 'networkManagement/basic/editStaticRouteDialog.tpl',
		type: 'showAdd'
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editStaticRouteForm').valid()) {
            openNewStaticRouteDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editStaticRouteForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editStaticRouteForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editStaticRouteForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 300,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,300)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delStaticRoute(delid) {
    var url  = 'Function/networkManagement/basic/staticRoute.php';
    var data = {
        delid: delid
    };
    var title  = '删除静态路由';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelStaticRouteDialog(id) {
    var dialog  = loadingScreen('删除静态路由');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delStaticRoute(id);
        $(this).remove();
        freshTableAndPage();
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除该静态路由吗?</p>");
    dialog.setOptions(dialogParams);   
}

function changeStaticRouteActive(changeid,argu) {
    var url  = 'Function/networkManagement/basic/staticRoute.php';
    var data = {
        changeid: changeid,
		argu	: argu
    };
    var title  = '改变静态路由状态';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/networkManagement/basic/staticRoute.php';
    freshTable(url, $('#staticRouteTable'));
    freshPagination(url, $('.pager'));
}
