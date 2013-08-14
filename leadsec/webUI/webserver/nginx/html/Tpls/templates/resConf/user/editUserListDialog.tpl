<form action="Function/resConf/user/userList.php" method="POST" id="editUserListForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="vip" value="<{if $vip === 'checked="checked"'}>1<{else}>0<{/if}>"/>
    <fieldset>
        <legend>用户列表维护</legend>
        <div class="row">
            <label for="userListName">用户名称:<em class="required">*</em></label>
            <input type="text" name="userListName" maxlength="15" value="<{$userList.user_name}>" class="width132"
            <{if $type === 'edit'}>disabled="disabled"<{/if}> id="userListName"/>
            <{if $type ==='edit'}>
            	<input type="hidden" name="userListName" value="<{$userList.user_name}>"/>
            <{/if}>
        </div>
        <br class="clearFloat"/>
        <hr/>
        <div class="row">
            <label for="authType">认证方式:<em class="required">*</em></label>
            <div class="column column_75">
                <input class="radio" type="radio" name="authType" value="local-pwd" id="localPwd" <{$localPwd}>/>
                <label for="localPwd">本地密码认证</label>
                <br/>
                <!--<input class="radio" type="radio" name="authType" value="local-cert" id="localCert" <{$localCwd}>/>
                <label for="localCert">本地证书认证</label>
                <br/>-->
                <input class="radio" type="radio" name="authType" value="dyn-pwd" id="dynpwd" <{$twofa}>/>
                <label for="twofa" class="longLabel">双因子认证(动态密码 + 本地密码)</label>
                <br/>
               <input class="radio" type="radio" name="authType" value="vip" id="vip" <{$vip}>/>
                <label for="vip" class="longLabel">免认证(必须绑定IP, MAC中的一项!)</label>
            </div>
        </div>
        <br class="clearFloat"/>
        <hr/>
        <{if $type === 'edit' && $vip!=='checked="checked"'}>
	    	<div class="row">
	    		<label>修改密码:</label>
	    		<input class="checkbox" name="modifyEnable" id="modifyEnable" type="checkbox" onclick="enablePasswd()"/> 	    		
    		</div>
    	<{/if}>
        <div class="row">
            <label for="passwd">登录密码:</label>
            <input type="password" name="passwd_user" id="passwd_user" class="width132"
                <{if $type === 'edit'}> disabled="disabled" <{/if}> value="<{$userList.passwd}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="passwd_again">重复密码:</label>
            <input type="password" name="passwd_user_again" class="width132"
                <{if $type === 'edit'}> disabled="disabled" <{/if}> id="passwd_user_again" value="<{$userList.passwd}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="sn">导入SN文件:</label>
            <{include file='layout/upload.tpl' name='sn' id='sn'}>
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
            <input type="text" name="realName" id="realName" class="width132"
                value="<{$userList.true_name}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="bindIp">绑定IP:</label>
            <input type="text" name="bindIp" id="bindIp" class="width132"
                value="<{$userList.bind_ip4}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="bindMac">绑定MAC:</label>
            <input type="text" name="bindMac" id="bindMac" class="width132"
                value="<{$userList.bind_mac}>"/>
        </div>
        <br class="clearFloat"/>
        <div id="userModifyDiv" class="row">
            <label>用户更改密码:</label>
            <{if $paramsConf.forcemodify eq '1'}>
                <input class="radio" type="radio" name="modifyPwdAllow" value="on" id="mpa_on" checked="checked"/>
            <{else}>
                <input class="radio" type="radio" name="modifyPwdAllow" value="on" id="mpa_on" <{$mpa_on}>/>
            <{/if}>
            <label class="radioLabel" for="mpa_on">启动</label>
            <{if $paramsConf.forcemodify neq '1'}>
            <input class="radio" type="radio" name="modifyPwdAllow" value="off" id="mpa_off" <{$mpa_off}>/>
            <label class="radioLabel" for="mpa_off">不启用</label>
            <{/if}>
            <br class="clearFloat"/>
        </div>        
        <div id="firstModifyDiv" class="row">
            <label>首次登录密码修改:</label>
            <{if $paramsConf.forcemodify eq '1'}>
            <input class="radio" type="radio" name="firstChangePwd" value="on" id="fcp_on" checked="checked"/>
            <{else}>
            <input class="radio" type="radio" name="firstChangePwd" value="on" id="fcp_on" <{$fcp_on}>/>
            <{/if}>
            <label class="radioLabel" for="fcp_on">启动</label>
            <{if $paramsConf.forcemodify neq '1'}>
            <input class="radio" type="radio" name="firstChangePwd" value="off" id="fcp_off" <{$fcp_off}>/>            
            <label class="radioLabel" for="fcp_off">不启用</label>
            <{/if}>
            <br class="clearFloat"/>
        </div>        
        <div id="userValidTimeDiv" class="row">
            <label for="validTime">用户有效时间(单位:天):</label>
            <input type="text" name="validTime" id="validTime" class="width132"
                value="<{$userList.validtime|default: '0'}>"/>
            <br class="clearFloat"/>
        </div>        
        <div id="psswdValidTimeDiv" class="row">
            <label for="validTime_pwd">密码有效时间(单位:天):</label>
            <input type="text" name="validTime_pwd" id="validTime_pwd" class="width132"
                value="<{$userList.passvaliddate|default: '0'}>"/>
            <br class="clearFloat"/>
        </div>        
        <div class="row">
            <label for="connectRule">接入控制:</label>
            <{html_options id="connectRule" name="connectRule"
                options=$connectRuleArr selected=$userList.connect_rule}>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>状态:</label>
            <input class="radio" type="radio" name="active" id="active_on" value="on" <{$active_on}>/>
            <label class="radioLabel" for="active_on">启动</label>
            <input class="radio" type="radio" name="active" id="active_off" value="off" <{$active_off}>/>

            <label class="radioLabel" for="active_off">不启用</label>
        </div>
       
       
        <div class="row">
            <label for="comment">备注:</label>
            <input class="comment" name="comment" id="comment" value="<{$userList.comment|escape}>"/>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editUserListForm"));
    $(':radio[name="authType"]').click(function() {
        changeAuthType();
    });
    $(':radio[name="modifyPwdAllow"]').click(function() {
        allowPwdModify();
    });
    var uploadWid =  $('#sn').width();
    $('.uploadText').width(uploadWid - 75);
    $('#allRoles').dblclick(function(){
        	moveToSpecRole();
        });
        $('#rolesMember').dblclick(function(){
        	moveToAllRoles();
        });
});
</script>
