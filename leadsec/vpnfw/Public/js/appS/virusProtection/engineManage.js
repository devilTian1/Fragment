function setServiceForm() {
	var resultDialog  = loadingScreen('结果');
	var buttons = {};
	buttons[getMessage('Ok')] = function() {    	
		var afterSuccessCallback = function(result, textStatus) {
			if (result.status == 0) {
				if ($("#stopService").val() == 'disable') {   
					$("#stopService").val('enable');
					$("button[name='buttonOff']").attr("disabled",'disabled');
					$("button[name='buttonOff']").addClass("ui-button-disabled");
					$("button[name='buttonOff']").addClass("ui-state-disabled");
					$("button[name='buttonOn']").removeClass("ui-button-disabled");
					$("button[name='buttonOn']").removeClass("ui-state-disabled");
					$("button[name='buttonOn']").removeAttr("disabled");
					$("#status").html('停止');
				} else {
					$("#stopService").val('disable');
					$("button[name='buttonOn']").attr("disabled",'disabled');
					$("button[name='buttonOff']").removeAttr("disabled");
					$("button[name='buttonOn']").addClass("ui-button-disabled");
					$("button[name='buttonOn']").addClass("ui-state-disabled");
					$("button[name='buttonOff']").removeClass("ui-button-disabled");
					$("button[name='buttonOff']").removeClass("ui-state-disabled");
					$("#status").html('启动');
				}
			}	
		};
		ajaxSubmitForm($('#setEngineManageForm'), '服务启停',undefined,
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
	var str = $("#stopService").val() == 'disable' ? '停止' : '启动';
	resultDialog.setContent('<p>确定' + str + '服务吗?</p>');
	resultDialog.setOptions(dialogParams);
}
