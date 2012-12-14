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
            ajaxSubmitForm($('#editUserListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editUserListForm').valid()) {
            $('#rolesMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editUserListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 600,
        position : ['center', 'top'],
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
            ajaxSubmitForm($('#editUserListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 600,
        position : ['center', 'top'],
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

}

function delUser(name) {
    var url  = 'Function/resConf/user/userList.php';
    var data = {
        delName: name
    };
    var title  = '删除用户列表';
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

function openDelSpecUserDialog(name) {
    var dialog  = loadingScreen('删除用户列表');
    var buttons = {};
    buttons['Confirm'] = function() {
        delUser(name);
        freshTableAndPage();
        $(this).remove();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的用户数据吗?</p>");
    dialog.setOptions(dialogParams);   
}

function openActiveSpecUserDialog(userId) {

}

function openDelUserDialog(userId) {

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
            ajaxSubmitForm($('#editLockTimeForm'), '结果');
            freshTableAndPage();
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
        buttons : buttons
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
            ajaxSubmitForm($('#editResetPwdForm'), '结果');
            freshTableAndPage();
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
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function moveToSpecRole() {
    $('#allRoles option:selected').appendTo($('#rolesMember'));
}

function moveToAllRoles() {
    $('#rolesMember option:selected').appendTo($('#allRoles'));
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
    freshTable(url, $('#userTable'));
    freshPagination(url, $('.pager'));
}

function changeAuthType() {
    var authType = $(':radio[name="authType"]:checked').val();
    if ('twofa' === authType) {
        $('.twofa').show();
        $('#passwd_user').removeAttr('disabled');
        $('#passwd_user_again').removeAttr('disabled');
        $('#sn').removeAttr('disabled');
        if ('cert-pwd' === $(':radio[name="twofaType"]:checked').val()) {
            $('#sn').attr('disabled', 'disabled');
        } else { //dynpwd
            $('#sn').removeAttr('disabled');
        }
    } else if ('local-pwd' === authType) {
        $('.twofa').hide();
        $('#passwd_user').removeAttr('disabled');
        $('#passwd_user_again').removeAttr('disabled');
        $('#sn').attr('disabled', 'disabled');
    } else if ('local-cert' === authType) {
        $('.twofa').hide();
        $('#passwd_user').attr('disabled', 'disabled');
        $('#passwd_user_again').attr('disabled', 'disabled');
        $('#sn').attr('disabled', 'disabled');
    } else if ('vip' === authType) {
        $('.twofa').hide();
        $('#passwd_user').attr('disabled', 'disabled');
        $('#passwd_user_again').attr('disabled', 'disabled');
        $('#sn').attr('disabled', 'disabled');
    } else {
    }
}

