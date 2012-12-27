<form action="Function/resConf/user/roleList.php" method="POST" id="editRoleListForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>角色列表维护</legend>
        <div class="row">
            <label for="roleName">用户名称:<em class="required">*</em></label>
            <input type="text" name="roleName" id="roleName" value="<{$role_name}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>创建者:</label>
            <{$smarty.session.account}>
            <input type="hidden" name="createBy" value="<{$smarty.session.account}>"/>
        </div>
        <div class="row">
            <label>创建时间:</label>
            <{$smarty.now|date_format:"%Y/%m/%d"}>
            <input type="hidden" name="createTime" value="<{$smarty.now|date_format:"%Y/%m/%d"}>"/>
        </div>
        <div class="row">
            <label for='allocatedTime'>分配时间:</label>
            <input type="text" name="allocatedTime" id="allocatedTime"
                value="<{$allocatedTime|default:0}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for='alwaysOnline'>在线保持:</label>
            <input class="checkbox" type="checkbox" name="alwaysOnline" id="alwaysOnline"
                title="配置该参数后, 该角色下的用户将不做空闲时间判断, 不会自动注销."
                <{$alwaysOnline|default:''}>/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>用户数:</label>
            <{$userCount|default:0}>
        </div>
        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$comment}></textarea>
        </div>
    </fieldset>
</form>
<script type="text/javascript" src="Public/js/resConf/user/userGroup.js"></script>
<script  type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editRoleListForm"));
});
</script>