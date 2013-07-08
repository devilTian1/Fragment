<form action="Function/client/msgTrans/userPrivilege.php" method="POST" id="editUserPriTableForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<input type="hidden" name="oldpw" value="<{$editUsrMng.password}>"/>
	<fieldset>
    	<legend>用户权限</legend>
    	<div class="row">
    		<label>用户名:<em class="required">*</em></label>
    		<input class="id" type="text" name="UserPriName" value="<{$editUsrMng.username}>"
    		<{if $type === 'edit'}> disabled="disabled" <{/if}> size="15" maxlength="15"/>
    		<{if $type ==='edit'}>
            	<input type="hidden" name="UserPriName" value="<{$editUsrMng.username}>"/>
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
    			<input class="id" type="password" name="psswd1" id="psswd1" value="<{$editUsrMng.password}>"
    			<{if $type === 'edit'}> disabled="disabled" <{/if}> size="15" maxlength="15"/> 
    	</div>
    
        <div class="row">
        	<label>确认密码:<em class="required">*</em></label>
        	<input class="id" type="password" name="psswd2" id="psswd2" value="<{$editUsrMng.password}>"
        	<{if $type === 'edit'}> disabled="disabled" <{/if}> size="15" maxlength="15"/>        	
        </div>
        <div class="row">
           <label>权限:</label>
           <div class="column column_70">
                <{html_checkboxes class="radio" name=cmdInfo label_ids=true
                    output=array('发送', '接收')
                    values=array('send', 'recv')
                    checked=$editUsrMng.prilist}>
           </div>    
        </div>      
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {	
	validateForm($("#editUserPriTableForm"));	
});
</script>