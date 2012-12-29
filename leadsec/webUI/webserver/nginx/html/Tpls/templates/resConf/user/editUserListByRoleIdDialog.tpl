<table class="column_95 textMid tablesorter" id="userListTable">
    <caption></caption>
    <thead>
        <tr>
            <th class="column_5" name="userId">序号</th>
            <th class="column_10" name="name">名称</th>
            <th class="column_10" name="realname">真实姓名</th>
            <th class="column_15" name="authType">认证方式</th>
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
<div class="pager floatRight" id="userPageDiv">
    <{include file='layout/pagination.tpl' func='Function/resConf/user/roleList.php?id='|cat: $roleId
        tableDom='$("#userListTable")' pageDom='$("#userPageDiv")'}>
</div>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/user/roleList.php?id=<{$roleId}>', $('#userListTable'),
            'ORDER BY userId ASC LIMIT 10', $('#userPageDiv'));
        sortTableInit($('#userListTable'),
            {4: {sorter: false}, 5: {sorter: false}, 6: {sorter: false},
                7: {sorter: false}},[[0,0]]);
    });
</script>
