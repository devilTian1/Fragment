function addUserGroup() {
    var url   = 'Function/resConf/user/userGroup.php';
    var title = '定义用户组列表';
    var data  = {
        tpl : 'resConf/user/editUserGroupDialog.tpl',
        addNewUserGroup : true
    };

    var buttons = {};
    buttons['添加下一条'] = function() {
    
    };

    buttons['确定'] = function() {

    } ;

    buttons['取消'] = function() {

    } ;

    var dialogParams = {
        width   : 800,
        height  : 540,
        position : ['center', 'top'],
        buttons : buttons
    };
    
    showDialogByAjax(url, data, title, dialogParams);
}



function checkProcess() {
    var url   = 'Function/resConf/user/userGroup.php';
    var title   = '进程添加';
    var data  = {
        tpl : 'resConf/user/editProcessListDialog.tpl',
        addProcess : true
    };
    var buttons = {};
    buttons['进程添加'] = function() {

    };
    var dialogParams = {
        width   : 620,
        height  : 600,
        position : ['center', 'top'],
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}
