<form action="Function/resConf/user/userList.php" method="POST" id="editUserListForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>用户列表维护</legend>
        <div class="row">
            <label for="userListName">用户名称:<em class="required">*</em></label>
            <input type="text" name="userListName" maxlength="15" value="<{$userList.name}>"
            <{if $type === 'edit'}>readonly="readonly"<{/if}> id="userListName"/>
        </div>
        <br class="clearFloat"/>
        <hr/>
        <div class="row">
            <label for="authType">认证方式:<em class="required">*</em></label>
            <div class="column column_65">
                <input class="radio" type="radio" name="authType" value="local-pwd" id="localPwd"/>
                <label for="localPwd">本地密码认证</label>
                <br/>
                <input class="radio" type="radio" name="authType" value="local-cert" id="localCert"/>
                <label for="localCert">本地证书认证</label>
                <br/>
                <input class="radio" type="radio" name="authType" value="twofa" id="twofa"/>
                <label for="twofa">双因子认证</label>
                <br class="clearFloat"/>
                <div class="hide twofa">
                    <input class="radio" type="radio" name="twofaType" value="cert-pwd" id="certpwd"/>
                    <label for="certpwd" class="longLabel">本地证书 + 本地密码</label>
                    <br/>
                    <input class="radio" type="radio" name="twofaType" value="dyn-pwd" id="dynpwd"/>
                    <label for="dynpwd" class="longLabel">动态密码 + 本地密码(SN文件可选)</label>
                    <br class="clearFloat"/>
                </div>
                <input class="radio" type="radio" name="authType" value="vip" id="vip"/>
                <label for="vip" class="longLabel">免认证(必须绑定IP, MAC中的一项!)</label>
            </div>
        </div>
        <br class="clearFloat"/>
        <hr/>
        <div class="row">
            <label for="passwd">登录密码:</label>
            <input type="password" name="passwd_user" id="passwd_user"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="passwd_again">重复密码:</label>
            <input type="password" name="passwd_user_again" id="passwd_user_again"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="sn">导入SN文件:</label>
            <input class="uploadFile" type="file" name="sn" id="sn"/>
        </div>
        <br class="clearFloat"/>
        <hr/>
        <div class="row">
            <label >所属角色:</label>
                <div class="column column_25">
                    <label for="allRoles">所有角色</label>
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
                    <label for="rolesMember">所属角色</label>
                    <{html_options class='multiSelect' size="5" multiple="multiple"
                        name="rolesMember[]" id="rolesMember"
                        output=$rolesMemberArr values=$rolesMemberArr}>
                </div>
        </div>
        <br class="clearFloat"/>
        <hr/>
        <div class="row">
            <label for="realName">真实名称:</label>
            <input type="text" name="realName" id="realName"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="bindIp">绑定IP:</label>
            <input type="text" name="bindIp" id="bindIp"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="bindMac">绑定MAC:</label>
            <input type="text" name="bindMac" id="bindMac"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>用户更改密码:</label>
            <input class="radio" type="radio" name="modifyPwdAllow" id="mpa_on" <{$mpa_on}>/>
            <label class="radioLabel" for="mpa_on">启动</label>
            <input class="radio" type="radio" name="modifyPwdAllow" id="mpa_off" <{$mpa_off}>/>
            <label class="radioLabel" for="mpa_off">不启用</label>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>首次登录密码修改:</label>
            <input class="radio" type="radio" name="firstChangePwd" id="fcp_on" <{$fcp_on}>/>
            <label class="radioLabel" for="fcp_on">启动</label>
            <input class="radio" type="radio" name="firstChangePwd" id="fcp_off" <{$fcp_off}>/>
            <label class="radioLabel" for="fcp_off">不启用</label>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="validTime">用户有效时间(单位:天):</label>
            <input type="text" name="validTime" id="validTime" value="0"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="validTime_pwd">密码有效时间(单位:天):</label>
            <input type="text" name="validTime_pwd" id="validTime_pwd" value="0"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="connectRule">接入控制:</label>
            <{html_options id="connectRule" name="connectRule"
                output=$connectRuleArr values=$connectRuleArr}>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>状态:</label>
            <input class="radio" type="radio" name="active" id="active_on" <{$active_on}>/>
            <label class="radioLabel" for="active_on">启动</label>
            <input class="radio" type="radio" name="active" id="active_off" <{$active_on}>/>
            <label class="radioLabel" for="active_off">不启用</label>
        </div>
       
       
        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$userList.comment}></textarea>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editUserListForm"));
    $(':radio[name="authType"], :radio[name="twofaType"]').click(function() {
        changeAuthType();
    });
});

function changeAuthType() {
    var authType = $(':radio[name="authType"]:checked').val();
    if ('twofa' === authType) {
        $('.twofa').show();
        $('#passwd_user').removeAttr('disabled');
        $('#passwd_user_again').removeAttr('disabled');
        $('#sn').removeAttr('disabled');
        if ('cert-pwd' === $(':radio[name="twofaType"]:checked').val()) {
            $('#sn').attr('disabled', 'disabled');
        } else { //dynpwd
            $('#sn').removeAttr('disabled');
        }
    } else if ('local-pwd' === authType) {
        $('.twofa').hide();
        $('#passwd_user').removeAttr('disabled');
        $('#passwd_user_again').removeAttr('disabled');
        $('#sn').attr('disabled', 'disabled');
    } else if ('local-cert' === authType) {
        $('.twofa').hide();
        $('#passwd_user').attr('disabled', 'disabled');
        $('#passwd_user_again').attr('disabled', 'disabled');
        $('#sn').attr('disabled', 'disabled');
    } else if ('vip' === authType) {
        $('.twofa').hide();
        $('#passwd_user').attr('disabled', 'disabled');
        $('#passwd_user_again').attr('disabled', 'disabled');
        $('#sn').attr('disabled', 'disabled');
    } else {
    }
}
</script>
