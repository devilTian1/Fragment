<form action="Function/resConf/user/userList.php" method="POST" id="editLockTimeForm" onSubmit="return false;">
    <fieldset>
        <legend>用户锁定</legend>
        <div class="row">
            <label>用户名称:</label>
            <label><{$name}></label>
            <input type="hidden" name="name" value="<{$name}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="lockTime">锁定时间:</label>
            <input type="text" name="lockTime" id="lockTime" class="width132"
                value="<{$lockTime}>"/>(单位:分钟, 0:永久锁定)
        </div>
    </fieldset>
</form>
<script type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editLockTimeForm"));
});
</script>
