<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="userPrivilegeTable">
    <caption>
          用户权限
    </caption>
    <thead>
    <tr>
      <th class="column_10" >序号</th>
      <th class="column_30" name="username">用户名</th>
      <th class="column_20" name="send_pri">发送权限</th>
      <th class="column_20" name="recv_pri">接收权限</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="5">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewUserPriDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/msgTrans/userPrivilege.php'}>
</div>
<script type="text/javascript" src="Public/js/client/msgTrans/userPrivilege.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/msgTrans/userPrivilege.php', $('#userPrivilegeTable'), 'ORDER BY username ASC LIMIT 10');
        sortTableInit($('#userPrivilegeTable'), {0: {sorter: false},4: {sorter: false}}, [[1,0]]);
    });
</script>