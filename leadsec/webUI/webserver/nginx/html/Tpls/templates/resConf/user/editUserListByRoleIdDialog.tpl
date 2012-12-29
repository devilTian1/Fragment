<table class="column_95 textMid tablesorter" id="userListTable">
    <caption></caption>
    <thead>
    <tr>
        <th class="column_5" name="user.user_id">序号</th>
        <th class="column_10" name="user.user_name">名称</th>
        <th class="column_10" name="user.true_name">真实姓名</th>
        <th class="column_15" name="user.auth_type">认证方式</th>
        <th class="column_10">所属角色</th>
        <th class="column_15">是否在线</th>
        <th class="column_15">登录IP</th>
        <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan='8'>Loading ... ...</td>
        </tr>
    </tbody>
</table>
<div class="pager floatRight" id="userListDiv">
    <{include file='layout/pagination.tpl' func='Function/resConf/user/userList.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/user/userList.js"></script> 
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/user/roleList.php?id=<{$roleId}>', $('#userListTable'),
            'ORDER BY user.user_id ASC LIMIT 10', $('#userListDiv'));
        sortTableInit($('#userListTable'),
            {4: {sorter: false}, 5: {sorter: false}, 6: {sorter: false},
                7: {sorter: false}},[[0,0]]);
    });
</script>
