function openEditUserPriDialog(name) {
    var url  = 'Function/client/msgTrans/userPrivilege.php';
    var data = {
    	editName : name
    };
    var title   = '修改用户权限';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editUserPriTableForm').valid()) {
            ajaxSubmitForm($('#editUserPriTableForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 350,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}
function openNewUserPriDialog() {
    var url   = 'Function/client/msgTrans/userPrivilege.php';
    var title = '添加用户权限';
    var data  = {
    	openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editUserPriTableForm').valid()) {
        	openNewUserPriDialog();
            ajaxSubmitForm($('#editUserPriTableForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editUserPriTableForm').valid()) {
            ajaxSubmitForm($('#editUserPriTableForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 520,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delUsr(name) {
    var url  = 'Function/client/msgTrans/userPrivilege.php';
    var data = {
        delName: name
    };
    var title  = '删除';
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

function openDelUserPriDialog(name) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons['确定'] = function() {
        delUsr(name);
        $(this).remove();        
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除名称为"+  name  +"的用户吗?</p>");
    dialog.setOptions(dialogParams);   
}

function enablePasswd() {
    if ($("#modifyEnable").attr("checked") == 'checked') {
    	$("input[name='psswd1']").removeAttr("disabled");
    	$("input[name='psswd1']").attr("value","");
    	$("input[name='psswd2']").removeAttr("disabled");
    	$("input[name='psswd2']").attr("value","");
    } else {
    	$("input[name='psswd1']").attr("value","********");
    	$("input[name='psswd1']").attr("disabled",'disabled');
    	$("input[name='psswd2']").attr("value","********");
    	$("input[name='psswd2']").attr("disabled",'disabled');    	
    }
}

function freshTableAndPage() {
    var url = 'Function/client/msgTrans/userPrivilege.php';
    freshTable(url, $('#userPrivilegeTable'));
    freshPagination(url, $('.pager'));
}

