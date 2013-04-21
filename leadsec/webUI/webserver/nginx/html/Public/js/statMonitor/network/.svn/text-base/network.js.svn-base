function setInterfacemonStatus() {
	if ($("input[name='interfacemonActive']").val()=='0') {
    	var title  = '启动服务';
	} else {
		var title  = '停止服务';
	}
	var resultDialog  = loadingScreen(title);
	var buttons = {};
    	buttons['关闭'] = function() {    	
        resultDialog.close();
    }
    resultDialog.setOptions({
        width : 250,
        height: 170,
        buttons: buttons,
        position : jQuery.getDialogPosition('250','170')
    });
    var successCallback = function(result, textStatus) {
        if (result.status == '0') { 
            if ($("input[name='interfacemonActive']").val()=='1') {   
                $("button[name='interfacemonButton']").html('<span class="ui-button-text">启动</span>'); 
                $("#monitorStatusTd").html('<img height="16" width="16" src="Public/default/images/icon/stoplink.gif">');
                $("input[name='interfacemonActive']").val('0');
                $("#clearButton").hide();
            } else {
                $("button[name='interfacemonButton']").html('<span class="ui-button-text">停止</span>');
                $("#monitorStatusTd").html('<img height="16" width="16" src="Public/default/images/icon/showlink.gif">');
                $("input[name='interfacemonActive']").val('1');
                $("#clearButton").show();
            }
        }
        resultDialog.setContent($('<p>' + result.msg + '</p>'));        
    };
    var dialog = ajaxSubmitForm($('#setInterfacemonForm'), '结果',
        successCallback);
    dialog.close();
}

function freshMonitorTable() {
     var url    = 'Function/statMonitor/network/network.php';
    var data = {
        freshTable: true
    };
    var params = {
        type     : 'POST'
    };

     loadAjax(url, data, params);
     freshTable('Function/statMonitor/network/network.php',
            $('#networkTable'), 'ORDER BY external_name ASC');
}

function cleanUpHistory() {
    var url    = 'Function/statMonitor/network/network.php';
    var data = {
        cleanUp: true
    };
    var title  = '清空数据文件';
    var buttons = {};
    buttons['关闭'] = function() {
        freshTable('Function/statMonitor/network/network.php',
            $('#networkTable'), 'ORDER BY external_name ASC');
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

function openNetworkDialog(name) {
    var url  = 'Function/statMonitor/network/network.php';
    var data = {
        openNetworkDialog  : true,
        externalName : name
    };
    var title   = '当前状态';
    var dialogParams = {
        width   : 810,
        height  : 400,
        position : jQuery.getDialogPosition('810','400')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function freshCurrentStatus() {
    var successCallback = function(result, textStatus) {
        $("#freshCurrentContent").html(result.msg);        
    };
    var dialog = ajaxSubmitForm($('#editNetworkForm'), '结果',
        successCallback);
    dialog.close();
}

function openNetworkChartDialog(name) {
    var url  = 'Function/statMonitor/network/network.php';
    var data = {
        openNetworkChartDialog  : true,
        externalName : name
    };
    var title   = name+'统计图';
    var dialogParams = {
        width   : 1000,
        height  : 420,
        position : jQuery.getDialogPosition('1000','420')
    };
    showDialogByAjax(url, data, title, dialogParams);
}
