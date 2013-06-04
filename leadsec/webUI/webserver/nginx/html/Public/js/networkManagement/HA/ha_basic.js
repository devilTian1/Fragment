function setHaForm(){
	if ($('#HaBasicForm').valid()) {
	    ajaxSubmitForm($('#HaBasicForm'), '结果');
	}
}

function setServiceForm(action) {
	var resultDialog  = loadingScreen('结果');
	var buttons = {};
    	buttons[getMessage('Ok')] = function() {    	
        resultDialog.close();
    }
    resultDialog.setOptions({
        width : 250,
        height: 170,
        buttons: buttons
    });
    var successCallback = function(result, textStatus) {
        if (result.status !== -1) { 
            if (action == 'on') {   
                $("#switch").val('off');
                $("button[name='buttonOff']").button({ disabled: false});
                $("button[name='buttonOn']").button({ disabled: true});
                $("#status").html('启动');
            } else {
                $("#switch").val('on');
                $("button[name='buttonOff']").button({ disabled: true});
                $("button[name='buttonOn']").button({ disabled: false});
                $("#status").html('停止');
            }
        }
        resultDialog.setContent($('<p>' + result.msg + '</p>'));        
    };

    var dialog = ajaxSubmitForm($('#HaStatusForm'), '服务启停', successCallback);
    dialog.close();
}

function changeWorkMode() {
	var val = $("input:radio[id^='work_mode_']:checked").val();
	if (val == 'P') {
		$("#ifcfg_D").attr("disabled",'disabled');
	} else {
		$("#ifcfg_D").removeAttr("disabled",'disabled');
	}
}