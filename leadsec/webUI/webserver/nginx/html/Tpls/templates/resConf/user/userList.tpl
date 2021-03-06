<{include file='layout/search.tpl' colNames='user_id,user_name,true_name,validtime,dyn_sn,comment'}>
<table class="column_95 textMid tablesorter" id="userListTable">
    <caption>用户列表</caption>
    <thead>
    <tr>
        <th class="column_5"><input type="checkbox" onClick="checkAllUser()" title="全选" id="checkAllUser"/></th>
        <th class="column_5" name="user_id">序号</th>
        <th class="column_5" name="user_name">名称</th>
        <th class="column_10" name="true_name">真实姓名</th>
        <th class="column_5">状态</th>
        <th class="column_10" name="validtime">有效截止日期</th>
        <th class="column_8">SN文件</th>
        <th class="column_8">动态密码</th>
        <th class="column_10" name="dyn_sn">唯一SN号码</th>
        <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan='10'>Loading ... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewUserListDialog()"
    id="addUserListBtn">新建
</button>
<button class="standard floatLeft" style="position: static"
    onclick="openDelAllUserListDialog()"
    id="DelAllUserListBtn">删除所有用户
</button>
<button class="standard floatLeft" style="position: static"
    onclick="openDelSpecUserListDialog()"
    id="DelSpecUserListBtn">删除已选用户
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/user/userList.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/user/userList.js"></script> 
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/user/userList.php', $('#userListTable'), 'ORDER BY user_id ASC LIMIT 10');
        sortTableInit($('#userListTable'),
        {0: {sorter: false}, 6: {sorter: false}, 7: {sorter: false}, 
            9: {sorter: false}},[[1,0]]);
    });
</script>
