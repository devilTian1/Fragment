function openEditLocalUsrAuthenDialog(name) {
    var url  = 'Function/client/msgTrans/localUserAuthen.php';
    var data = {
    	editName : name
    };
    var title   = '编辑本地用户认证';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	if($('#modifyEnable').attr("checked") === 'checked'){
    		if ($('#editLocalUsrAuthenForm').valid()) {
                ajaxSubmitForm($('#editLocalUsrAuthenForm'), '结果');
                freshTableAndPage();
                $(this).remove();
            }
        }else {        	 
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
function openNewLocalUsrAuthenDialog() {
    var url   = 'Function/client/msgTrans/localUserAuthen.php';
    var title = '添加本地用户认证';
    var data  = {
    	openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editLocalUsrAuthenForm').valid()) {
        	openNewLocalUsrAuthenDialog();
            ajaxSubmitForm($('#editLocalUsrAuthenForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editLocalUsrAuthenForm').valid()) {
            ajaxSubmitForm($('#editLocalUsrAuthenForm'), '结果');
            freshTableAndPage();
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
    var url  = 'Function/client/msgTrans/localUserAuthen.php';
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

function openDelLocalUsrAuthenDialog(name) {
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
    dialog.setContent("<p>确定要删除名称为"+  name  +"的本地用户认证吗?</p>");
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
    var url = 'Function/client/msgTrans/localUserAuthen.php';
    freshTable(url, $('#localUsrAuthenTable'));
    freshPagination(url, $('.pager'));
}

