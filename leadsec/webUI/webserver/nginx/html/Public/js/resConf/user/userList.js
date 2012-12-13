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

function openDelSpecUserListDialog() {

}

function openActiveSpecUserDialog(userId) {

}

function openDelUserDialog(userId) {

}

function openLockSpecUserDialog() {

}

function openResetSpecUserPwdDialog() {

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

