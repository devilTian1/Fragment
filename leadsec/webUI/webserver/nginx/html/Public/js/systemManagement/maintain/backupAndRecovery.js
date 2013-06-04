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

function restore() {
    submitForm($('#restoreForm'));
}

function restoreDialog() {
	var dialog  = loadingScreen('恢复出厂配置');
    var buttons = {};
    buttons['确定'] = function() {
        restore()
        $(this).remove();
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


