

function upgradeSystem() {
	var form = $('#upgradeForm');
	var successCallback = function(result, textStatus) {
		var content = result.msg;
		var dialog  = loadingScreen('升级文件');
		var buttons = {};
		buttons[getMessage('Confirm')] = function() {
			$(this).remove();
		};
		var dialogParams = {
			width: 200,
			height: 200,
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

function openRebootDialog() {
    var dialog  = loadingScreen('重启网闸');
    var buttons = {};
    buttons[getMessage('Confirm')] = function() {
		reboot();
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要重启网闸吗?</p>");
    dialog.setOptions(dialogParams);
}

function reboot() {
	var form = $('#rebootForm');
	if (form.valid()) {
		ajaxSubmitForm(form, '结果');
	}
}

