<form action="Function/networkManagement/HA/syncConf.php?server=1" method="POST" id="serverIPForm"
    onSubmit='return false;'>
<table class="column_95">
    <caption>
         服务器设置
    </caption>
    <tbody>        
        <tr>
          <td width="250" class="tdheader">服务器 IP:</td>
          <td class="tdbody">
            <input type="text" class="width149" name="ha_ip" id="serverIp" value="<{$ser.host}>" />         
          </td>
        </tr>       
        <tr>
          <td width="250" class="tdheader">端口:</td>
          <td class="tdbody">
            <input class="port" type="text" name="logPortReq" id="serverPort"
                value="<{$ser.service}>" size="5" maxlength="5"/>         
          </td>
        </tr>       
        <tr>
            <td>&nbsp;</td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button" id="logServerBtn" onClick="serverConfBtn()">
                确定</button>
            </td>
        </tr>
        <tr>
            <td  colspan='2'>
                <button class="standard floatLeft" type="button" style="position: static"
    				onclick="downloadConfDialog()" >下载配置   				
				</button>
				<button class="standard floatLeft" type="button" style="position: static"
    				onclick="rollbackConfDialog()" >回滚配置    				
				</button>
				<button class="standard floatLeft" type="button" style="position: static"
    				onclick="syncHistoryDialog()" >同步历史   				
				</button>
            </td>
        </tr>
    </tbody>
</table>
</form>
<br/>
<form action="Function/networkManagement/HA/syncConf.php?local=1" method="POST" id="localAddrForm"
    onSubmit='return false;'>
<table class="column_95">
    <caption>
          本地设置
    </caption>
    <tbody>
    	<tr>
          <td width="250" class="tdheader">本地监听地址:</td>
          <td class="tdbody">
              <{html_options  class="w100" name="localAddr" 
                    id ="localAddr" output=$haInterface 
                    values=$haInterface
                    selected=$local.host|default: '' }>                  
          </td>
        </tr>
        <tr>
          <td width="250" class="tdheader">端口:</td>
          <td class="tdbody">
            <input class="port" type="text" name="logPortReq" id="localPort"
                value="<{$local.service}>" size="5" maxlength="5"/>         
          </td>
        </tr>              
        <tr>
           <td>&nbsp;</td>
           <td class="tdbody">
                <button class="inputbtn standard" type="button" id="logServerBtn" onClick="localAddrBtn()">
                确定</button>
            </td>
        </tr>
        <tr>
            <td class="tdbody" colspan='2'>
                <button class="standard floatLeft" type="button" style="position: static" name="buttonOn" onclick="startConfDialog()"
    			    <{if $state.state eq 1}> disabled="disabled"<{/if}> >启动服务   				
				</button>
				<button class="standard floatLeft" type="button" style="position: static" name="buttonOff" onclick="stopConfDialog()"
    				<{if $state.state eq 0}> disabled="disabled"<{/if}> >停止服务    				
				</button>
				<button class="standard floatLeft" type="button" style="position: static"
    				onclick="downHistoryDialog()" >下载历史   				
				</button>
            </td>
        </tr>
    </tbody>
</table>
</form>

<script type="text/javascript" src="Public/js/networkManagement/HA/syncConf.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#serverIPForm"));
    validateForm($("#localAddrForm"));
    $(".tdbody").width($("table").width()-250);
});
</script>
