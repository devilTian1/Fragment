function selectAll(){
	var obj = document.getElementById("iplist");	
	if(obj)
	{
		var length = obj.length;
		
		for(var i=0; i<length ; i++)
		{
			obj.options[i].selected = true;
		}
	}
}

function setSnmpForm(){
	if ($('#setSnmpForm').valid()) {
		selectAll();
	    ajaxSubmitForm($('#setSnmpForm'), '结果');	
		//刷新页面
		showPageByAjax('systemManagement/systemConf/systemInformation/SNMP.tpl');
	}

}

function setServiceForm(action) {
	var resultDialog  = loadingScreen('结果');
	var buttons = {};
	buttons[getMessage('Ok')] = function() {    	
		var afterSuccessCallback = function(result, textStatus) {
			if (result.status !== -1) { 
				if (action == 'on') {   
					$("#switch").val('off');
					$("button[name='buttonOff']").button({ disabled: false});
					$("button[name='buttonOn']").button({ disabled: true});
					$("#status").html('启动');
				} else {
					$("#switch").val('on');
					$("button[name='buttonOff']").button({ disabled: true});
					$("button[name='buttonOn']").button({ disabled: false});
					$("#status").html('停止');
				}
			}	
		};
		ajaxSubmitForm($('#SnmpStatusForm'), '服务启停',undefined,
			undefined,afterSuccessCallback);
		$(this).remove();
	};
	
	buttons[getMessage('Cancel')] = function() {
			$(this).remove();
	};   
    dialogParams = {
        width : 250,
        height: 170,
        buttons: buttons,
		position : jQuery.getDialogPosition('250','170')
    };
	var str = action == 'on' ? '启动' : '停止';
	resultDialog.setContent('<p>确定' + str + '服务吗?</p>');
	resultDialog.setOptions(dialogParams);
}

