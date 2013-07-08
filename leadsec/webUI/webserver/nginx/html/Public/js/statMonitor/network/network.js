function setInterfacemonStatus() {
	if ($("input[name='interfacemonActive']").val()=='0') {
    	var title  = '启动服务';
	} else {
		var title  = '停止服务';
	}
    var afterSuccessCallback  = function(result, textStatus) {
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
    };
		ajaxSubmitForm($('#setInterfacemonForm'),title,undefined,
			undefined,afterSuccessCallback);
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
    var afterSuccessCallback = function(result, textStatus) {
        $("#freshCurrentContent").html(result.msg_result);        
    };
    ajaxSubmitForm($('#editNetworkForm'), '结果',undefined,undefined,
        afterSuccessCallback);
    $(this).remove();
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
