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
