<form action="Function/systemManagement/admin/account.php" method="POST" id="editAccountForm" onSubmit='return false;'>
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>管理员帐号维护</legend>
        <div class="row">
            <label for="account">帐号:<em class="required">*</em></label>
            <input type="text" name="account" maxlength="15" value="<{$account}>" id="account"/>
            <input type="hidden" name="oldAccount" value="<{$account}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="passwd">口令:<em class="required">*</em></label>
            <input type="password" name="passwd" maxlength="15" value="<{$passwd}>" id="passwd"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="passwd_again">确认口令:<em class="required">*</em>
            </label>
            <input type="password" name="passwd_again" maxlength="15" value="<{$passwd}>" id="passwd_again"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>帐号类型:</label>
            <input class="checkbox roles" type="checkbox" name="confAdmin" <{$isConf}> id="confAdmin"/>
            <label for="confAdmin">配置管理员</label>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>&nbsp;</label>
            <input class="checkbox roles" type="checkbox"
                name="policyAdmin" <{$isPolicyer}> id="policyAdmin"/>
            <label for="policyAdmin">策略管理员</label>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>&nbsp;</label>
            <input class="checkbox roles" type="checkbox" name="logAdmin" 
                <{$isLoger}> id="logAdmin"/>
            <label for="logAdmin">日志审计员</label>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editAccountForm"));
    });
</script>
