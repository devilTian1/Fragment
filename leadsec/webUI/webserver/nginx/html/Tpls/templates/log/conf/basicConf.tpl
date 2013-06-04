&nbsp;&nbsp;注释：同步日志至对端选项与监听UDP/TCP端口不可同时使用
<form action="Function/log/conf/basicConf.php" method="POST" id="basicConfForm"
    onSubmit='return false;'>
<table class="column_95">
    <caption>
           基本配置
    </caption>
    <tbody>
        <tr>
          <td width="250" class="tdheader">同步日志至对端:</td>
          <td class="tdbody">
              <input class='floatLeft' type="checkbox" name="synLogToEnd" id="synLogToEndChk" 
                  <{if $basic.sendother eq 1}>checked="checked"<{/if}> />
          </td>
        </tr>
        <tr>
          <td width="250" class="tdheader">监听UDP端口:</td>
          <td class="tdbody">
              <input type="checkbox" name="udpPort" id="udpPortChk" 
                  <{if $basic.udp_enable eq 1}>checked="checked"<{/if}> />
          </td>
        </tr>
        <tr>
          <td width="250" class="tdheader">监听TCP端口:</td>
          <td class="tdbody">
              <input type="checkbox" name="tcpPort" id="tcpPortChk" 
                  <{if $basic.tcp_enable eq 1}>checked="checked"<{/if}> />
          </td>
        </tr>
        <tr>
          <td width="250" class="tdheader">日志文件阀值:</td>
          <td class="tdbody">
              <input type="text" name="logLimitSize" value="<{$basic.sizelimit|default: '20'}>" size="3" maxlength="3"/>M          
          </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button" id="setSyncBtn" onClick="basicConfBtn()">
                确定</button>
            </td>
        </tr>
    </tbody>
</table>
</form>


<script type="text/javascript" src="Public/js/log/conf/basicConf.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#basicConfForm"));
    initBasic();
    $("#synLogToEndChk").click(function(){	
		
		if($("#synLogToEndChk").attr("checked"))
		{
			$("#udpPortChk").attr("disabled",'disabled');
			$("#tcpPortChk").attr("disabled",'disabled');
			
		}
		else
		{
			$("#udpPortChk").removeAttr("disabled");
			$("#tcpPortChk").removeAttr("disabled");
		}				
		
	});
	$("#udpPortChk").click(function(){	
				
		if($("#udpPortChk").attr("checked") || $("#tcpPortChk").attr("checked"))
		{
			$("#synLogToEndChk").attr("disabled",'disabled');			
		}
		else
		{
			$("#synLogToEndChk").removeAttr("disabled");
		}
		
	});
	$("#tcpPortChk").click(function(){	
		
		if($("#udpPortChk").attr("checked") || $("#tcpPortChk").attr("checked"))
		{
			$("#synLogToEndChk").attr("disabled",'disabled');			
		}
		else
		{
			$("#synLogToEndChk").removeAttr("disabled");
		}
		
	});
    function initBasic(){
    	if($("#synLogToEndChk").attr("checked"))
    	{
    		$("#udpPortChk").attr("disabled",'disabled');
    		$("#tcpPortChk").attr("disabled",'disabled');   		
    	}
    	else
    	{
    		$("#udpPortChk").removeAttr("disabled");
    		$("#tcpPortChk").removeAttr("disabled");
    	}   
    	if($("#udpPortChk").attr("checked") || $("#tcpPortChk").attr("checked"))
    	{
    		$("#synLogToEndChk").attr("disabled",'disabled');    		
    	}
    	else
    	{
    		$("#synLogToEndChk").removeAttr("disabled");
    	}   
    }
});
</script>
