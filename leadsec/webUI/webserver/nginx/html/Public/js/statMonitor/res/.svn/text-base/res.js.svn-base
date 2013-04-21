/*
function resActive(){
	if($('#active').val() === '停止') 
	{
		$('#setConfForm').get(0).action = "Function/statMonitor/res/res.php?active=0";
	}
	else
	{
		$('#setConfForm').get(0).action = "Function/statMonitor/res/res.php?active=1";
	}
	ajaxSubmitForm($('#setConfForm'), '资源监控服务');
}*/

function resActive(){
	var url  = 'Function/statMonitor/res/res.php';
	if($('#active').val() === '停止') {
		var data = {
	    		resActive: "off"
	    };
	}else{
		var data = {
	    		resActive: "on"
	    };
	}	
    var title  = '资源监控服务';
    var buttons = {};
    buttons['确定'] = function() {
    	showPageByAjax('statMonitor/res/res.php');
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

function openDelRes() {
	var dialog  = loadingScreen('清空数据文件');
    var buttons = {};
    buttons['确定'] = function() {
        delResData();
        $(this).remove();
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent("<p>确定要清空数据文件吗?</p>");
    dialog.setOptions(dialogParams);
}

function delResData() {
    var url  = 'Function/statMonitor/res/res.php';
    var data = {
    	clearData: true
    };
    var title  = '清空数据文件';
    var buttons = {};
    buttons['确定'] = function() {
    	showPageByAjax('statMonitor/res/res.php');
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

function openInfo(tpl,info,title){
	var url   = 'Function/statMonitor/res/res.php';
    var data  = {
        tpl : tpl,
        info : info
    };
    var buttons = {};
    buttons['关闭'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 400,
        height  : 380,
        position : jQuery.getDialogPosition('400','380'),
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openCPUChartDialog() {
    var url  = 'Function/statMonitor/res/res.php';
    var data = {
        openCPUChartDialog  : true
    };
    var title   = 'CPU统计图';
    var dialogParams = {
        width   : 1000,
        height  : 420,
        position : jQuery.getDialogPosition('1000','420')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openMemChartDialog() {
    var url  = 'Function/statMonitor/res/res.php';
    var data = {
        openMemChartDialog  : true
    };
    var title   = '内存统计图';
    var dialogParams = {
        width   : 1000,
        height  : 420,
        position : jQuery.getDialogPosition('1000','420')
    };
    showDialogByAjax(url, data, title, dialogParams);
}