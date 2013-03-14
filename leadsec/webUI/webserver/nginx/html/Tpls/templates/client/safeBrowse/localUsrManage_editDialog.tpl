<form action="Function/client/safeBrowse/localUsrManage.php" method="POST" id="editLocalUsrManageForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<fieldset>
    	<legend>本地用户管理</legend>
    	<div class="row">
    		<label>用户名:<em class="required">*</em></label>
    		<input class="id" type="text" name="usrName" value="<{$editUsrMng.name}>"
    		<{if $type === 'edit'}> disabled="disabled" <{/if}> size="15" maxlength="15"/>
    		<{if $type ==='edit'}>
            	<input type="hidden" name="usrName" value="<{$editUsrMng.name}>"/>
            <{/if}>
    	</div>
    
    	<{if $type === 'edit'}>
	    	<div class="row">
	    		<label>修改密码:</label>
	    		<input class="checkbox" name="modifyEnable" id="modifyEnable" type="checkbox" onclick="enablePasswd()"/> 	    		
    		</div>
    	<{/if}>
    	
    	<div class="row">
    		<{if $type === 'edit'}>
    			<label>新密码:<em class="required">*</em></label>
    		<{else}>
    			<label>密码:<em class="required">*</em></label>
    		<{/if}>
    			<input class="id" type="password" name="psswd1" id="psswd1" value="<{$editUsrMng.passwd}>"
    			<{if $type === 'edit'}> disabled="disabled" <{/if}> size="15" maxlength="15"/> 
    	</div>
    
        <div class="row">
        	<label>确认密码:<em class="required">*</em></label>
        	<input class="id" type="password" name="psswd2" id="psswd2" value="<{$editUsrMng.passwd}>"
        	<{if $type === 'edit'}> disabled="disabled" <{/if}> size="15" maxlength="15"/>        	
        </div>
            
        <div class="row">
        	<label>备注:</label>        	
        	<input class="comment" name="comment" id="comment" value="<{$editUsrMng.comment}>"/>
        </div>
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {	
	validateForm($("#editLocalUsrManageForm"));	
});
</script>