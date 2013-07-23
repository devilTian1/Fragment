function show() {
    var intvalSec = 5;
    var displayDom = $('#textareaA');
	var data = {
		action : 'getStr'
    };
    var ajaxParams = {
        dataType: 'JSON',
        beforeSend: function() {
            if (displayDom.get(0) === undefined) {
                return false;
            }
        },
        complete: function () {
            setTimeout(function() {
                show();
            }, intvalSec * 1000);
        }
    };
	loadEmbedPage("Function/systemManagement/maintain/batchTool.php",data,$('#textareaA'), {dataType: 'JSON'});
}



function exportBatchToolFile() {
	var form = $('#batchToolExportForm');
	var successCallback = function(result, textStatus) {
	    var content = result.msg;
        $('#textareaB').val(content);
		$("#rewrite").removeAttr("disabled").css('color', '#000000');
		$("#upload").removeAttr("disabled").css('color', '#000000');
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


	};
	if (form.valid()) {
        var dialog = ajaxSubmitForm(form, '结果', successCallback);
		dialog.close();
    }
}

function cleanUp() {
	var url = "Function/systemManagement/maintain/batchTool.php";
	var data = {
		action : 'empty'
	};
	var params ={
		type  : "POST",
		success: function() {
			$('#textareaA').html(''); 
		}
	};
	loadAjax(url, data, params);
}

function reWrite() {
	$('#textareaB').val('');
	$("#rewrite").attr("disabled","disabled").css('color', '#CCCCCC');
	$("#upload").attr("disabled","disabled").css('color', '#CCCCCC');
}


function ModifyStyle() {
	var mytt  = $("#textareaB");
	var mybtn = $("#rewrite");
	var mybtnUpload = $("#upload");
	if (mytt.val() != '') {
		mybtn.removeAttr("disabled").css('color', '#000000');
		mybtnUpload.removeAttr("disabled").css('color', '#000000');
	} else {
		mybtn.attr("disabled","disabled").css('color', '#CCCCCC');
		mybtnUpload.attr("disabled","disabled").css('color', '#CCCCCC');
	}
}



function runBatchCmd() {
	var form = $('#runBatchCmdForm');
	if (form.valid()) {
		var afterSuccessCallback = function(result, textStatus) {
			var content = result.msg;
			dialog.setContent(content);
		};	
	ajaxSubmitForm(form, '结果', undefined,undefined, afterSuccessCallback);
	$(this).remove();	
    }
}



function performBatchProcessingForm() {
	var form = $('#performBatchProcessingForm');
	ajaxSubmitForm(form, '结果');
}

