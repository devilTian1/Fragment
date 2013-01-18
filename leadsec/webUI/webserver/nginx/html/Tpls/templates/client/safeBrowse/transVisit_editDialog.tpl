<form action="Function/client/safeBrowse/transVisit.php" method="POST" id="editTransAccessCtrlForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<input type="hidden" name="transAccId" value="<{$editTransAcc.id}>"/>
	<fieldset>
    	<legend>添加透明访问控制</legend>
    	<div class="row">
    		<label>源地址:</label>
    		<{html_options  class="select" name="srcIpList"
                 options=$addrOptions selected=$editTransAcc.sip|default: 'any_ipv4'}>
    	</div>
    
    	<div class="row">
    		<label>目的地址:</label>
    			<{html_options class="select" name="destIpList"
                options=$addrOptions selected=$editTransAcc.dip|default: 'any_ipv4'}>
    	</div>
    
        <div class="row" id="dPortDiv">
        	<label>目的端口:<em class="required">*</em></label>
        	<input class="id" type="text" name="destPort" value="<{$editTransAcc.port}>" size="5" maxlength="5"/>        	
        </div>
        
        <div class="row" id="dPortDiv">
        	<label>Https:</label>
        	<input class="checkbox" name="httpEnableChk" id="httpEnableChk" type="checkbox"/>  	
        </div>
    
		<div class="row">
        	<label>认证用户组:</label>
        	<{html_options class="select" name="authUsrGrpList"
                options=$roleList selected=$editTransAcc.usergrp}>
        </div>
    
        <div class="row">
        	<label>生效时段:</label>
        	<{html_options class="select" name="timeList" id="timeList"
                options=$timeList selected=$editTransAcc.time}>
        </div>
    
        <div class="row">
        	<label>备注:</label>
        	<textarea rows="10" cols="30" name="comment" id="comment"><{$editTransAcc.comment}></textarea>
        </div>
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	initTransAccessCtrlEdit(); 
	validateForm($("#editTransAccessCtrlForm"));	
});

function initTransAccessCtrlEdit() {
	if ('<{$type}>' == 'edit') {
		// 初始化HTTPS
		if ('<{$editTransAcc.https}>' == '1') {
			$("#httpEnableChk").attr("checked",'checked');
		}
	}
	filterRes();
}

</script>