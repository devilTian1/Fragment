function unlockUserDialog(name) {
    var dialog  = loadingScreen('时间解锁');
    var buttons = {};
    buttons['Confirm'] = function() {
        unlock(name);
        $(this).remove();
        freshTableAndPage();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要为名称是" + [name] + "的用户解锁时间吗?</p>");
    dialog.setOptions(dialogParams);   
}
function unlock(name) {
    var url  = 'Function/statMonitor/user/lockUser.php';
    var data = {
    	unlockUsersTime: name
    };
    var title  = '时间解锁';
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

function freshTableAndPage() {
    var url = 'Function/statMonitor/user/lockUser.php';
    freshTable(url, $('#lockUserTable'));
    freshPagination(url, $('.pager'));
}
