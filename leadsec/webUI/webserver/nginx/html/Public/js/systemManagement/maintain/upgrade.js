

function upgradeSystem() {
	var form = $('#upgradeForm');
	var successCallback = function(result, textStatus) {
		var content = result.msg;
		var dialog  = loadingScreen('升级文件');
		var buttons = {};
		buttons['确定'] = function() {
			$(this).remove();
		};
		var dialogParams = {
			width: 400,
			height: 400,
			buttons: buttons
		};
		dialog.setContent(content);
		dialog.setOptions(dialogParams); 
		freshTable('Function/systemManagement/maintain/upgrade.php', $('#upgradeListTable'),'ORDER BY id DESC');
	};
	if (form.valid()) {
		var dialogcmd = ajaxSubmitForm(form, '结果',successCallback);
		dialogcmd.close();
	}
}

function reboot() {
	var form = $('#rebootForm');
	if (form.valid()) {
		ajaxSubmitForm(form, '结果');
	}
}

