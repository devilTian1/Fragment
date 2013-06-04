<form action="Function/systemManagement/conf/snmp.php" method="POST" id="setSnmpForm" 
onSubmit='return false;'>
	<table class="column_95">
		<caption>
			集中管理
		</caption>
		<tbody>
			<tr>
				<td width="250" class="tdheader">集中管理主机 IP: </td>
				<td class="tdbody"><input class="width150" name="serverip" type="text" id="serverip"/></td>
			</tr>
			<tr>
				<td class="tdheader"><button type="button" class="inputbtn standard" name="button" id="addip" >&gt;&gt;</button>
					<br/>
					<br/>
        			<button type="button" class="inputbtn standard" name="button" id="delip" >&lt;&lt;</button>
        		</td>
      			<td class="tdbody">
        			<select name="iplist[]" size="6" multiple="multiple" id="iplist" style="width:160px" >
        				<{foreach $iplist as $Array}>
        					<option value='<{$Array}>'><{$Array}></option>
        				<{/foreach}>
        			</select>
      			</td>
    		</tr>
    		<tr>
      			<td class="tdheader"><{$smarty.const.PRODUCT_NAME}>名称:</td>
      			<td class="tdbody"><{$hostname}></td>
    		</tr>
    		<tr>
      			<td class="tdheader">本机备注:</td>
      			<td class="tdbody"><input name="hostComment" type="text" class="inputtext" value="<{$snmp.comment}>" />
        		</td>
    		</tr>
    		<tr>
				<td class="tdheader">负责人姓名: </td>
				<td class="tdbody"><input name="managerName" type="text" class="inputtext" value="<{$snmp.adminname}>" />
				</td>
    		</tr>
    		<tr>
				<td class="tdheader">负责人电话:</td>
				<td class="tdbody"><input name="managerTel" type="text" class="inputtext" value="<{$snmp.adminphone}>"/>
				</td>
			</tr>
    		<tr>
				<td class="tdheader">CPU 利用率阈值: </td>
				<td class="tdbody"><input class="width80" name="CPU" type="text" value="<{$snmp.cpu}>" size="10"  />
					%  </td>
			</tr>
			<tr>
				<td class="tdheader">内存利用率阈值:</td>
				<td class="tdbody"><input class="width80" name="memory" type="text" value="<{$snmp.mem}>" size="10"/>
					%  </td>
			</tr>
    		<tr>
				<td class="tdheader">磁盘利用率阈值: </td>
				<td class="tdbody"><input class="width80" name="disk" type="text" value="<{$snmp.file}>" size="10"  />
					%  </td>
    		</tr>
    		<tr>
				<td class="tdheader">Trap发送字符串:</td>
				<td class="tdbody"><input name="trapStr" type="text" class="inputtext" value="<{$snmp.trapcomm}>" />
				</td>
			</tr>
    		<tr>
				<td valign="middle" class="tdheader"><input name="snmpChk" type="checkbox" id="snmpChk"/>
				snmp v1&amp;v2 </td>
				<td class="tdbody">
					<div>只读团体字符串:
						<input name="readOnly" id="readOnly" type="text" value="<{$snmp.rcomm}>"/>						
					</div>
					<div class="margintop3">
           				读写团体字符串:
						<input name="writeAndReady" id="writeAndReady" type="text" value="<{$snmp.wcomm}>"/>						
					</div>
				</td>
    		</tr>
    		<tr>
				<td valign="middle" class="tdheader"><input name="snmpv3Chk" type="checkbox" id="snmpv3Chk"  />
					snmp v3 </td>
				<td class="tdbody">
					<div class="margintop3">
						<span class="red">*</span>
						用户名称: 
						<input name="v3Usrname" id="v3Usrname" type="text" value="<{$snmpv3.username}>"/>
					</div>
        
					<div class="margintop3"><span class="red">*</span>
						安全选项:
						<{html_options name="secSelect"
						output=array('加密授权认证方式','非加密授权认证方式','非授权认证方式') values=array('priv','auth','noauth')
        				selected=<{$snmpv3.seclevel|default: 'noauth'}> id="secSelect"}>
        			</div>
        
        			<div class="margintop3"><span class="red">*</span>
           				认证协议:
          	 			<input name="authProto" type="radio" value="0" /> MD5 

             			<input name="authProto" type="radio" value="1"/>SHA 
        			</div>
        
        			<div class="margintop3"><span class="red">*</span>
          				 认证密码:
          				<input class="width150" name="authPhrase" id="authPhrase" type="password" value="<{$snmpv3.authphrase}>"/>          				
        			</div>
         
        			<div class="margintop3"><span class="red">*</span>
          				 加密协议:
          
            			<input name="privProto" type="radio" value="0" />DES 
          
            			<input type="radio" name="privProto" value="1" />AES 
        			</div>
        
        			<div class="margintop3"><span class="red">*</span>
          				加秘密码:
          				<input class="width150" name="privPhrase" id="privPhrase" type="password" value="<{$snmpv3.privphrase}>"/>						
        			</div>
        		</td>
    		</tr>
    		<tr>
      			<td></td>
      			<td class="tdbody">
        			<button type="button" width="50" class="inputbtn standard" onclick="setSnmpForm()">确定</button>
  	  			</td>
    		</tr>
		</tbody>
	</table>
</form>
<br/><br/>
<form action="Function/systemManagement/conf/snmp.php?reconf=1" method="POST" id="SnmpStatusForm">
<table class="column_95">
    <input type="hidden" name="switch" id="switch" value='<{if $status eq 'on'}>off<{else}>on<{/if}>'/>
    <caption>snmp代理控制</caption>
    <tbody>
    <tr>
        <td class="tdheader column_40">当前snmp代理服务状态:</td>
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
                <{if $status eq 'on'}> disabled="disabled"<{/if}>>启动snmp代理</button>
            <button type="button" name="buttonOff" class="inputbtn standard" onclick="setServiceForm('off')"
                <{if $status eq 'off'}> disabled="disabled"<{/if}>>停止snmp代理</button>
        </td>
    </tr>
    </tbody>
</table>
</form>
<script type="text/javascript" src="Public/js/systemManagement/conf/snmp.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	renderStandardUi();
	validateForm($("#setSnmpForm"));
	initSnmp();
	$("#addip").click(function(){
		if($("#setSnmpForm").validate().element("#serverip"))
		{
			var serverip=$("#serverip").val(),
			flag=0;
			$("#iplist option").each(function(){
				if($(this).val()==serverip){
					flag=1;
				}
			});	
			if($("#iplist option").length >= 16)
			{
				flag=1;
			}
			if(flag==0&&serverip!=''){
				var option = "<option value='"+serverip+"'>"+serverip+"</option>";                   
	        	$("#iplist").append(option);  
			}
		}
	});
	
	$("#iplist").dblclick(function(){  
		$("#iplist option:selected").each(function(){ 
			$(this).remove();  
		});  
     });
	$("#delip").click(function(){
		$("#iplist option:selected").each(function(){
			$(this).remove();  
		});					   
	});
	$("#snmpChk").click(function(){	
			
		if($("#snmpChk").attr("checked"))
		{
			$("#readOnly").removeAttr("disabled");
			$("#writeAndReady").removeAttr("disabled");
		}
		else
		{
			$("#readOnly").attr("disabled",'disabled');
			$("#writeAndReady").attr("disabled",'disabled');
		}
	});
	$("#snmpv3Chk").click(function(){	
		
		if($("#snmpv3Chk").attr("checked"))
		{
			$("#v3Usrname").removeAttr("disabled");
			$("#secSelect").removeAttr("disabled");
			$("input[name='authProto']").removeAttr("disabled");
			$("#authPhrase").removeAttr("disabled");
			$("input[name='privProto']").removeAttr("disabled");
			$("#privPhrase").removeAttr("disabled");
		}
		else
		{
			$("#v3Usrname").attr("disabled",'disabled');
			$("#secSelect").attr("disabled",'disabled');
			$("input[name='authProto']").attr("disabled",'disabled');
			$("#authPhrase").attr("disabled",'disabled');
			$("input[name='privProto']").attr("disabled",'disabled');
			$("#privPhrase").attr("disabled",'disabled');
		}
	});
});

function initSnmp(){
	if('<{$snmp.comm2sec}>' == 'on')
		$("#snmpChk").attr("checked",'checked');
	if('<{$snmpv3.v3usm}>' == 'on')
		$("#snmpv3Chk").attr("checked",'checked');
	if('<{$snmpv3.authproto}>' == 'MD5')
		$("input[name='authProto']:eq(0)").attr("checked",'checked');
	else if('<{$snmpv3.authproto}>' == 'SHA')
		$("input[name='authProto']:eq(1)").attr("checked",'checked');
	if('<{$snmpv3.privproto}>' == 'DES')
		$("input[name='privProto']:eq(0)").attr("checked",'checked');
	else if('<{$snmpv3.privproto}>' == 'AES')
		$("input[name='privProto']:eq(1)").attr("checked",'checked');
	// init
	if($("#snmpChk").attr("checked"))
	{
		$("#readOnly").removeAttr("disabled");
		$("#writeAndReady").removeAttr("disabled");
	}
	else
	{
		$("#readOnly").attr("disabled",'disabled');
		$("#writeAndReady").attr("disabled",'disabled');
	}
	if($("#snmpv3Chk").attr("checked"))
	{
		$("#v3Usrname").removeAttr("disabled");
		$("#secSelect").removeAttr("disabled");
		$("input[name='authProto']").removeAttr("disabled");
		$("#authPhrase").removeAttr("disabled");
		$("input[name='privProto']").removeAttr("disabled");
		$("#privPhrase").removeAttr("disabled");
	}
	else
	{
		$("#v3Usrname").attr("disabled",'disabled');
		$("#secSelect").attr("disabled",'disabled');
		$("input[name='authProto']").attr("disabled",'disabled');
		$("#authPhrase").attr("disabled",'disabled');
		$("input[name='privProto']").attr("disabled",'disabled');
		$("#privPhrase").attr("disabled",'disabled');
	}
}
</script>
