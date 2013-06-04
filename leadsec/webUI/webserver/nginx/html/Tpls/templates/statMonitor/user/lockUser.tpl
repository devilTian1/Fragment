<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="lockUserTable">
    <caption>
           锁定用户
    </caption>
    <thead>
    <tr>
      <th class="column_20" >序号</th>
      <th class="column_20" name="user_name">用户名称</th>
      <th class="column_20" name="role_name">所属角色</th>
      <th class="column_20" name="unlock_time">锁定结束时间</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="5">Loading……</td>
    </tr>
    </tbody>
  </table>

<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/statMonitor/user/lockUser.php'}>
</div>
<script type="text/javascript" src="Public/js/statMonitor/user/lockUser.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/statMonitor/user/lockUser.php', $('#lockUserTable'), 'ORDER BY user_name ASC LIMIT 10');
        sortTableInit($('#lockUserTable'), {0: {sorter: false}, 
            4: {sorter: false}}, [[1,0]]);
    });
</script>