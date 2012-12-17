function addRedun() {
    var url   = 'Function/resConf/user/usrGroup.php';
    var title = '定义用户组列表';
    var data  = {
        tpl : 'resConf/user/editUserGroupDialog.tpl',
        addNewUserGroup : true
    };
    
    var dialogParams = {
        width   : 800,
        height  : 540,
        position : ['center', 'top']
      //  buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}



function addProcess() {
    var url   = 'Function/resConf/user/userGroup.php';
    var title   = '进程添加';
    var data  = {
        tpl : 'resConf/user/editProcessListDialog.tpl',
        addProcess : true
    };
    var buttons = {};
    buttons['进程添加'] = function() {
        if ($('#editUserListForm').valid()) {
            $('#rolesMember option').attr('selected', 'selected');
            openNewUserListDialog();
            ajaxSubmitForm($('#editUserListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    var dialogParams = {
        width   : 620,
        height  : 600,
        position : ['center', 'top'],
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}
