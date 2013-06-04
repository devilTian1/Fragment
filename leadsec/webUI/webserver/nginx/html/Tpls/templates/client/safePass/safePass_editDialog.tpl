<form action="Function/client/safePass/safePass.php" method="POST" id="editSafePassForm" onSubmit="return false;">
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
            <label>访问类型:<em class="required">*</em></label>
            <{html_radios class="radio" name=accessType id=accessType label_ids=true values=array('yes', 'no')
              output=array('普通访问', '透明访问') selected=$editSafePass.samenet|default: 'no' onClick="changeDestIpList()"
            }>
        </div>
        
    	<div class="row">
    		<label>源地址:</label>
    		<{html_options  class="select" name="srcIpList"
                 options=$saddrOptions selected=$editSafePass.sa|default: 'any_ipv4'}>
    	</div>
    
    	<div class="row" id="sPortDiv">
    		<label>源端口:</label>
    		<input class="id" type="text" name="safePassSrcPort" value="<{$editSafePass.sport|default:'1:65535'}>" size="5" maxlength="11"/>    		
    	</div>
    
    	<div class="row">
    		<label>目的地址:<em class="required">*</em></label>
    		<div id="div_destIp_normal">
    			<{html_options class="select" name="destIpList_normal"
                options=$interfaceList selected=$editSafePass.da}>
            </div>
            <div id="div_destIp_trans">
            	<{html_options class="select" name="destIpList_trans"
                options=$daddrOptions selected=$editSafePass.da|default: 'any_ipv4'}>
            </div>
    	</div>
    
        <div class="row" id="dPortDiv">
        	<label>目的端口:<em class="required">*</em></label>
        	<input class="id" type="text" name="safePassDestPort" value="<{$editSafePass.dport}>" size="5" maxlength="11"/>        	
        </div>
    
		<div class="row">
        	<label>服务类型:<em class="required">*</em></label>
        	<{html_options class="select" name="serviceList" onChange="portOnCtrl()"
                 output=array('tcp_any','udp_any','RemoteDesk','Syslog','dns','http','https'
                 ,'oicq','pop3','smtp','snmp','telnet','ftp','h323','h323_gk'
                 ,'irc','mms','rtsp','sip','tftp','tns') 
                 values=array('tcp_any','udp_any','RemoteDesk','Syslog','dns','http','https'
                 ,'oicq','pop3','smtp','snmp','telnet','ftp','h323','h323_gk'
                 ,'irc','mms','rtsp','sip','tftp','tns') 
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
    	<hr class="clearFloat"/>
    
        <div class="row">
            <label>抗攻击:</label>
            <div class="column column_70">
              	<label for="synFloodChk">
              	    <input class="checkbox" name="synFloodChk" id="synFloodChk" type="checkbox"/>
                抗SYN Flood</label>
                <input name="synFloodTxt" id="synFloodTxt" type="text" class="id" size="7" maxlength="7"/>个/秒
              	<br class="clearFloat"/>
              	<label for="udpFloodChk">
            	    <input class="checkbox" name="udpFloodChk" id="udpFloodChk" type="checkbox"/>
            		抗UDP Flood
                </label>
                <input name="udpFloodTxt" id="udpFloodTxt" type="text" class="id" size="7" maxlength="7"/>个/秒
                <!--
				<span id="icmpDiv">
              	<br class="clearFloat"/>
              	<label for="icmpFloodChk">
            	    <input class="checkbox" name="icmpFloodChk" id="icmpFloodChk" type="checkbox"/>
            		抗ICMP Flood
                </label>                
                <input name="icmpFloodTxt" id="icmpFloodTxt" type="text" class="id" size="7" maxlength="7"/>个/秒
              	</span>
				-->
              	<span id="pingDiv">
                  	<br class="clearFloat"/>
                  	<label for="pingFloodChk">
                	    <input class="checkbox" name="pingFloodChk" id="pingFloodChk" type="checkbox" />抗Ping of Death
                    </label>
                    </span>
            </div>
        </div>
		<hr class="clearFloat"/>
    
        <div class="row">
        	<label>生效时段:</label>
        	<{html_options class="select" name="timeList" id="timeList"
                options=$timeList selected=$editSafePass.time|default: 'empty'}>
        </div>
    
        <div class="row">
        	<label>备注:</label>        	
        	<input class="comment" name="comment" id="comment" value="<{$editSafePass.comment|escape}>"/>
        </div>
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	initSafePassEdit(); 
	validateForm($("#editSafePassForm"));
	$("#synFloodChk").bind("click",function(){
	    if ('checked' == $("#synFloodChk").attr("checked")) {
	        $("#synFloodTxt").removeAttr("disabled",'disabled');
	    } else {
	        $("#synFloodTxt").attr("disabled",'disabled');
	    }
	});
	$("#udpFloodChk").bind("click",function(){
	    if ('checked' == $("#udpFloodChk").attr("checked")) {
	        $("#udpFloodTxt").removeAttr("disabled",'disabled');
	    } else {
	        $("#udpFloodTxt").attr("disabled",'disabled');
	    }
	});
	$("#icmpFloodChk").bind("click",function(){
	    if ('checked' == $("#icmpFloodChk").attr("checked")) {
	        $("#icmpFloodTxt").removeAttr("disabled",'disabled');
	    } else {
	        $("#icmpFloodTxt").attr("disabled",'disabled');
	    }
	});	
});

function initSafePassEdit() {
	if ('<{$type}>' == 'edit') {
		// 初始化抗攻击参数
		if ('<{$editSafePass.syn}>' != 'off' && '<{$editSafePass.syn}>' != '') {
			$("#synFloodChk").attr("checked",'checked');
			$("#synFloodTxt").attr("value",'<{$editSafePass.syn}>');
		} else {
		    $("#synFloodTxt").attr("disabled",'disabled');
		}
		if ('<{$editSafePass.udp}>' != 'off' && '<{$editSafePass.udp}>' != '') {	
			$("#udpFloodChk").attr("checked",'checked');
			$("#udpFloodTxt").attr("value",'<{$editSafePass.udp}>');
		} else {
		    $("#udpFloodTxt").attr("disabled",'disabled');
		}
		if ('<{$editSafePass.icmp}>' != 'off' && '<{$editSafePass.icmp}>' != '') {	
			$("#icmpFloodChk").attr("checked",'checked');
			$("#icmpFloodTxt").attr("value",'<{$editSafePass.icmp}>');
		} else {
		    $("#icmpFloodTxt").attr("disabled",'disabled');
		}
		if ('<{$editSafePass.ping}>' != 'off' && '<{$editSafePass.ping}>' != '') {	
			$("#pingFloodChk").attr("checked",'checked');
		}
	} else {
	    $("#synFloodTxt").attr("disabled",'disabled');
	    $("#udpFloodTxt").attr("disabled",'disabled');
	    $("#icmpFloodTxt").attr("disabled",'disabled');
	}
	changeDestIpList();
	portOnCtrl();
}

</script>
