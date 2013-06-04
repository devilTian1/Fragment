function setExpiredTime() {
    if ($('#expTimeForm').valid()) {
        ajaxSubmitForm($('#expTimeForm'), '设置超时时间');
    }
}

function setLimitErrTime() {
    if ($("#limitErrForm").valid()) {
        ajaxSubmitForm($("#limitErrForm"), '设置限制登录错误次数');
    }
}

function openNewAccountDialog() {
	if ($("#currentRol").val()!=='1'){
		showErrorDialog('非超级管理员没有添加用户的权限!');
	} else { 
		var url   = 'Function/systemManagement/admin/account.php';
		var data  = {
			addUser : true
		};
		var title   = '添加管理员帐号';
		var buttons = {};
		buttons[getMessage('Add Next')] = function() {
			if ($('#editAccountForm').valid()) {
				openNewAccountDialog();
				ajaxSubmitForm($('#editAccountForm'), '结果',
                    undefined, undefined, freshAccountList);
				$(this).remove();
			}
		};
		buttons[getMessage('Ok')] = function() {
			if ($('#editAccountForm').valid()) {
				ajaxSubmitForm($('#editAccountForm'), '结果',
                    undefined, undefined, freshAccountList);
				$(this).remove();
			}
		};
		buttons[getMessage('Cancel')] = function() {
			$(this).remove();
		};
		var dialogParams = {
			width   : 540,
			height  : 380,
			buttons : buttons,
			position: jQuery.getDialogPosition(540,380)
		};
		showDialogByAjax(url, data, title, dialogParams);
	}
}

function openEditUserDialog(user,isOnline) {
	if (user!== $("#currentName").val() && isOnline==='yes') {
		showErrorDialog('不能对在线的用户进行编辑!');
	} else {
		var url  = 'Function/systemManagement/admin/account.php';
		var data = {
			tpl      : 'systemManagement/admin/editAccountDialog.tpl',
			editUser : user
		};
		var title   = '修改管理员帐号';
		var buttons = {};
		buttons[getMessage('Ok')] = function() {
			if ($('#editAccountForm').valid()) {
				ajaxSubmitForm($('#editAccountForm'), '结果',
                    undefined, undefined, freshAccountList);
				$(this).remove();
			}
		};
		buttons[getMessage('Cancel')] = function() {
			$(this).remove();
		};
		var dialogParams = {
			width   : 540,
			height  : 380,
			buttons : buttons,
			position: jQuery.getDialogPosition(540,380)
		};
		showDialogByAjax(url, data, title, dialogParams);
	}
}

function delUser(user) {
    var url    = 'Function/systemManagement/admin/account.php';
    var data   = {
        delUser : user
    };
    var title   = getMessage('Delete Account');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshAccountList();
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

function openDelUserDialog(user) {
    var dialog  = loadingScreen(getMessage('Delete Account'));
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delUser(user);
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 200,
        buttons: buttons,
		position: jQuery.getDialogPosition(300,200)
    };
    dialog.setContent('<p>' +
        getMessage("Do you confirm to delete account [%1s]?", [user]) + '</p>');
    dialog.setOptions(dialogParams);
}

function switchMultiAdm(s) {
    var url    = 'Function/systemManagement/admin/account.php';
    var data   = { 
        multiAdm : s
    };
    var title  = '结果';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
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

function multiAdm(switchDom) {
    var s = (switchDom.attr('checked') === 'checked') ? 'on' : 'off';
    if (s === 'on') {
        var dialog  = loadingScreen('确认');
        var buttons = {};
        buttons[getMessage('Ok')] = function() {
            switchMultiAdm('on');
            dialog.close();
        };
        buttons[getMessage('Cancel')] = function() {
            switchDom.removeAttr('checked')
            dialog.close();
        };
        dialogParams = {
            width: 400,
            height: 230,
            buttons: buttons,
			position: jQuery.getDialogPosition(400,230)
        }
        dialog.setOptions(dialogParams);
        var content = '<p>在多个管理员同时修改配置时,可能导致冲突. </p>'+
            '<p>不推荐使用这种管理方式.</p><p>您真的要这样做吗</p>';
        dialog.setContent(content);
    } else {
        switchMultiAdm('off');
    }
}

function freshAccountList() {
    var url  = 'Function/systemManagement/admin/account.php';
    var data = {freshAccountList: true};
    loadEmbedPage(url, data, $('#accountTable>tbody'));
}
