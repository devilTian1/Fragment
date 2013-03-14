function setInterfacemonStatus() {
	if ($("input[name='interfacemonActive']").val()=='0') {
    	var title  = '启动服务';
	} else {
		var title  = '停止服务';
	}
	var resultDialog  = loadingScreen(title);
	var buttons = {};
    	buttons['Ok'] = function() {    	
        resultDialog.close();
    }
    resultDialog.setOptions({
        width : 250,
        height: 170,
        buttons: buttons
    });
    var successCallback = function(result, textStatus) {
        if (result.status == '0') { 
            if ($("input[name='interfacemonActive']").val()=='1') {   
                $("button[name='interfacemonButton']").html('<span class="ui-button-text">启动</span>'); 
                $("#monitorStatusTd").html('<img height="16" width="16" src="Public/default/images/icon/stoplink.gif">');
                $("input[name='interfacemonActive']").val('0');
            } else {
                $("button[name='interfacemonButton']").html('<span class="ui-button-text">停止</span>');
                $("#monitorStatusTd").html('<img height="16" width="16" src="Public/default/images/icon/showlink.gif">');
                $("input[name='interfacemonActive']").val('1');
            }
        }
        resultDialog.setContent($('<p>' + result.msg + '</p>'));        
    };
    var dialog = ajaxSubmitForm($('#setInterfacemonForm'), '结果',
        successCallback);
    dialog.close();
}

function freshMonitorTable() {
    freshTable('Function/statMonitor/network/network.php',
            $('#networkTable'), 'ORDER BY external_name ASC LIMIT 10');
}

function cleanUpHistory() {
    var url    = 'Function/statMonitor/network/network.php';
    var data = {
        cleanUp: true
    };
    var title  = '清空数据文件';
    var buttons = {};
    buttons['Ok'] = function() {
        freshTable('Function/statMonitor/network/network.php',
            $('#networkTable'), 'ORDER BY external_name ASC LIMIT 10');
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
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
        height  : 325,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}