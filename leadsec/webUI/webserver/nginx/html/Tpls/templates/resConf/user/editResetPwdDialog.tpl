<form action="Function/resConf/user/userList.php" method="POST" id="editResetPwdForm" onSubmit="return false;">
    <fieldset>
        <legend>密码重置</legend>
        <div class="row">
            <label>用户名称:</label>
            <label><{$name}></label>
            <input type="hidden" name="resetPwdName" value="<{$name}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="passwd">登录密码:</label>
            <input type="password" name="passwd_user" id="passwd_user" class="width132"
                value=""/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="passwd_again">重复密码:</label>
            <input type="password" name="passwd_user_again" class="width132"
                id="passwd_user_again" value=""/>
        </div>
    </fieldset>
</form>
<script type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editResetPwdForm"));
});
</script>
