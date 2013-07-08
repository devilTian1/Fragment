<form action="Function/server/safePass/safePass.php" method="POST" id="editSafePassServerForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<fieldset>
		<legend>安全通道</legend>
      	<div class="row">
      		<label>任务号:<em class="required">*</em></label>
      		<input class="id" type="text" name="safePassId" id="safePassId" value="<{$editSafePass.id}>" 
      			<{if $type ==='edit'}>disabled="disabled"<{/if}> size="4" maxlength="4" />
      		(同一端的任务号必须唯一)
            <{if $type ==='edit'}>
            	<input type="hidden" name="safePassId" value="<{$editSafePass.id}>"/>
            <{/if}>
    	</div>
    	
    	<div class="row">
    		<label>服务器地址:<em class="required">*</em></label>
    		<input class="ip" type="text" name="spServerIp" value="<{$editSafePass.sip}>" size="15" maxlength="15"/>    		
    	</div>    	
    	
    	<div class="row" id="sPortDiv">
    		<label>服务器端口:</label>
    		<input class="id" type="text" name="serverPort" value="<{$editSafePass.sport}>" size="5" maxlength="11"/>    		
    	</div>
    	
    	<div class="row" id="inPortDiv">
    		<label>公开端口:</label>
    		<input class="id" type="text" name="publicPort" value="<{$editSafePass.inport}>" size="5" maxlength="11"/>  
    		(如填写，需与客户端目的端口一致)   		
    	</div>
      
      	<div class="row">
    		<label>流出网口IP:</label>
    		<{html_options  class="select" name="outflowIpList"
                 options=$interfaceList selected=$editSafePass.eip}>    		 		
    	</div>
    	
		<div class="row">
        	<label>服务类型:<em class="required">*</em></label>
        	<{html_options class="select" name="serviceList" onChange="portOnCtrl()"
                 output=array('tcp_any','udp_any','RemoteDesk','Syslog','dns','http','https'
                 ,'pop3','smtp','snmp','telnet','ftp','h323','h323_gk'
                 ,'mms','rtsp','sip','tftp','tns') 
                 values=array('tcp_any','udp_any','RemoteDesk','Syslog','dns','http','https'
                 ,'pop3','smtp','snmp','telnet','ftp','h323','h323_gk'
                 ,'mms','rtsp','sip','tftp','tns') 
                  selected=$editSafePass.service|default: 'tcp_any'}>
        </div>
        
         <div class="row">
            <label>是否启动:</label>
            <{html_radios class="radio" label_ids=true name=activeChk values=array('ok', 'erro')
              output=array('启动', '停止')
              selected=$editSafePass.active|default: 'ok'
            }>
        </div>
    
        <div class="row">
            <label>开启日志:</label>
            <{html_radios class="radio" name=logChk label_ids=true values=array('Y', 'N')
              output=array('是', '否')
              selected=$editSafePass.log|default: 'N'
            }>
        </div>
        
        <div class="row">
        	<label>备注:</label>        	
        	<input class="comment" name="comment" id="comment" value="<{$editSafePass.comment|escape}>"/>
        </div>
   </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	validateForm($("#editSafePassServerForm"));	
	filterRes();				   
	portOnCtrl();		   
});
</script>
