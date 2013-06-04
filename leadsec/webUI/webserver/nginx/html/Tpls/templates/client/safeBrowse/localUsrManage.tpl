<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="localUsrManageTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20" name="name">用户名</th>
      <th class="column_40" name="comment">备注</th>
      <th class="column_30">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="4">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewLocalUsrManageDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/safeBrowse/localUsrManage.php'}>
</div>
<script type="text/javascript" src="Public/js/client/safeBrowse/localUsrManage.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/safeBrowse/localUsrManage.php', $('#localUsrManageTable'), 'ORDER BY name ASC LIMIT 10');
        sortTableInit($('#localUsrManageTable'), {0: {sorter: false},3: {sorter: false}}, [[1,0]]);
    });
</script>