function importCACert() {
	var CAcert  = $('#CAcert').val();
	var SIScert = $('#SIScert').val();
	var SISkey  = $('#SISkey').val();
	var userKeyWord = $('#userKeyWord').val();
	if((CAcert==="" || SIScert==="" || SISkey==="") && userKeyWord===""){
		showErrorDialog('三个文件必须同时导入，并且用户密钥口令不能为空！');
	}else if((CAcert==="" || SIScert==="" || SISkey==="") && userKeyWord!==""){
		showErrorDialog('三个文件必须同时导入！');
	}else if((CAcert!=="" && SIScert!=="" && SISkey!=="") && userKeyWord===""){
		showErrorDialog('用户密钥口令不能为空！');
	}else{
		var resultDialog  = loadingScreen('结果');
	     	var successCallback = function(result, textStatus) {
	            var buttons = {};
	            buttons[getMessage('Ok')] = function() {
		            freshCertConf();
	                resultDialog.close();
	            }
	            resultDialog.setOptions({
	                width : 250,
	                height: 170,
	                buttons: buttons,
	                position: jQuery.getDialogPosition(250,170)
	            });
	            var content = result.msg;         
	            resultDialog.setContent($('<p>' + content + '</p>'));
	            $('#CAcert').attr("value","");
	            $('#SIScert').attr("value","");
	            $('#SISkey').attr("value","");
	            $('#userKeyWord').attr("value","");
	        }
		 var dialog_d = ajaxSubmitForm($('#fileCertConfForm'), '结果',
				 successCallback);
		 dialog_d.close();
	}	   
}

function del(name,id) {
    var url  = 'Function/client/fileSync/basicConf.php';
    var data = {
        delId: id
    };
    var title  = '删除'+ name;
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
    	freshCertConf();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelDialog(name) {
    var dialog  = loadingScreen('删除'+ name);
    var buttons = {};
    if(name==="CA中心证书"){
    	id = "CAcert";
    }else if(name==="用户证书"){
    	id = "SIScert";
    }else {
    	id = "SISkey";
    }
    buttons[getMessage('Ok')] = function() {
        del(name,id);
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除已导入的" + name + "吗?</p>");
    dialog.setOptions(dialogParams);   
}
function importCACert() {
    if ($('#fileCertConfForm').valid()) {
        var url  = 'Function/client/fileSync/basicConf.php';
        var title  = '结果';
	    var dialog = loadingScreen(title);
        dialog.dialog('moveToTop');
	    var buttons = {};
        buttons[getMessage('Ok')] = function() {
	        dialog.close();
	    }
	    dialog.setOptions({
	        width : 250,
            height: 170,
	        buttons: buttons,
	        position: jQuery.getDialogPosition(250,170)
	    });
	    var successResult = function(result, textStatus) {
	        var content = result.msg;
	        dialog.setContent($('<p>' + content + '</p>'));
	        $('#fileCertConfForm').resetForm();
	    }    
	    var dialog_c= ajaxSubmitForm($('#fileCertConfForm'), '结果',successResult);
	    dialog_c.close();          
	}
}
function freshCertConf() {
    var url = 'Function/client/fileSync/basicConf.php';
    freshTable(url, $('#certListTable'));
}