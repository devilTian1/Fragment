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

function importConfigFile() {
	var form = $('#importFileForm');
	var successCallback = function(result, textStatus) {
		var content = result.msg;
		if (content==='0') {
			showErrorDialog('配置文件格式错误');
		} else {
			var dialog  = loadingScreen('导入配置文件');
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
		}
	};
	if (form.valid()) {
		var dialogcmd = ajaxSubmitForm(form, '结果',successCallback);
		dialogcmd.close();
	}  
}

function restore() {
    submitForm($('#restoreForm'));
}

function save(){
    submitForm($('#saveForm'));
}


