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
function submitUpForm(){
	if($("#autoUpSetForm").valid())
	{
		ajaxSubmitForm($('#autoUpSetForm'), '结果');
	}
}

function upVirusForm(){
	$("#flgUpNow").attr("value",'0');
	submitUpForm();
}

function upNowForm(){
	$("#flgUpNow").attr("value",'1');
	alert($("#flgUpNow").val());
	submitUpForm();
}
