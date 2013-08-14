//调整显示位置以及聚焦
function setFocusToEntryBox() {	
	$("#entryBox").focus();
    $("#entryBox").val($('#commandContainer').html());
    var sheight = $("#consolept").get(0).scrollHeight+200;
	$("#consolept").scrollTop(sheight);
}
//检查命令行合法性
function filterParam(cmd){
	var cmdstr = $.trim(cmd);
	var cmdarr = cmdstr.split(/\s+/);
	var rs = "";
	var command = $('#commandPrompt').html();
	switch(cmdarr[0]){
	case "ping":
		if(cmdarr.length != 2)
		{
			rs = "error";
		}
		else if(checkPingParam(cmdarr[1]))
		{
			cmdstr = cmdarr[0]+" "+cmdarr[1];
			sendMessages(cmdstr);
		}
		else
		{
			showInforDialog("ip不合法");
			var tmpstr = command+'ac:\>'; 
			$('#commandPrompt').html(tmpstr); 
		}
		break;
	case "traceroute":
		if(cmdarr.length != 2)
		{
			rs = "error";
		}
		else if(checkTracerouteParam(cmdarr[1]))
		{
			cmdstr = cmdarr[0]+" "+cmdarr[1];
			sendMessages(cmdstr);
		}
		else
		{
			showInforDialog("ip不合法");
			var tmpstr = command+'ac:\>'; 
			$('#commandPrompt').html(tmpstr); 
		}
		break;
	case "tcpdump":
		if(cmdarr.length != 2)
		{
			rs = "error";
		}
		else
		{
			cmdstr = cmdarr[0]+" "+cmdarr[1];
			sendMessages(cmdstr);
		}
		break;
	case "arp":
		if(cmdarr.length != 1)
		{
			rs = "error";
		}
		else
		{
			sendMessages(cmdstr);
		}
		break;
	case "routeshow":
		if(cmdarr.length != 1)
		{
			rs = "error";
		}
		else
		{
			sendMessages(cmdstr);
		}
		break;
	case "cls":
		if(cmdarr.length != 1)
		{
			rs = "error";
		}
		else
		{
			sendMessages(cmdstr);
		}
		break;
	default:
		rs = "error";
	    break;
    }
	if(rs == "error")
	{
		showInforDialog("用户只可输入的命令：<br/>ping ip<br/>traceroute ip<br/>tcpdump fex<br/>arp<br/>routeshow");
		var tmpstr = command+'ac:\>'; 
		$('#commandPrompt').html(tmpstr); 
	}
}
//检查ping命令参数合法性
function checkPingParam(pingp){
	var perlipv6regex = "^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$";
	var perlipv4regex = '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$';
	//var hostnameregex = "^(?=.{1,255}$)[0-9A-Za-z](?:(?:[0-9A-Za-z]|\\b-){0,61}[0-9A-Za-z])?(?:\\.[0-9A-Za-z](?:(?:[0-9A-Za-z]|\\b-){0,61}[0-9A-Za-z])?)*\\.?$";
	var ipv4regex = new RegExp(perlipv4regex);
    var ipv6regex = new RegExp(perlipv6regex);
    //var hnregex = new RegExp(hostnameregex);
    return ipv4regex.test(pingp) || ipv6regex.test(pingp);
}
//检查traceroute命令参数合法性
function checkTracerouteParam(traceroutep){
	var perlipv6regex = "^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$";
	var perlipv4regex = '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$';
	var ipv4regex = new RegExp(perlipv4regex);
    var ipv6regex = new RegExp(perlipv6regex);
    return ipv4regex.test(traceroutep) || ipv6regex.test(traceroutep);
}
//向后台发送处理结果数据
function sendMessages(cmd){
	if(cmd == "cls"){
		$('#commandPrompt').html('ac:\>');
		setFocusToEntryBox();
    }else{
    	$('#entryBox').val('');
		$.post("Function/statMonitor/test/test.php", {cmd: cmd},
		   function(result){
			processRequest(result.msg);
		   },"json");
	   }
}
//处理结果
function processRequest(cmdstr){
	var command = $('#commandPrompt').html();
	if(cmdstr[0] == "tcpdumperror1")
	{
		showInforDialog("设备名称不合法");
		var tmpstr = command+'ac:\>'; 
		$('#commandPrompt').html(tmpstr); 
	}
	else if(cmdstr[0] == "tcpdumperror2")
	{
		showInforDialog("设备未启动");
		var tmpstr = command+'ac:\>'; 
		$('#commandPrompt').html(tmpstr); 
	}
	else if(cmdstr[0] == "tcpdumperror3")
	{
		showInforDialog("设备类型不支持该命令");
		var tmpstr = command+'ac:\>'; 
		$('#commandPrompt').html(tmpstr); 
	}
	else
	{
		 var rem='';
		 if(typeof(cmdstr) === "object")
	     {
			 for(var i = 0;i < cmdstr.length;i++)
			 {
			     if($.browser.mozilla){
			    	 rem+=(cmdstr[i].split(' ')).join('&nbsp;')+'<br/>';
			     }else{
			    	 rem+=(cmdstr[i].split(' ')).join('&nbsp;&nbsp;')+'<br/>';
			     }
				 
			 } 
	     }
		 else
		 {
			 if(cmdstr.indexOf("Error Cmd") != -1){
				 var errorinfo = cmdstr.split(']');
				 rem = errorinfo[1]+'<br/>';
			 }else{
				 rem = cmdstr+'<br/>';
			 }			 
		 }
		 var tmpstr = command+rem+'ac:\>'; 
		 $('#commandPrompt').html(tmpstr); 
	}	     
	setFocusToEntryBox();
}

function showInforDialog(msg) {
    //var dialog = loadingScreen(getMessage('错误'));
	var dialog = StandardUiFactory.createDialog(getMessage('错误'));
    var buttons = {};
    buttons[getMessage('关闭')] = function() {
        dialog.dialog('close');
    };    
    dialog.setOptions({
    	width : 300,
        height: 250,
    	buttons : buttons,
    	position : jQuery.getDialogPosition('300','250'),
        close: function(event, ui) {
            $(this).dialog('destroy');
            $(this).remove();
            setFocusToEntryBox();
        }
    });
    dialog.setContent(msg);
    dialog.open();
    dialog.dialog('option','buttons').focus();
    return false;
    //return dialog;
}
