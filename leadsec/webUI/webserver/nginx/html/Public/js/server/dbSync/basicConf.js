function importCACert() {
	var CAcert  = $('#CAcert').val();
	var SIScert = $('#SIScert').val();
	var SISkey  = $('#SISkey').val();
	var userKeyWord = $('#userKeyWord').val();
	var certCommname = $('#certCommname').val();
	if((CAcert==="" || SIScert==="" || SISkey==="") && userKeyWord===""){
		showErrorDialog('三个文件必须同时导入，并且用户密钥口令不能为空！');
	}else if((CAcert==="" || SIScert==="" || SISkey==="") && userKeyWord!==""){
		showErrorDialog('三个文件必须同时导入！');
	}else if((CAcert!=="" && SIScert!=="" && SISkey!=="") && userKeyWord===""){
		showErrorDialog('用户密钥口令不能为空！');
	}else{
			var afterSuccessCallback = function(result, textStatus) {
				if (result.status =='0') {
					freshCertConf();
				}
				$('#fileCertConfForm').resetForm();
			}
			ajaxSubmitForm($('#fileCertConfForm'), '结果', undefined,
				undefined, afterSuccessCallback);
			$(this).remove();
	}	   
}


function del(name,id) {
    var url  = 'Function/server/dbSync/basicConf.php';
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
    if(name==="CA中心证书") {
    	id = "CAcert";
    }else if(name==="用户证书"){
    	id = "SIScert";
    }else if(name==="用户密钥"){
    	id = "SISkey";
    }else {
		id = "certCommname";
	} 
    buttons[getMessage('Ok')] = function() {
        del(name,id);
        $(this).remove();
    };
    buttons[getMessage('Cancel')] = function() {
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


function freshCertConf() {
    var url = 'Function/server/dbSync/basicConf.php';
    freshTable(url, $('#certListTable'));
}