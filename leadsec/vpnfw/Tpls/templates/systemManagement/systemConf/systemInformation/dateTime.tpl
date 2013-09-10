<form action="/index.php?R=systemManagement/systemConf/systemInformation/dateTime/setServerTime" method="POST" id="setServerTimeForm"
onSubmit="return false;">
  <table class="column_95">
  <caption>
  日期时间
  </caption>
  <tbody>
    <tr>
      <td width="250" class="tdheader">设备时间:</td>
      <td class="tdbody"><label id="server"></label>
    </tr>
    <tr>
      <td class="tdheader">主机时间:</td>
      <td class="tdbody"><label id="client"></label>
      <input type = "hidden" name = "localTime" id ="localTime" value = ""/>
      <button class="inputbtn standard" type="button" id="setServerTimeBtn" onClick="setServerTime()">
      时间同步
      </button>
      </td>
    </tr>
   </tbody>
</table>
</form>

<form action="/index.php?R=systemManagement/systemConf/systemInformation/dateTime/setTimezone" method="POST" id="setTimezoneForm"
    onSubmit='return false;'>
<table class="column_95">
    <caption>
    时区设置
    </caption>
    <tbody>
        <tr>
          <td width="250" class="tdheader">时区:</td>
          <td class="tdbody">
			<!--
            <input class="width150" type="text" name="ip" id="serverip" value="<{$initData['nip']}>"/>
			-->
			<select name="timezone" class="select" style="width:150px;height:20px;">
			<{html_options options=$initData['timezoneList'] selected=$initData['curTimezone']}>
			</select>

				
                <button class="inputbtn standard" type="button" id="setTimezoneBtn" onClick="setTimezone()">
                确定</button>			
          </td>
        </tr>
		<!--
        <tr>
            <td>&nbsp;</td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button" id="setTimezoneBtn" onClick="setTimezone()">
                确定</button>
            </td>
        </tr>
		-->
    </tbody>
</table>
</form>

<form action="/index.php?R=systemManagement/systemConf/systemInformation/dateTime/setNTPServer" method="POST" id="syncTimeForm"
    onSubmit='return false;'>
<table class="column_95">
    <caption>
    时钟服务器
    </caption>
    <tbody>
        <tr>
          <td width="250" class="tdheader">开启时钟服务器:</td>
          <td class="tdbody">
			<input type="checkbox" name="switchNTP" id="serverchk" 
			    <{if $initData['type'] eq 'on'}>
					checked="checked"
				<{/if}>
			/>
          </td>
        </tr>
        <tr>
          <td class="tdheader">IP设置:</td>
          <td class="tdbody">
			<input class="radio" type="radio" name="radio_chk" id="radio_ip" <{if !empty($initData['nip'])||(empty($initData['nip']) && empty($initData['ndn']))}> checked <{/if}>value="ip"/>
            <input class="width150" type="text" name="ip" id="serverip" value="<{$initData['nip']}>"<{if empty($initData['nip'])}> disabled <{/if}>/>
			<{if !empty($initData['nip'])}>
            <button class="inputbtn standard" type="button" id="syncBtn" onClick="syncTime()">立即同步</button>
			<{/if}>
          </td>
        </tr>
        <tr>
          <td class="tdheader">域名设置:</td>
          <td class="tdbody">
			<input class="radio" type="radio" name="radio_chk" id="radio_dn" <{if !empty($initData['ndn'])}>checked<{/if}> value="dn"/>
            <input class="width150" type="text" name="dn" id="serverdn" value="<{$initData['ndn']}>"<{if empty($initData['ndn'])}>disabled<{/if}> />
			<{if !empty($initData['ndn'])}>
            <button class="inputbtn standard" type="button" id="syncBtn" onClick="syncTime()">立即同步</button>
			<{/if}>			
          </td>
        </tr>
        <tr>
          <td class="tdheader">同步间隔(单位:分钟):</td>
          <td class="tdbody">
			<div style="width:25px;height:20px;border:0px;float:left;">&nbsp;</div>
            <input class="width150" type="text" name="ntpSyncInterval" id="ntpSyncInterval" value="<{$initData['interval']}>"/>
         </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="tdbody">
				<div style="width:20px;height:20px;border:0px;float:left;">&nbsp;</div>
                <button class="inputbtn standard" type="button" id="setNTPBtn" onClick="setNTPServer()">
                确定</button>
            </td>
        </tr>
    </tbody>
</table>
</form>
<script type="text/javascript" src="Public/js/systemManagement/systemConf/systemInformation/time.js"></script>
<script type="text/javascript">
var oldServerTime = '';
$(document).ready(function() {
    renderStandardUi();
    oldServerTime = displayTime($("#server"), <{$initData['serverTime']*1000}>);
    displayTime($("#client"));
    displayTime($("#localTime"));
    validateForm($("#syncTimeForm"));
	
    //与管理主机同步
	$("#setsame1").click(function(){
			alert("时间同步");				  
	});
	
	//将表单中各项设为禁用状态，当时钟服务器处于未开启状态时调用
	function disableAll() {
		$("#serverip").attr("disabled","disabled");
		$("#serverdn").attr("disabled","disabled");
		$("#radio_ip").attr("disabled","disabled");
		$('.radio').attr("disabled","disabled");
		
		$("#syncBtn").attr("disabled","disabled").addClass("ui-button-disabled ui-state-disabled");
		$("#ntpSyncInterval").attr("disabled","disabled");
		//$("#setNTP").attr("disabled","disabled").addClass("ui-button-disabled ui-state-disabled");		
	}
	
	//启用各表单项和按钮
	function enableAll() {
		if($("#radio_ip").attr('checked')){
			$("#serverip").removeAttr("disabled");
		}else{
			$("#serverdn").removeAttr("disabled");
		}
		$("#radio_ip").removeAttr("disabled");
		$("#radio_dn").removeAttr("disabled");
		$('.radio').removeAttr("disabled");
		$("#syncBtn").removeAttr("disabled").removeClass("ui-button-disabled ui-state-disabled");
		$("#ntpSyncInterval").removeAttr("disabled");
		//$("#setNTP").removeAttr("disabled").removeClass("ui-button-disabled ui-state-disabled");	
	}
		
	//如果开启时钟服务器没有被选中，将其下的表单和按钮全部禁用
	if(!$("#serverchk").attr("checked")){
		disableAll();
	}
	
	//点击’开启时钟服务器选框时‘
	$("#serverchk").click(function(){
		if($(this).attr("checked")){	//如果是选中的将表单项启用
			enableAll();
		}else{							//如果没有选中将各表单禁用
			disableAll();
		}					   
	});

	$('.radio').bind('load click',function(){
		if($(this).attr('id')=='radio_ip'){
			if($('#syncBtn').prev().attr('id')!='serverip') {
				$('#syncBtn').clone(true).insertAfter('#serverip');
				$('#serverdn').parent().find('button').remove();
			}
			$("#serverip").removeAttr("disabled");
			$("#serverdn").attr("disabled","disabled");			
		}else if($(this).attr('id')=='radio_dn'){
			if($('#syncBtn').prev().attr('id')!='serverdn') {
				$('#syncBtn').clone(true).insertAfter('#serverdn');
				$('#serverip').parent().find('button').remove();
			}
			$("#serverip").attr("disabled","disabled");
			$("#serverdn").removeAttr("disabled");			
		}
	});
	
	/*
	//选择单选框时
	$(".radio").click(function(){
		if($(this).attr('id')=='radio_ip'){
			$("#serverip").removeAttr("disabled");
			$("#serverdn").attr("disabled","disabled");
		}else if($(this).attr('id')=='radio_dn'){
			$("#serverip").attr("disabled","disabled");
			$("#serverdn").removeAttr("disabled");
		}
	
	});
	*/
});
</script>
