function openEditUserDialog(id) {
    var url  = 'Function/resConf/filterConf/dataVisit_user.php';
    var data = {
    	editId  : id   
    };
    var title   = '修改用户过滤';
    var buttons = {};
    buttons['确定'] = function() {
    	if ($('#editUserFilterForm').valid()) {
            ajaxSubmitForm($('#editUserFilterForm'), '结果');
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
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewDialog() {
    var url   = 'Function/resConf/filterConf/dataVisit_user.php';
    var title = '添加用户过滤';
    var data  = {
		openDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editUserFilterForm').valid()) {
            openNewDialog();
            ajaxSubmitForm($('#editUserFilterForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editUserFilterForm').valid()) {
            ajaxSubmitForm($('#editUserFilterForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 450,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function del(name) {
    var url  = 'Function/resConf/filterConf/dataVisit_user.php';
    var data = {
        delName: name
    };
    var title  = '删除用户过滤';
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

function openDelUserDialog(name,id) {
    var dialog  = loadingScreen('删除用户过滤');
    var buttons = {};
    buttons['Confirm'] = function() {
        del(name);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的用户过滤吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/resConf/filterConf/dataVisit_user.php';
    freshTable(url, $('#dataVisit_userTable'));
    freshPagination(url, $('.pager'));
}