<form action="Function/networkManagement/HA/ha_basic.php?server=1" method="POST" id="HaBasicForm"
    onSubmit='return false;'>
<table class="column_95">
    <caption>
         双机热备基本配置
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
						output=array('抢占模式', '非抢占模设')
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
						output=array('切换虚拟ip后关闭物理网卡', '切换虚拟ip后不关闭物理网卡')
						values=array('D', 'E')
						selected=$data.ifcfg|default: 'D'}>
        			</div>
        		</td>
    	</tr>
		<tr>
			<td valign="middle" class="tdheader">对端网口HA地址:</td>
				<td class="tdbody">
					<div class="margintop3"> 
						<input name="ip" id="peer_ha_ip" type="text" 
						value="<{$data.peer_ha_ip}>"/>
					</div>
        		</td>
    	</tr>
		<tr>
			<td valign="middle" class="tdheader">对端网口HA端口:</td>
				<td class="tdbody">
					<div class="margintop3"> 
						<input name="logPortReq" id="peer_ha_port" type="text" 
						value="<{$data.peer_ha_port}>" size="5" maxlength="5"/>
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
<script type="text/javascript" src="Public/js/networkManagement/HA/ha_basic.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	renderStandardUi();
	validateForm($("#HaBasicForm"));
});
</script>

