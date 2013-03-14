<form action="Function/client/safeBrowse/generalVisit.php" method="POST"  id="editGeneralAccessCtrlForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<input type="hidden" name="generalAccId" value="<{$editGeneralAcc.id}>"/>
	<fieldset>
    	<legend>添加普通访问控制</legend>
    	<div class="row">
    		<label>源地址:</label>
    		<{html_options  class="select" name="srcIpList"
                 options=$addrOptions selected=$editGeneralAcc.sip|default: 'any_ipv4'}>
    	</div>
    
    	<div class="row">
        	<label>认证用户组:</label>
        	<{html_options class="select" name="authUsrGrpList"
                options=$roleList selected=$editGeneralAcc.usergrp}>
        </div>
    
        <div class="row">
        	<label>生效时段:</label>
        	<{html_options class="select" name="timeList" id="timeList"
                options=$timeList selected=$editGeneralAcc.time}>
        </div>
    
        <div class="row">
        	<label>备注:</label>        	
        	<input class="comment" name="comment" id="comment" value="<{$editGeneralAcc.comment}>"/>
        </div>
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	initGeneralAccessCtrlEdit(); 
	validateForm($("#editGeneralAccessCtrlForm"));	
});

function initGeneralAccessCtrlEdit() {
	filterRes();
}

</script>