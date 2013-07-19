

function upgradeSystem() {
	var form = $('#upgradeForm');
	if (form.valid()) {
	var afterSuccessCallback = function(result, textStatus) {
		var content = result.msg;
		dialog.setContent(content);
		freshTable('Function/systemManagement/maintain/upgrade.php', $('#upgradeListTable'),'ORDER BY id DESC');
	};
		ajaxSubmitForm(form, '结果',undefined,undefined,afterSuccessCallback);
		$(this).remove();
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
    var dialog = loadingScreen(getMessage('Result'));
    dialog.dialog('moveToTop');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        dialog.close();
    }
    dialog.setOptions({
        width : 250,
        height: 170,
        buttons: buttons
    });

    var url    = 'Function/systemManagement/maintain/upgrade.php';
    var data   = {reboot : 1};
    var params = {
        type : 'GET',
        beforeSend: function() {
            var str = getMessage('Rebooting. It will take two or three mins ' +
                'and then please relogin.');
            dialog.setContent(str);
        },
        success: function() {},
        error: function() {}
    };
    loadAjax(url, data, params);
}

