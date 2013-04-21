function ftpTransBtn() {
    $('#action').val('conf');
    var ftpname = $('#ftpName').val();
    if(ftpname =="anonymous"){
    	showErrorDialog('请不要配置匿名FTP用户');
    }else {
    	if($('#ftpTransForm').valid()){
            ajaxSubmitForm($('#ftpTransForm'), '设置FTP相关配置 ');
        }
    }
    
}

function testFtpBtn() {
    $('#action').val('test');
	if($('#ftpTransForm').valid()){
        ajaxSubmitForm($('#ftpTransForm'), '测试FTP配置');
	}
}


function logTransBtn() {
	if($('#logTransForm').valid()){
		var dialog  = loadingScreen('设置自动上传日志');
		var buttons = {};
		buttons[getMessage('Ok')] = function() {
			set();
			$(this).remove();
		};
		buttons[getMessage('Cancel')] = function() {
			$(this).remove();
		};
		var dialogParams = {
			width: 300,
			height: 160,
			buttons: buttons,
			position: jQuery.getDialogPosition(300,160)
		};
		dialog.setContent("<p>确定要设置自动上传日志功能吗?</p>");
		dialog.setOptions(dialogParams); 
	}
}

function set() {
    var url  = 'Function/log/conf/ftpConf.php?auto=1';    
    var autoUpload = $('#autoUploadChk').attr("checked") === 'checked' ? 'on':'off';
    var data = {
    	autoUpload: autoUpload,
    	ftpMinute: $('#ftpMinute').val(),
    	ftpHour: $('#ftpHour').val(),
    	ftpDay: $('#ftpDay').val()
    };
    var title  = '设置自动上传日志';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	 if ($('#ftpMinute').val() =='0') {   
             $('#ftpMinute').attr("value","");
         }
         if ($('#ftpHour').val() =='0') {   
             $('#ftpHour').attr("value","");
         }
         if ($('#ftpDay').val() =='0') {   
             $('#ftpDay').attr("value","");
         }
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
function logTransAllrightBtn() {
    var dialog  = loadingScreen('立即上传日志');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	download();
        $(this).remove();
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要立即上传日志吗?</p>");
    dialog.setOptions(dialogParams);   
}

function download() {
    var url  = 'Function/log/conf/ftpConf.php?log=1';
    var data = {
    	logTrans : true
    };
    var title  = '立即上传日志';
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
