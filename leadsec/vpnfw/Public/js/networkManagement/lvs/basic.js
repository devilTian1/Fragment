function setServiceForm(action) {
	var title   = '启动/停止服务';
	var dialog  = loadingScreen(title);
	var buttons = {}; 
	buttons[getMessage('Ok')] = function() {
		var afterSuccessCallback = function(result, textStatus) {
			if (result.status ==0) { 
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
		}
		ajaxSubmitForm($('#statusForm'), '结果', undefined,
			undefined, afterSuccessCallback);
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
	var str = action === 'off' ? '停止' : '启动';
	dialog.setContent('<p>确定' + str + '服务吗?</p>');
	dialog.setOptions(dialogParams);
}

