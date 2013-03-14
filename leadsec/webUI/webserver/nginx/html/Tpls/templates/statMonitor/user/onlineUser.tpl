<{include file='layout/search.tpl' tableId='userOnlineTable'}>
<table class="column_95 textMid tablesorter" id="userOnlineTable">
    <caption>在线用户</caption>
    <thead>
    <tr>
        <th class="column_10" name="user_id">序号</th>
        <th class="column_10" name="user_name">用户名称</th>
        <th class="column_10" name="auth_type">认证方式</th>
        <th class="column_10" name="role_name">所属角色</th>
        <th class="column_10" name="ip">登陆IP</th>
        <th class="column_10" name="online_time">在线时间</th>
        <th class="column_15" name="logon_time">登陆时间</th>
        <th class="column_25">操作</th>
    </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan='8'>Loading ... ...</td>
        </tr>
    </tbody>
</table>

<button class="standard floatLeft" style="position: static"
    onclick="refreshAllOnlineUserDialog()"
    id="refAllOnlineUserBtn">刷新
</button>
<button class="standard floatLeft" style="position: static"
    onclick="DelAllOnlineUserDialog()"
    id="DelAllOnlineUserBtn">全部下线
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/statMonitor/user/onlineUser.php'}>
</div>
<script type="text/javascript" src="Public/js/statMonitor/user/onlineUser.js"></script> 
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/statMonitor/user/onlineUser.php', $('#userOnlineTable'), 'ORDER BY user_name ASC LIMIT 10');
        sortTableInit($('#userOnlineTable'),
        {0: {sorter: false}, 7: {sorter: false}}, [[1,0]]);
                        
    });
</script>
