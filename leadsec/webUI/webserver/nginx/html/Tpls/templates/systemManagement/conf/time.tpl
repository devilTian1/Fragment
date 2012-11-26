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
<table class="column_95">
  <caption>
  时钟服务器
  </caption>
  <tbody>
    <tr>
      <td width="250" class="tdheader">启用时钟服务器:</td>
      <td class="tdbody">
      <input type="checkbox" id="serverchk" />
      </td>
    </tr>
    <tr>
      <td class="tdheader">时钟服务器 IP:</td>
      <td class="tdbody">
      <form action="" method="POST" name="form1" id="form1">
          <input type="text" name="ip" id="serverip" value=""/>
          <button class="inputbtn standard" type="button" id="syncBtn" onClick="syncTime()">
          立即同步</button>
      </form>
      </td>
    </tr>
    <tr>
      <td class="tdheader">每隔:</td>
      <td class="tdbody">
        <input type="text" name="servertime" id="servertime" value="5" style="width:50px"/>
     分钟同步一次 ( 范围: 1-65535 默认: 5 分钟 )</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td class="tdbody"><input name="input" type="button"  value="确定" id="setsure" class="button" /></td>
    </tr>
   </tbody>
</table>
<script type="text/javascript" src="Public/js/systemManagement/conf/time.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    displayTime($("#server"), <{$smarty.now*1000}>);
    displayTime($("#client"));
    displayTime($("#localTime"));
    validateForm($("#form1"));
    $(".button").button();
	//$("#serverip").tooltip();
/*	$.formValidator.initConfig({formID:"form1",mode:'SingleTip',onError:function(){alert("校验没有通过，具体错误请看错误提示")}});
	$("#serverip").formValidator({onShow:"请输入ip4",onfocus:"例如：172.16.201.18",onCorrect:"谢谢你的合作，你的ip4正确"}).regexValidator({regExp:"ip4",dataType:"enum",onError:"ip4格式不正确"});*/
	//与管理主机同步
	$("#setsame1").click(function(){
			alert("时间同步");				  
	  });

	if(!$("#serverchk").attr("checked")){
		$("#serverip").attr("disabled","disabled");
		$("#syncBtn").attr("disabled","disabled").addClass("ui-button-disabled ui-state-disabled");
		$("#servertime").attr("disabled","disabled");
		$("#setsure").attr("disabled","disabled").addClass("ui-button-disabled ui-state-disabled");
	}
	$("#serverchk").click(function(){
		if($(this).attr("checked")){
			$("#serverip").removeAttr("disabled");
			$("#syncBtn").removeAttr("disabled").removeClass("ui-button-disabled ui-state-disabled");
			$("#servertime").removeAttr("disabled");
			$("#setsure").removeAttr("disabled").removeClass("ui-button-disabled ui-state-disabled");
		}else{
			$("#serverip").attr("disabled","disabled");
			$("#syncBtn").attr("disabled","disabled").addClass("ui-button-disabled ui-state-disabled");
			$("#servertime").attr("disabled","disabled");
			$("#setsure").attr("disabled","disabled").addClass("ui-button-disabled ui-state-disabled");
		}					   
	})
});
</script>
