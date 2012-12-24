function show() {
	var data = {
		action : 'getStr'
    };
	loadEmbedPage("Function/systemManagement/maintain/batchTool.php",data,$('#textareaA'), {dataType: 'JSON'});
}



function exportBatchToolFile() {
	var form = $('#batchToolExportForm');
	var successCallback = function(result, textStatus) {
	    var content = result.msg;
        $('#textareaB').val(content);
		$("#rewrite").removeAttr("disabled").css('color', '#000000');
	};
	if (form.valid()) {
        var dialog = ajaxSubmitForm(form, '结果', successCallback);
		dialog.close();
    }
}

function cleanUp() {	
	var data = {
		action : 'empty'
	};
	loadEmbedPage("Function/systemManagement/maintain/batchTool.php", data, $('#textareaA'), {dataType: 'JSON'});
}

function reWrite() {
	$('#textareaB').val('');
}


function ModifyStyle() {
	var mytt  = $("#textareaB");
	var mybtn = $("#rewrite");
	var mybtnn = $("#upload");
	if (mytt.val() != '') {
		mybtn.removeAttr("disabled").css('color', '#000000');
		mybtnn.removeAttr("disabled").css('color', '#000000');
	} else {
		mybtn.attr("disabled","disabled").css('color', '#CCCCCC');
		mybtnn.attr("disabled","disabled").css('color', '#CCCCCC');
	}
}



function runBatchCmd() {
	var successCallback = function(result, textStatus) {
		ajaxSubmitForm($('#runBatchCmdForm'), '结果');
		ajaxSubmitForm($('#runBatchCmdForm'), '结果').close();
	};
    var dialog  = loadingScreen('命令批处理');
    var buttons = {};
    buttons['确定'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>命令批处理文件已提交，请点击'执行批处理'按钮！</p>");
    dialog.setOptions(dialogParams);   
	
}

