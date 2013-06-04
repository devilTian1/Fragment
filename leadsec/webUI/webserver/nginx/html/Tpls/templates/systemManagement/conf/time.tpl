<form action="Function/systemManagement/conf/time.php" method="POST" id="setServerTimeForm"
onSubmit="return false;">
  <table class="column_95">
  <caption>
  日期时间
  </caption>
  <tbody>
    <tr>
      <td width="250" class="tdheader"><{$smarty.const.PRODUCT_NAME}>当前时间:</td>
      <td class="tdbody"><label id="server"></label>
    </tr>
    <tr>
      <td class="tdheader">管理主机当前时间:</td>
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

<form action="Function/systemManagement/conf/time.php?c=1" method="POST" id="syncTimeForm"
    onSubmit='return false;'>
<table class="column_95">
    <caption>
    时钟服务器
    </caption>
    <tbody>
        <tr>
          <td width="250" class="tdheader">启用时钟服务器:</td>
          <td class="tdbody">
			<input type="checkbox" name="switchNTP" id="serverchk" 
			    <{if $type eq 'on'}>
					checked="checked"
				<{/if}>
			/>
          </td>
        </tr>
        <tr>
          <td class="tdheader">时钟服务器 IP:</td>
          <td class="tdbody">
            <input class="width150" type="text" name="ip" id="serverip" value="<{$nip}>"/>
            <button class="inputbtn standard" type="button" id="syncBtn" onClick="syncTime()">
                立即同步</button>
          </td>
        </tr>
        <tr>
          <td class="tdheader">同步周期(单位:分钟):</td>
          <td class="tdbody">
            <input class="width150" type="text" name="ntpSyncInterval" id="ntpSyncInterval" value="<{$interval}>"/>
         </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button" id="setNTPBtn" onClick="setNTPServer()">
                确定</button>
            </td>
        </tr>
    </tbody>
</table>
</form>
<script type="text/javascript" src="Public/js/systemManagement/conf/time.js"></script>
<script type="text/javascript">
var oldServerTime = '';
$(document).ready(function() {
    renderStandardUi();
    oldServerTime = displayTime($("#server"), <{$smarty.now*1000}>);
    displayTime($("#client"));
    displayTime($("#localTime"));
    validateForm($("#syncTimeForm"));
	
    //与管理主机同步
	$("#setsame1").click(function(){
			alert("时间同步");				  
	});

	if(!$("#serverchk").attr("checked")){
		$("#serverip").attr("disabled","disabled");
		$("#syncBtn").attr("disabled","disabled").addClass("ui-button-disabled ui-state-disabled");
		$("#ntpSyncInterval").attr("disabled","disabled");
		//$("#setNTP").attr("disabled","disabled").addClass("ui-button-disabled ui-state-disabled");
	}
	$("#serverchk").click(function(){
		if($(this).attr("checked")){
			$("#serverip").removeAttr("disabled");
			$("#syncBtn").removeAttr("disabled").removeClass("ui-button-disabled ui-state-disabled");
			$("#ntpSyncInterval").removeAttr("disabled");
			//$("#setNTP").removeAttr("disabled").removeClass("ui-button-disabled ui-state-disabled");
		}else{
			$("#serverip").attr("disabled","disabled");
			$("#syncBtn").attr("disabled","disabled").addClass("ui-button-disabled ui-state-disabled");
			$("#ntpSyncInterval").attr("disabled","disabled");
			//$("#setNTP").attr("disabled","disabled").addClass("ui-button-disabled ui-state-disabled");
		}					   
	})
});
</script>
