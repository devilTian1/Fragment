<form action="Function/resConf/user/userGroup.php" method="POST" id="editUserGroupForm" onSubmit="return false;">
    <fieldset>
    <legend>用户组列表维护</legend>
    <div class="row">
            <label for="userListName">用户名称:<em class="required">*</em></label>
            <input type="text" name="userListName" maxlength="15" value="<{$userList.user_name}>"
            <{if $type === 'edit'}>readonly="readonly"<{/if}> id="userListName"/>
    </div>
    <br class="clearFloat"/>
    <hr/>
    <div class="row">
        <label for="passwd">分配流量:</label>
        <input type="password" name="passwd_user" id="passwd_user"
        value="<{$userList.passwd}>"/>
    </div>
    <br class="clearFloat"/>
    <hr/>
    <div class="row">
        <label for="passwd">分配时间:</label>
        <input type="password" name="passwd_user" id="passwd_user"
        value="<{$userList.passwd}>"/>
    </div>
    <br class="clearFloat"/>
    <hr/>
    <div class="row">
        <label>进程检查:</label>
        <input class="radio" type="radio" name="modifyPwdAllow" id="mpa_on" <{$mpa_on}>/>
        <label class="radioLabel" for="mpa_on">检查</label>
        <input class="radio" type="radio" name="modifyPwdAllow" id="mpa_off" <{$mpa_off}>/>
        <label class="radioLabel" for="mpa_off">不检查</label>
    </div>
    <br class="clearFloat"/>
    <hr/>
    <div class="row">
        <label>进程策略:</label>
        <input class="radio" type="radio" name="modifyPwdAllow" id="mpa_on" <{$mpa_on}>/>
        <label class="radioLabel" for="mpa_on">开启进程策略</label>
        <input class="radio" type="radio" name="modifyPwdAllow" id="mpa_off" <{$mpa_off}>/>
        <label class="radioLabel" for="mpa_off">不开启进程策略</label>
    </div>
    <br class="clearFloat"/>
    <hr/>
    <div class="row">
        <label >本组用户:</label>
            <div class="column column_25">
                <label for="allRoles">所有用户</label>
                <{html_options class='multiSelect' size="5" multiple="multiple"
                id="allRoles" name="allRoles"
                    output=$allRolesArr values=$allRolesArr}>
            </div>
            <div class="column column_10">
                <br/>
                <button type="button" class="standard floatLeft" onClick="moveToSpecRole()"> &gt;&gt;
                </button>
                <br/><br/>
                <button type="button" class="standard floatLeft" onClick="moveToAllRoles()"> &lt;&lt;
                </button>
            </div>
            <div class="column column_25">
                <label for="rolesMember">所属用户</label>
                <{html_options class='multiSelect' size="5" multiple="multiple"
                    name="rolesMember[]" id="rolesMember"
                    output=$rolesMemberArr values=$rolesMemberArr}>
            </div>
    </div>
    <br class="clearFloat"/>
    <hr/>
    <div class="row">
        <label for="passwd">进程管理:</label>
        <button class="standard floatLeft" type="position: static" name="process" id="process"
        onclick="addProcess()">
        查看进程
        </button>
    </div>
    <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript" src="Public/js/resConf/user/userGroup.js"></script>
<script  type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
});
</script>
