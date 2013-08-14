function refreshAllOnlineUserDialog() {
    var dialog  = loadingScreen('刷新在线用户');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshAllUsers();
        freshTableAndPage();
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
    dialog.setContent("<p>确定要刷新在线用户吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshAllUsers() {
    var url  = 'Function/statMonitor/user/onlineUser.php';
    var data = {
        refreshAllUsers : true
    };
    var title  = '刷新在线用户';
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
function DelAllOnlineUserDialog() {
    var dialog  = loadingScreen('在线用户全部下线');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delAllUsers();
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
    dialog.setContent("<p>确定要使在线用户全部下线吗?</p>");
    dialog.setOptions(dialogParams);   
}

function delAllUsers() {
    var url  = 'Function/statMonitor/user/onlineUser.php';
    var data = {
    	delAllUsers : true
    };
    var title  = '在线用户全部下线';
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
function onlineUserToDownDialog(name) {
    var dialog  = loadingScreen('强制用户下线');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        del(name);
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
    dialog.setContent("<p>确定要强制名称为" + [name] + "的用户下线吗?</p>");
    dialog.setOptions(dialogParams);   
}
function del(name) {
    var url  = 'Function/statMonitor/user/onlineUser.php';
    var data = {
    	delSpecUsersName: name
    };
    var title  = '强制用户下线';
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
function onlineUserTimeResetDialog(name) {
    var dialog  = loadingScreen('时间重置');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        reset(name);
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
    dialog.setContent("<p>确定要重置用户名称为" + [name] + "的时间吗?</p>");
    dialog.setOptions(dialogParams);   
}
function reset(name) {
    var url  = 'Function/statMonitor/user/onlineUser.php';
    var data = {
    	resetSpecUsersTime: name
    };
    var title  = '时间重置';
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

function freshTableAndPage() {
    var url = 'Function/statMonitor/user/onlineUser.php';
    freshTable(url, $('#userOnlineTable'));
    freshPagination(url, $('.pager'));
}
