function switchService(name, action,formId) {
    var title   = '启动/停止服务';
    var dialog  = loadingScreen(title);
    var successCallback = function(result, textStatus) {
        var resultDialog  = loadingScreen(title);
        var buttons = {};
        buttons['Ok'] = function() {
        	resultDialog.close();
        }
        resultDialog.setOptions({
            width : 250,
            height: 170,
            buttons: buttons
        });
        var content = result.msg;         
        resultDialog.setContent($('<p>' + content + '</p>'));        
        if (result.status =='0') { 
        	if ($('#action_' + formId).val() =='disable') {   
        		$('#img_' + formId).attr("src","Public/default/images/icon/stop.png");
        		$('#action_' + formId).attr("value","enable");
        	}else {
        		$('#img_' + formId).attr("src","Public/default/images/icon/select.png");
        		$('#action_' + formId).attr("value","disable");
        	}	 
    	}    		
    }
    var buttons = {};   
    buttons['确定'] = function() { 
        var returnDialog = 
            ajaxSubmitForm($('#switchServiceForm_' + formId), '结果',
        	    successCallback);
        returnDialog.close();
        $(this).remove();
    };
    buttons['取消'] = function() {
        $(this).remove();
    };    
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    var str = $('#action_' + formId).val() === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '服务[' + name  + ']吗?</p>');
    dialog.setOptions(dialogParams);
}
