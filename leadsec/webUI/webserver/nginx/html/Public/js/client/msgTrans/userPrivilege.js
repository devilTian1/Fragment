function openEditUserPriDialog(name) {
    var url  = 'Function/client/msgTrans/userPrivilege.php';
    var data = {
    	editName : name
    };
    var title   = '修改用户权限';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editUserPriTableForm').valid()) {
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editUserPriTableForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 350,
        buttons : buttons,
        position: jQuery.getDialogPosition(680,350)
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
    buttons[getMessage('Add Next')] = function() {
        if ($('#editUserPriTableForm').valid()) {
        	openNewUserPriDialog();
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editUserPriTableForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editUserPriTableForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editUserPriTableForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 350,
        buttons : buttons,
        position: jQuery.getDialogPosition(680,350)
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

function openDelUserPriDialog(name) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delUsr(name);
        $(this).remove();        
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position: jQuery.getDialogPosition(300,160)
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

