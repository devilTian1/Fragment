<form action="Function/resConf/user/roleList.php" method="POST" id="editRoleListForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>角色列表维护</legend>
        <div class="row">
            <label for="roleName">用户名称:<em class="required">*</em></label>
            <input type="text" name="roleName" id="roleName" value="<{$roleData.role_name}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>创建者:</label>
            <{$roleData.create_by|default: $smarty.session.account}>
            <input type="hidden" name="createBy"
                value="<{$roleData.create_by|default: $smarty.session.account}>"/>
        </div>
        <div class="row">
            <label>创建时间:</label>
            <{$roleData.create_time|default: $smarty.now|date_format:"%Y/%m/%d"}>
            <input type="hidden" name="createTime"
                value="<{$roleData.create_time|default: $smarty.now|date_format:"%Y/%m/%d"}>"/>
        </div>
        <div class="row">
            <label for='allocatedTime'>分配时间:</label>
            <input type="text" name="allocatedTime" id="allocatedTime"
                value="<{$roleData.time|default:0}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for='alwaysOnline'>在线保持:</label>
            <input class="checkbox" type="checkbox" name="alwaysOnline" id="alwaysOnline"
                title="配置该参数后, 该角色下的用户将不做空闲时间判断, 不会自动注销."
                <{$roleData.always_online|default:''}>/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>用户数:</label>
            <{$roleData.userCount|default:0}>
        </div>
        <div class="row">
            <label for="comment">备注:</label>
            <input class="comment" name="comment" id="comment" value="<{$roleData.comment}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript" src="Public/js/resConf/user/roleList.js"></script>
<script  type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editRoleListForm"));
});
</script>
