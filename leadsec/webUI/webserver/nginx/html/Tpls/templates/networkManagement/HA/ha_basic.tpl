<form action="Function/networkManagement/HA/ha_basic.php?server=1" method="POST" id="HaBasicForm"
    onSubmit='return false;'>
<table class="column_95">
    <caption>
         基本配置
    </caption>
    <tbody>        
        <tr>
			<td valign="middle" class="tdheader">工作角色</td>
				<td class="tdbody">
        			<div class="margintop3">
          	 			<{html_radios class="radio" name=work_role
						output=array('本机作为主闸', '本机作为从闸')
						values=array('M', 'S')
						selected=$data.role|default: 'M'}>
        			</div>
        		</td>
    	</tr>
		<tr>
			<td valign="middle" class="tdheader">工作模式</td>
				<td class="tdbody">
        			<div class="margintop3">
          	 			<{html_radios class="radio" name=work_mode 
						onclick = "changeWorkMode()" label_ids = true
						output=array('抢占模式', '非抢占模式')
						values=array('P', 'N')
						selected=$data.mode|default: 'P'}>
        			</div>
        		</td>
    	</tr>
		<tr>
			<td valign="middle" class="tdheader">网卡设置</td>
				<td class="tdbody">
        			<div class="margintop3">
          	 			<{html_radios class="radio" name=ifcfg 
						label_ids = true
						output=array('关闭故障网卡', '不关闭故障网卡')
						values=array('D', 'E')
						selected=$data.ifcfg|default: 'D'}>
        			</div>
        		</td>
    	</tr>
		<tr>
			<td valign="middle" class="tdheader">对端网闸HA地址:</td>
				<td class="tdbody">
					<div class="margintop3"> 
						<input class="width149" name="ha_ip" id="peer_ha_ip" type="text" 
						value="<{$data.peer_ha_ip}>"/>
					</div>
        		</td>
    	</tr>
		<tr>
			<td valign="middle" class="tdheader">对端网闸HA端口:</td>
				<td class="tdbody">
					<div class="margintop3"> 
						<input name="logPortReq" id="peer_ha_port" type="text" 
						value="<{$data.peer_ha_port}>" size="5" maxlength="5"/>
					</div>
        		</td>
    	</tr>
		<tr>
			<td valign="middle" class="tdheader">
				<label for="haTime">ARP更新时间(单位:秒):
					<em class="required">*</em>
				</label>
			</td>
			<td class="tdbody">
				<div class=""tdbody"">
					<input class="width149" id="haTime" type="text" value="<{$data.interval}>" name="haTime">
				</div>
        	</td>
    	</tr>
    	<tr>
      		<td></td>
      		<td class="tdbody">
        		<button type="button" width="50" class="inputbtn standard" onclick="setHaForm()">确定</button>
  	  		</td>
    	</tr>
    </tbody>
</table>
</form>
<br/><br/>
<form action="Function/networkManagement/HA/ha_basic.php?reconf=1" method="POST" id="HaStatusForm">
<table class="column_95">
    <input type="hidden" name="switch" id="switch" value='<{if $status eq 'on'}>off<{else}>on<{/if}>'/>
    <caption>服务管理</caption>
    <tbody>
    <tr>
        <td class="tdheader column_40">当前服务状态:</td>
        <td class="tdbody"><span id="status">
           <{if $status eq 'on'}>
                启动
           <{else}>
                停止
           <{/if}></span>
        </td>
    </tr>

    <tr>
        <td class="tdheader"></td>
        <td class="tdbody">
            <button type="button" name="buttonOn" class="inputbtn standard" onclick="setServiceForm('on')"
                <{if $status eq 'on'}> disabled="disabled"<{/if}>>启动服务</button>
            <button type="button" name="buttonOff" class="inputbtn standard" onclick="setServiceForm('off')"
                <{if $status eq 'off'}> disabled="disabled"<{/if}>>停止服务</button>
        </td>
    </tr>
    </tbody>
</table>
</form>
<script type="text/javascript" src="Public/js/networkManagement/HA/ha_basic.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	changeWorkMode();
	renderStandardUi();
	validateForm($("#HaBasicForm"));
});
</script>

