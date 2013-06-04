function OpenTipsDialog(external_name) {
    var title   = '提示';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['关闭'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        Height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent('<p>用户['+external_name+']在线，不能对此用户进行任何操作。</p>');
    dialog.setOptions(dialogParams);
}

function isInUseCheck(external_name,func) {
    var url  = 'Function/resConf/user/userList.php';
    var data = {
        isInUseCheck  : true,
        checkName : external_name
    };
        var params = {
        type    : 'GET',
        success : function(result) {
            if (result == 'true') {
                OpenTipsDialog(external_name);
            } else {
                func(external_name);
            }
        }
    };    
    //showDialogByAjax(url, data, title, dialogParams);    
    loadAjax(url, data, params);
}

function isSwitchCheck(id,action,name,func) {
    var url  = 'Function/resConf/user/userList.php';
    var data = {
        isInUseCheck  : true,
        checkName : name
    };
        var params = {
        type    : 'GET',
        success : function(result) {
            if (result == 'true') {
                OpenTipsDialog(name);
            } else {
                func(id,action,name);
            }
        }
    };    
    //showDialogByAjax(url, data, title, dialogParams);    
    loadAjax(url, data, params);
}

function checkUsersInUse (key,users,func) {
    var url  = 'Function/resConf/user/userList.php';
    if (key == 'all') {
        var data = {
            checkAll  : true
        };
    } else {
            var data = {
            checkSpecUsers  : true,
            usersArray: users
        };
    }
        var params = {
        type    : 'GET',
        success : function(result) {
            if (result != 'false') {
                OpenTipsDialog(result);
            } else {
                if (key == 'all') {
                    func();
                } else {
                    func(users);
                }
            }
        }
    };    
    //showDialogByAjax(url, data, title, dialogParams);    
    loadAjax(url, data, params);
}

function openNewUserListDialog() {
    var url   = 'Function/resConf/user/userList.php';
    var title   = '定义用户列表';
    var data  = {
        tpl : 'resConf/user/editUserListDialog.tpl',
        addNewUser : true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editUserListForm').valid()) {
            $('#rolesMember option').attr('selected', 'selected');
            openNewUserListDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editUserListForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editUserListForm').valid()) {
            $('#rolesMember option').attr('selected', 'selected');
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editUserListForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 690,
        height  : 600,
        position : jQuery.getDialogPosition('690','600'),
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openEditSpecUserDialog(name) {
    var dialog = loadingScreen('编辑用户列表');
    var url   = 'Function/resConf/user/userList.php';
    var data  = {
        editUser : name
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editUserListForm').valid()) {
            $('#rolesMember option').attr('selected', 'selected');
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editUserListForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 690,
        height  : 600,
        position : jQuery.getDialogPosition('690','600'),
        buttons : buttons
    };
    var successCallback = function(result, textStatus) {
        dialog.setContent(result.msg);
        dialog.setOptions(dialogParams);
        changeAuthType();
    };
    var errorCallback = function(XMLHttpRequest, textStatus, errorThrown) {
        result = 'ERROR: AJAX error. Respone text: ' +
            XMLHttpRequest.responseText + ', status:' + textStatus +
            ', errorThrown:' + errorThrown;
        dialog.setContent($('<p>' + result + '</p>'));
    };
    var dialog_c = showDialogByAjax(url, data, '', dialogParams, '',
            successCallback, errorCallback);
    dialog_c.close();
}

function openDelAllUserListDialog() {
    var dialog  = loadingScreen('删除用户列表');
    var buttons = {};
    if ($("input[name='dataCount']").val() === '0') {
        dialog.setContent("<p>没有任何用户?</p>");
        buttons['关闭']  = function() {
            $(this).remove();
        };
    } else {
        buttons['确定'] = function() {
            //delAllUsers();
            var users = [];
            checkUsersInUse('all',users,delAllUsers);
            freshTableAndPage();
            $(this).remove();
        };
        buttons['取消']  = function() {
            $(this).remove();
        };

        dialog.setContent("<p>确定要删除所有用户数据吗?</p>");           
    }
    var dialogParams = {
            width: 300,
            height: 160,
            buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setOptions(dialogParams);
}

function delAllUsers() {
    var url  = 'Function/resConf/user/userList.php';
    var data = {
        delAllUsers : true
    };
    var title  = '删除用户列表';
    var buttons = {};
    buttons['关闭'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition('250','170')
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function delUser(name) {
    var url  = 'Function/resConf/user/userList.php';
    var data = {
        delName: name
    };
    var title  = '删除用户列表';
    var buttons = {};
    buttons['关闭'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition('250','170')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelSpecUserDialog(name) {
    var dialog  = loadingScreen('删除用户列表');
    var buttons = {};
    buttons['确定'] = function() {
        delUser(name);
        freshTableAndPage();
        $(this).remove();
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的用户数据吗?</p>");
    dialog.setOptions(dialogParams);
}

function openImportSnFileDialog(name) {
    var url   = 'Function/resConf/user/userList.php';
    var title   = '导入SN文件';
    var data  = {
        showImportSnFileName: name
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editImportSnFileForm').valid()) {
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editImportSnFileForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 430,
        height  : 260,
        buttons : buttons,
        position : jQuery.getDialogPosition('430','260')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openActiveSpecUserDialog(name) {
    var url   = 'Function/resConf/user/userList.php';
    var title   = '动态密码同步';
    var data  = {
        showActiveUserName: name
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editActiveUserForm').valid()) {
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editActiveUserForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 420,
        height  : 260,
        buttons : buttons,
        position : jQuery.getDialogPosition('420','260')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delSpecUsers(users) {
    var url  = 'Function/resConf/user/userList.php';
    if ($('#checkAllUser').attr('checked') === 'checked') {
        var data = {
            delAllUsers: true
        };
    } else {
        var data = {
            delSpecUsers: users
        };
    }
    var title  = '删除用户列表';
    var buttons = {};
    buttons['关闭'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        Height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition('250','170')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelSpecUserListDialog() {
    var users = [];
    $('input:checkbox[name="checkSpecUser"]:checked').each(function(i) {
        users[i] = $(this).parent().next().next().html();
    });
    var dialog  = loadingScreen('删除已选用户');
    var buttons = {};
    if (users.length === 0) {
        dialog.setContent("<p>没有选择任何用户?</p>");
        buttons['关闭']  = function() {
            $(this).remove();
        };
    } else {
        dialog.setContent("<p>确定要删除已选的用户数据吗?</p>");
        buttons['确定'] = function() {
            if ($('#checkAllUser').attr('checked') === 'checked')  {
                checkUsersInUse('all',users,delSpecUsers);
            } else {
                checkUsersInUse('spec',users,delSpecUsers);
            }
            //delSpecUsers(users);
            freshTableAndPage();
            $(this).remove();
        };
        buttons['取消']  = function() {
            $(this).remove();
        };
    }
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setOptions(dialogParams);
}

function openLockSpecUserDialog(name) {
    var url   = 'Function/resConf/user/userList.php';
    var title   = '锁定用户';
    var data  = {
        lockUser : name
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editLockTimeForm').valid()) {
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editLockTimeForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 420,
        height  : 260,
        buttons : buttons,
        position : jQuery.getDialogPosition('420','260')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openResetSpecUserPwdDialog(name) {
    var url   = 'Function/resConf/user/userList.php';
    var title   = '重置密码';
    var data  = {
        resetPwdUser : name
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editResetPwdForm').valid()) {
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editResetPwdForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 550,
        height  : 320,
        buttons : buttons,
        position : jQuery.getDialogPosition('550','320')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function moveToSpecRole() {
    $('#allRoles option:selected').appendTo($('#rolesMember'));
}

function moveToAllRoles() {
    $('#rolesMember option:selected').appendTo($('#allRoles'));
}

function dynCheckbox() {
    if ($('input:checkbox[name="checkSpecUser"]:unchecked').length === 0) {
        $('#checkAllUser').attr('checked', 'checked');
    } else {
        $('#checkAllUser').removeAttr('checked');
    }
}
function checkAllUser() {
    if ($('#checkAllUser').attr('checked')) {
        $('input:checkbox[name="checkSpecUser"]').attr('checked', 'checked');
    } else {
        $('input:checkbox[name="checkSpecUser"]').removeAttr('checked');
    }
}

function freshTableAndPage() {
    var url = 'Function/resConf/user/userList.php';
    freshTable(url, $('#userListTable'));
    freshPagination(url, $('.pager'));
}

function changeAuthType() {
    var authType = $(':radio[name="authType"]:checked').val();
    if ('dyn-pwd' === authType) {
        if ($("input[name='type']").val() == "edit" && $("input[name='vip']").val() != 1) {
    		$("#modifyEnable").removeAttr('disabled');
    	} else {
        		$('#passwd_user').removeAttr('disabled');
        		$('#passwd_user_again').removeAttr('disabled');
	}
        $('#sn').removeAttr('disabled');
        $('#userModifyDiv').removeClass('hide');
        $('#firstModifyDiv').removeClass('hide');
        $('input[name="modifyPwdAllow"]').removeAttr('disabled');
        $('input[name="firstChangePwd"]').removeAttr('disabled');
        $('#userValidTimeDiv').removeClass('hide');
        $('#psswdValidTimeDiv').removeClass('hide');
        $('input[name="validTime"]').removeAttr('disabled');
        $('input[name="validTime_pwd"]').removeAttr('disabled');
    } else if ('local-pwd' === authType) {
	if ($("input[name='type']").val() == "edit" && $("input[name='vip']").val() != 1) {
		$("#modifyEnable").removeAttr('disabled');
	} else {
	        $('#passwd_user').removeAttr('disabled');
	        $('#passwd_user_again').removeAttr('disabled');
	}
        $('#sn').attr('disabled', 'disabled');
        $('#userModifyDiv').removeClass('hide');
        $('#firstModifyDiv').removeClass('hide');
        $('input[name="modifyPwdAllow"]').removeAttr('disabled');
        $('input[name="firstChangePwd"]').removeAttr('disabled');
        $('#userValidTimeDiv').removeClass('hide');
        $('#psswdValidTimeDiv').removeClass('hide');
        $('input[name="validTime"]').removeAttr('disabled');
        $('input[name="validTime_pwd"]').removeAttr('disabled');
    } else if ('local-cert' === authType) {
	if ($("input[name='type']").val() == "edit" && $("input[name='vip']").val() != 1) {
		$("#modifyEnable").attr('disabled', 'disabled');
	} else {
		$('#passwd_user').attr('disabled', 'disabled');
		$('#passwd_user_again').attr('disabled', 'disabled');
	}
        $('#sn').attr('disabled', 'disabled');
        $('#userModifyDiv').removeClass('hide');
        $('#firstModifyDiv').removeClass('hide');
        $('input[name="modifyPwdAllow"]').removeAttr('disabled');
        $('input[name="firstChangePwd"]').removeAttr('disabled');
        $('#userValidTimeDiv').removeClass('hide');
        $('#psswdValidTimeDiv').removeClass('hide');
        $('input[name="validTime"]').removeAttr('disabled');
        $('input[name="validTime_pwd"]').removeAttr('disabled');
    } else if ('vip' === authType) {
    	if ($("input[name='type']").val() == "edit" && $("input[name='vip']").val() != 1) {
        		$("#modifyEnable").attr('disabled', 'disabled');
   	} else {
        		$('#passwd_user').attr('disabled', 'disabled');
        		$('#passwd_user_again').attr('disabled', 'disabled');
	}
        $('#sn').attr('disabled', 'disabled');
        $('#userModifyDiv').addClass('hide');
        $('#firstModifyDiv').addClass('hide');
        $('input[name="modifyPwdAllow"]').attr('disabled', 'disabled');
        $('input[name="firstChangePwd"]').attr('disabled', 'disabled');
        $('#userValidTimeDiv').addClass('hide');
        $('#psswdValidTimeDiv').addClass('hide');
        $('input[name="validTime"]').attr('disabled', 'disabled');
        $('input[name="validTime_pwd"]').attr('disabled', 'disabled');
    } else {
    }
    if ($("input[name='type']").val() == "edit" && $("input[name='vip']").val() != 1) {
	enablePasswd();
    }
}

function enablePasswd() {
    if ($("#modifyEnable").attr("checked") == 'checked' && $("#modifyEnable").attr("disabled") !== 'disabled') {
    	$("input[name='passwd_user']").removeAttr("disabled");
    	$("input[name='passwd_user']").attr("value","");
    	$("input[name='passwd_user_again']").removeAttr("disabled");
    	$("input[name='passwd_user_again']").attr("value","");
    } else {
	$("input[name='passwd_user']").attr("value","*********");
    	$("input[name='passwd_user']").attr("disabled",'disabled');
  
	$("input[name='passwd_user_again']").attr("value","*********"); 
	$("input[name='passwd_user_again']").attr("disabled",'disabled');    	
    }
}

function switchUserActive(id, action,name) {
    var title   = '启用/禁用用户';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        var afterSuccessCallback = function() {
                freshTableAndPage();
        };
        ajaxSubmitForm($('#switchUserActiveForm_' + id), '结果', undefined,
                undefined, afterSuccessCallback);
        $(this).remove();
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };

    var str = action === 'disable' ? '禁用' : '启用';
    dialog.setContent('<p>确定' + str + '[' +  name + ']吗?</p>');
    dialog.setOptions(dialogParams);
}