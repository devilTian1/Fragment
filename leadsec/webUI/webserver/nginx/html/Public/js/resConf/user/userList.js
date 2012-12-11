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
            openNewUserListDialog();
            ajaxSubmitForm($('#editUserListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editUserListForm').valid()) {
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
