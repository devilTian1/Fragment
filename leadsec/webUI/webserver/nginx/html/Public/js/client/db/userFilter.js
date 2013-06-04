function openEditUserDialog(id) {
    var url  = 'Function/client/db/userFilter.php';
    var data = {
    	editId  : id   
    };
    var title   = '修改用户过滤';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	var value = $('#userFilterNameList').val();
    	var key=value.indexOf(",");
    	if(key === 0){
    		showErrorDialog('字符","请不要放在首位');
    	}else if(value.substr(value.length-1,1)===","){
    		showErrorDialog('字符","请不要放在末尾');
    	}else{
    		if ($('#editUserFilterForm').valid()) {
    			var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
                ajaxSubmitForm($('#editUserFilterForm'), '结果', undefined,
                    undefined, afterSuccessCallback);
                $(this).remove();
            }
    	}    	
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 500,
        buttons : buttons,
        position: jQuery.getDialogPosition(620,500)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewDialog() {
    var url   = 'Function/client/db/userFilter.php';
    var title = '添加用户过滤';
    var data  = {
		openDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
    	var value = $('#userFilterNameList').val();
    	var key=value.indexOf(",");
    	if(key === 0){
    		showErrorDialog('字符","请不要放在首位');
    	}else if(value.substr(value.length-1,1)===","){
    		showErrorDialog('字符","请不要放在末尾');
    	}else{
    		if ($('#editUserFilterForm').valid()) {
                openNewDialog();
    			var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
                ajaxSubmitForm($('#editUserFilterForm'), '结果', undefined,
                    undefined, afterSuccessCallback);
                $(this).remove();
            }
    	}
        
    };
    buttons[getMessage('Ok')] = function() {
    	var value = $('#userFilterNameList').val();
    	var key=value.indexOf(",");
    	if(key === 0){
    		showErrorDialog('字符","请不要放在首位');
    	}else if(value.substr(value.length-1,1)===","){
    		showErrorDialog('字符","请不要放在末尾');
    	}else{
    		if ($('#editUserFilterForm').valid()) {
    			var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
                ajaxSubmitForm($('#editUserFilterForm'), '结果', undefined,
                    undefined, afterSuccessCallback);
                $(this).remove();
            }
    	}       
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 450,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,450)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function del(name) {
    var url  = 'Function/client/db/userFilter.php';
    var data = {
        delName: name
    };
    var title  = '删除用户过滤';
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

function openDelUserDialog(name,id) {
    var dialog  = loadingScreen('删除用户过滤');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        del(name);
        $(this).remove();
        freshTableAndPage();
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
    dialog.setContent("<p>确定要删除名称为" + name + "的用户过滤吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/client/db/userFilter.php';
    freshTable(url, $('#dataVisit_userTable'));
    freshPagination(url, $('.pager'));
}