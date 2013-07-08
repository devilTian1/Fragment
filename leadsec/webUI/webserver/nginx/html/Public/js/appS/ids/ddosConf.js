function setDdosServiceForm() {
	if ($("#stopService").val()=='enable') {
    	var title  = '启动服务';
	} else {
		var title  = '停止服务';
	}
	var buttons = {};
	buttons[getMessage('Ok')] = function() {    	
        resultDialog.close();
    }
    var afterSuccessCallback = function(result, textStatus) {
        if (result.status == '0') { 
            if ($("#stopService").val() == 'disable') {   
                $("#stopService").val('enable');
                $("button[name='buttonOff']").attr("disabled",'disabled');
                $("button[name='buttonOff']").addClass("ui-button-disabled");
                $("button[name='buttonOff']").addClass("ui-state-disabled");
                $("button[name='buttonOn']").removeClass("ui-button-disabled");
                $("button[name='buttonOn']").removeClass("ui-state-disabled");
                $("button[name='buttonOn']").removeAttr("disabled");
                $("#status").html('停止');
            } else {
                $("#stopService").val('disable');
                $("button[name='buttonOn']").attr("disabled",'disabled');
                $("button[name='buttonOff']").removeAttr("disabled");
                $("button[name='buttonOn']").addClass("ui-button-disabled");
                $("button[name='buttonOn']").addClass("ui-state-disabled");
                $("button[name='buttonOff']").removeClass("ui-button-disabled");
                $("button[name='buttonOff']").removeClass("ui-state-disabled");
                $("#status").html('启动');
            }
        }       
    };
	ajaxSubmitForm($('#setDdosConfForm'), '结果',undefined,
		undefined,afterSuccessCallback);
	$(this).remove();
}
