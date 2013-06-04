function serverConfBtn() {
    if($('#serverIPForm').valid()){
		var afterSuccessCallback = function() {
            };
        ajaxSubmitForm($('#serverIPForm'), '服务器设置 ',undefined,
			undefined,afterSuccessCallback);
    }
}
function localAddrBtn() {
    if($('#localAddrForm').valid()){
		var afterSuccessCallback = function() {
            }
        ajaxSubmitForm($('#localAddrForm'), '本地设置 ',undefined,
			undefined,afterSuccessCallback);
    }
}
function downloadConfDialog() {
    var dialog  = loadingScreen('下载配置');
    var serverIp  = $('#serverIp').val();
	var serverPort = $('#serverPort').val();
    var buttons = {};
    if(serverIp==="" || serverPort===""){
    	dialog.close();
    	showErrorDialog('请输入服务器IP和端口，然后再点击下载配置！');
    
    }else{
    	buttons[getMessage('Ok')] = function() {
        	download();
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
            dialog.setContent("<p>确定要下载配置吗?</p>");
            dialog.setOptions(dialogParams);   
    }        
}

function download() {
    var url  = 'Function/networkManagement/HA/syncConf.php';
    var data = {
        downloadConf : true
    };
    var title  = '下载配置';
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

function rollbackConfDialog() {
    var dialog  = loadingScreen('回滚配置');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	rollback();
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

function syncHistoryDialog() {
    var url   = 'Function/networkManagement/HA/syncConf.php';
    var title = '同步历史记录';
    var data  = {
		historyDialog: true
    };
    var buttons = {};     
    buttons[getMessage('Ok')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 520,
        buttons : buttons,
        position: jQuery.getDialogPosition(680,520)
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function startConfDialog() {
    var dialog  = loadingScreen('启动服务');
    var buttons = {};
    var localAddr  = $('#localAddr').val();
	var localPort = $('#localPort').val();
    if(localAddr==="" || localPort===""){
    	dialog.close();
    	showErrorDialog('请输入本地监听地址和端口，然后再点击启动服务！');
    
    }else{
    	buttons[getMessage('Ok')] = function() {
        	start();
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
        dialog.setContent("<p>确定要启动服务吗?</p>");
        dialog.setOptions(dialogParams);  
    }     
}

function start() {
    var url  = 'Function/networkManagement/HA/syncConf.php';
    var data = {
    	startConf : true
    };
    var title  = '启动服务';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	$("button[name='buttonOff']").button({ disabled: false});
        $("button[name='buttonOn']").button({ disabled: true});
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
function stopConfDialog() {
    var dialog  = loadingScreen('停止服务');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	stop();
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
    dialog.setContent("<p>确定要停止服务吗?</p>");
    dialog.setOptions(dialogParams);   
}

function stop() {
    var url  = 'Function/networkManagement/HA/syncConf.php';
    var data = {
    	stopConf : true
    };
    var title  = '停止服务';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	$("button[name='buttonOff']").button({ disabled: true});
        $("button[name='buttonOn']").button({ disabled: false});
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
function downHistoryDialog() {
    var url   = 'Function/networkManagement/HA/syncConf.php';
    var title = '下载历史记录';
    var data  = {
		downDialog: true
    };
    var buttons = {};     
    buttons[getMessage('Ok')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 520,
        buttons : buttons,
        position: jQuery.getDialogPosition(680,520)
    };
    showDialogByAjax(url, data, title, dialogParams);
}
