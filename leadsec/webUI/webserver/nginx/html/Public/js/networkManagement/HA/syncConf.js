function serverConfBtn() {
    if($('#serverIPForm').valid()){
        ajaxSubmitForm($('#serverIPForm'), '服务器设置 ');
    }
}
function localAddrBtn() {
    if($('#localAddrForm').valid()){
        ajaxSubmitForm($('#localAddrForm'), '本地设置 ');
    }
}
function downloadConfDialog() {
    var dialog  = loadingScreen('下载配置');
    var buttons = {};
    buttons['Confirm'] = function() {
    	download();
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
    dialog.setContent("<p>确定要下载配置吗?</p>");
    dialog.setOptions(dialogParams);   
}

function download() {
    var url  = 'Function/networkManagement/HA/syncConf.php';
    var data = {
        downloadConf : true
    };
    var title  = '下载配置';
    var buttons = {};
    buttons['Ok'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function rollbackConfDialog() {
    var dialog  = loadingScreen('回滚配置');
    var buttons = {};
    buttons['Confirm'] = function() {
    	rollback();
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
    dialog.setContent("<p>确定要回滚配置吗?</p>");
    dialog.setOptions(dialogParams);   
}

function rollback() {
    var url  = 'Function/networkManagement/HA/syncConf.php';
    var data = {
    	rollbackConf : true
    };
    var title  = '回滚配置';
    var buttons = {};
    buttons['Ok'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function syncHistoryDialog() {
    var url   = 'Function/networkManagement/HA/syncConf.php';
    var title = '同步历史记录';
    var data  = {
		historyDialog: true
    };
    var buttons = {};     
    buttons['OK'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 520,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function startConfDialog() {
    var dialog  = loadingScreen('启动配置');
    var buttons = {};
    buttons['Confirm'] = function() {
    	start();
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
    dialog.setContent("<p>确定要启动配置吗?</p>");
    dialog.setOptions(dialogParams);   
}

function start() {
    var url  = 'Function/networkManagement/HA/syncConf.php';
    var data = {
    	startConf : true
    };
    var title  = '启动配置';
    var buttons = {};
    buttons['Ok'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}
function stopConfDialog() {
    var dialog  = loadingScreen('停止配置');
    var buttons = {};
    buttons['Confirm'] = function() {
    	stop();
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
    dialog.setContent("<p>确定要停止配置吗?</p>");
    dialog.setOptions(dialogParams);   
}

function stop() {
    var url  = 'Function/networkManagement/HA/syncConf.php';
    var data = {
    	stopConf : true
    };
    var title  = '停止配置';
    var buttons = {};
    buttons['Ok'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}
function downHistoryDialog() {
    var url   = 'Function/networkManagement/HA/syncConf.php';
    var title = '下载历史记录';
    var data  = {
		downDialog: true
    };
    var buttons = {};     
    buttons['OK'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 520,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}
