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
		ajaxSubmitForm(form, '结果');
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
