function switchEncrypt() {
    if ($('#encryption').attr('checked') === 'checked') {
	$('#switch').val('on');
    } else {
	$('#switch').val('off');
    }
}

function submitForm(form) {
    if (form.valid()) {
        ajaxSubmitForm(form, '结果');
    }
}

/*
function getUploadFileName(filepath) {
	var filepath = Trim(filepath);
	if (filepath =='ngconfig_in'||filepath =='ngconfig_out') {
		return true;
	} else if (filepath ==''){
		return 'empty';
	} else {
		return false;
	}
}
*/

//去除首尾空格
function Trim(str){
	return str.replace(/^\s*(.*?)[\s\n]*$/g,'$1');
}

function importConfigFile() {
	var form = $('#importFileForm');
	/*
	var file = Trim($("input[name='importFile']").val());
	var stag = file.lastIndexOf('\\');
	// for IE,chorm 
	if (stag>0){
		var substr_stag = stag + 1;
		var filepath = file.substr(substr_stag);
	} else {
		var filepath = file;	
	}*/
	var successCallback = function(result, textStatus) {
	var content = result.msg;
		var dialog  = loadingScreen('导入配置文件');
		var buttons = {};
			buttons['确定'] = function() {
				$(this).remove();
			};
		var dialogParams = {
				width: 200,
				height: 200,
				buttons: buttons
			};
			dialog.setContent(content);
			dialog.setOptions(dialogParams); 
	};
	if (form.valid()) {
		var dialogcmd = ajaxSubmitForm(form, '结果',successCallback);
		dialogcmd.close();
	}
}


function restoreDialog() {
	var dialog  = loadingScreen('恢复出厂配置');
    var buttons = {};
    buttons['确定'] = function() {
		//点击确定下发恢复出厂配置命令
		$(this).remove();
		var url    = 'Function/systemManagement/maintain/backupAndRecovery.php';
		var data   = {restore : 1};
		var params = {
        type : 'GET',
		dataType: 'json',
        success: function(result) {
			var dialog_restore = loadingScreen('恢复出厂配置');
			dialog_restore.dialog('moveToTop');
			dialog_restore.setContent(result.msg);
			var buttons = {};
			if (result.status == 0) {
				buttons[getMessage('Ok')] = function() {
					dialog_restore.close();
					reboot();
				};
				buttons[getMessage('Cancel')] = function() {
					dialog_restore.close();
				};
			} else {
				buttons[getMessage('Cancel')] = function() {
					dialog_restore.close();
				};
			}
			dialog_restore.setOptions({
				width : 250,
				height: 170,
				buttons: buttons
			});
		}
	};
    loadAjax(url, data, params);
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 200,
        buttons: buttons
    };
    dialog.setContent("<p>如果操作此步骤你所做的配置都会丢失！</p>");
    dialog.setOptions(dialogParams);
}

function save(){
    submitForm($('#saveForm'));
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
    var url    = 'Function/systemManagement/maintain/backupAndRecovery.php';
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
