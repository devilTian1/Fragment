function selectAll(){
	var obj = document.getElementById("iplist");	
	if(obj)
	{
		var length = obj.length;
		
		for(var i=0; i<length ; i++)
		{
			obj.options[i].selected = true;
		}
	}
}

function setSnmpForm(){
	if ($('#setSnmpForm').valid()) {
		selectAll();
	    ajaxSubmitForm($('#setSnmpForm'), '结果');
	}
}


function setServiceForm(action) {
	var resultDialog  = loadingScreen('结果');
	var buttons = {};
    	buttons['Ok'] = function() {    	
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

    var dialog = ajaxSubmitForm($('#SnmpStatusForm'), '服务启停',successCallback);
    dialog.close();
}

