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
    buttons['Ok'] = function() {
    	showPageByAjax('statMonitor/res/res.php');
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelRes() {
	var dialog  = loadingScreen('清空数据文件');
    var buttons = {};
    buttons['Confirm'] = function() {
        delResData();
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
    buttons['Ok'] = function() {
    	showPageByAjax('statMonitor/res/res.php');
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
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
        position : ['center', 'top'],
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

