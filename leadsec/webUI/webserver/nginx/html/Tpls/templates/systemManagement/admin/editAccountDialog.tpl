<form action="Function/systemManagement/admin/account.php" method="POST" id="editAccountForm" onSubmit='return false;'>
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>管理员账号维护</legend>
        <div class="row">
            <label for="account">账号:<em class="required">*</em></label>
            <input type="text" class="width132" name="account" maxlength="15" 
			value="<{$account}>" id="account"  
			<{if $type === 'edit'}> disabled="disabled" <{/if}>/>
			<{if $type === 'edit'}>
				<input type="hidden" name="account" value="<{$account}>"/>
			<{/if}>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="passwd">口令:<em class="required">*</em></label>
            <input type="password" class="width132" name="passwd" maxlength="15" value="<{$passwd}>" id="passwd"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="passwd_again">确认口令:<em class="required">*</em>
            </label>
            <input type="password" class="width132" name="passwd_again" maxlength="15" value="<{$passwd}>" id="passwd_again"/>
        </div>
        <br class="clearFloat"/>
		<div <{if $isEditRole eq 'no' and $type eq 'edit'}> class="hide" <{/if}>>
			<div class="row">
				<label>账号类型:</label>
				<input class="checkbox roles" type="radio" name="role" <{$isConf}>
					id="confAdmin" value="manager"/> 
					
				<label for="confAdmin">配置管理员</label>
			</div>
			<br class="clearFloat"/>
			<div class="row">
				<label>&nbsp;</label>
				<input class="checkbox roles" type="radio" name="role"
					<{$isPolicyer}> id="policyAdmin" value="policyer" />
				<label for="policyAdmin">策略管理员</label>
			</div>
			<br class="clearFloat"/>
			<div class="row">
				<label>&nbsp;</label>
				<input class="checkbox roles" type="radio" name="role" 
					<{$isLoger}> id="logAdmin" value="auditor" />
				<label for="logAdmin">审计管理员</label>
			</div>
		</div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editAccountForm"));
    });
</script>
