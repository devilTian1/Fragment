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
	var data = {
		action : 'empty'
	};
	loadEmbedPage("Function/systemManagement/maintain/batchTool.php", data, $('#textareaA'), {dataType: 'JSON'});
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
	var successCallback = function(result, textStatus) {
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
	};
     
	if (form.valid()) {
        var dialogbatcmd = ajaxSubmitForm(form, '结果', successCallback);
		dialogbatcmd.close();
    }
	
}



function performBatchProcessingForm() {
	var form = $('#performBatchProcessingForm');
	var successCallback = function(result, textStatus) {
		var content = result.msg;
		var dialog  = loadingScreen('命令批处理');
		var buttons = {};
		buttons['确定'] = function() {
			$(this).remove();
		};
		var dialogParams = {
			width: 400,
			height: 400,
			buttons: buttons
		};
		var numcmd = content.length;
		var i ;
		var result = '';
		for (i=1; i < numcmd; i++){
			result += content[i] + '<br/>';
		}
		dialog.setContent(result+'<br/>'+"<p>一共执行了"+content[0]+"条命令</p>");
		dialog.setOptions(dialogParams); 
		renderStandardUi();
	};
     
	if (form.valid()) {
        var dialogbatcmd = ajaxSubmitForm(form, '结果', successCallback);
		dialogbatcmd.close();
    }

}

