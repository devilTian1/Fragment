function checkBoxCtrl(){
	if($("#autoUpEnable").attr("checked") == "checked")
	{
		$("input[name='upType']").removeAttr("disabled");
		$("#upAddr").removeAttr("disabled");
		$("#upPort").removeAttr("disabled");
	}
	else{
		$("input[name='upType']").attr("disabled",'disabled');
		$("#upAddr").attr("disabled",'disabled');
		$("#upPort").attr("disabled",'disabled');
	}
	upTypeCtrl();
}

function upTypeCtrl(){
	if($("input[name='upType']").attr("disabled") == "disabled")
	{
		$("input[name='upWay']").attr("disabled",'disabled');
	}
	else
	{
		if($("input[name='upType']:checked").val() == '1')
		{		
			$("input[name='upWay']").attr("disabled",'disabled');		
		}
		else
		{
			$("input[name='upWay']").removeAttr("disabled");
		}
	}
	upWayTimeCtrl();
}

function upWayTimeCtrl(){
	if($("input[name='upWay']").attr("disabled") == "disabled")
	{
		$("#selectLengthList").attr("disabled",'disabled');
		$("#selectTimeList").attr("disabled",'disabled');
		$("#selectDayList").attr("disabled",'disabled');
		$("#selectHourList").attr("disabled",'disabled');
	}
	else
	{
		if($("input[name='upWay']:checked").val() == "1")
		{
			$("#selectLengthList").removeAttr("disabled");
			$("#selectTimeList").attr("disabled",'disabled');
			$("#selectDayList").attr("disabled",'disabled');
			$("#selectHourList").attr("disabled",'disabled');
		}
		else if($("input[name='upWay']:checked").val() == "2")
		{
			$("#selectLengthList").attr("disabled",'disabled');
			$("#selectTimeList").removeAttr("disabled");
			$("#selectDayList").attr("disabled",'disabled');
			$("#selectHourList").attr("disabled",'disabled');
		}
		else if($("input[name='upWay']:checked").val() == "3")
		{
			$("#selectLengthList").attr("disabled",'disabled');
			$("#selectTimeList").attr("disabled",'disabled');
			$("#selectDayList").removeAttr("disabled");
			$("#selectHourList").removeAttr("disabled");
		}
	}
}
function submitUpForm(form){	
    if(form.valid())
    {
        var dialog = loadingScreen('结果');
        var buttons = {};
        buttons['关闭'] = function() {
            dialog.close();
        };
        var dialogParamsDisable = {
            width : 250,
            height: 170,
            closeOnEscape: false,
            position : jQuery.getDialogPosition('250','170')
        };
        var dialogParamsEnable = {
            width : 250,
            height: 170,
            buttons : buttons,
            closeOnEscape: true,
            position : jQuery.getDialogPosition('250','170')
        };
        dialog.setOptions(dialogParamsDisable);
        $(".ui-dialog-titlebar-close").hide();
        var successCallback = function(result, textStatus) {
            dialog.setContent(result.msg);
            dialog.setOptions(dialogParamsEnable);
            $(".ui-dialog-titlebar-close").show();            
        };
        var dialog_c =ajaxSubmitForm(form, '结果',successCallback);
        dialog_c.close();
    }
}

function upVirusForm(){
	//$("#autoUpEnable").addClass("ignore");
	$("#flgUpNow").attr("value",'0');
	submitUpForm($("#autoUpSetForm"));
}

function upNowForm(){
	//$("#autoUpEnable").removeClass("ignore");
	if($("#autoUpEnable").attr("checked") != "checked")
	{
		var errorStr = "<li><label class=\"errorContainer\" for=\"autoUpEnable\" generated=\"true\" style=\"display: block;\">未启用自动升级.</label></li>";
		if($("label[for='autoUpEnable']").html() == "未启用自动升级.")
		{
			$("label[for='autoUpEnable']").parent().attr("style",'display:list-item;');
			$("label[for='autoUpEnable']").attr("style",'display:block');
		}
		else
			$("#errDiv").append(errorStr);
		$("#errDiv").attr("style",'display:block');
	}
	else
	{
		$("#flgUpNow").attr("value",'1');
		submitUpForm($("#autoUpSetForm"));
	}	
}

function updateManual(){
	submitUpForm($('#updateManualForm'));
}
