function setHaForm(){
	if ($('#HaBasicForm').valid()) {
	    ajaxSubmitForm($('#HaBasicForm'), '结果');
	}
}

function setServiceForm(action) {
	var resultDialog  = loadingScreen('结果');
	var buttons = {};
	buttons[getMessage('Ok')] = function() {    	
		var afterSuccessCallback = function(result, textStatus) {
			if (result.status == 0) {
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
		ajaxSubmitForm($('#HaStatusForm'), '服务启停',undefined,
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

function changeWorkMode() {
	var val = $("input:radio[id^='work_mode_']:checked").val();
	if (val == 'P') {
		$("#ifcfg_D").attr("disabled",'disabled');
	} else {
		$("#ifcfg_D").removeAttr("disabled",'disabled');
	}
}