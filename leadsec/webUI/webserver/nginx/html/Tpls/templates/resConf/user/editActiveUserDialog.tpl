<form action="Function/resConf/user/userList.php" method="POST" id="editActiveUserForm" onSubmit="return false;">
    <fieldset>
        <legend>动态密码同步</legend>
        <div class="row">
            <label for="activePwd">动态密码:</label>
            <input type="text" name="activePwd" id="activePwd"
                value=""/>
            <input type="hidden" name="activeName" value="<{$name}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editActiveUserForm"));
});
</script>
