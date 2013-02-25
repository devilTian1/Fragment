function openEditLvsDialog(sid) {
    var url  = 'Function/networkMangement/HA/lvs.php';
    var data = {
        tpl    : 'networkMangement/HA/editLvsDialog.tpl',
        sid : sid
    };
    var title   = '修改负载均衡';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editLvsForm').valid()) {
            ajaxSubmitForm($('#editLvsForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 820,
        height  : 420,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewLvsDialog() {
    var url   = 'Function/networkMangement/HA/lvs.php';
    var title   = '添加负载均衡';
    var data  = {
        tpl : 'networkMangement/HA/editLvsDialog.tpl',
		type: 'showAdd'
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editLvsForm').valid()) {
            openNewLvsDialog();
            ajaxSubmitForm($('#editLvsForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editLvsForm').valid()) {
            ajaxSubmitForm($('#editLvsForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 820,
        height  : 420,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delLvs(delid) {
    var url  = 'Function/networkMangement/HA/lvs.php';
    var data = {
        delid: delid
    };
    var title  = '删除负载均衡';
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

function openDelLvsDialog(id) {
    var dialog  = loadingScreen('删除静态路由');
    var buttons = {};
    buttons['Confirm'] = function() {
        delLvs(id);
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
    dialog.setContent("<p>确定要删除该负载均衡配置吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/networkMangement/HA/lvs.php';
    freshTable(url, $('#lvsTable'));
    freshPagination(url, $('.pager'));
}
