<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="localUsrAuthenTable">
    <caption>
           本地用户认证
    </caption>
    <thead>
    <tr>
      <th class="column_20" >序号</th>
      <th class="column_60" name="username">用户名</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="3">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewLocalUsrAuthenDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/msgTrans/localUserAuthen.php'}>
</div>
<script type="text/javascript" src="Public/js/client/msgTrans/localUserAuthen.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/msgTrans/localUserAuthen.php', $('#localUsrAuthenTable'), 'ORDER BY username ASC LIMIT 10');
        sortTableInit($('#localUsrAuthenTable'), {0: {sorter: false},2: {sorter: false}}, [[1,0]]);
    });
</script>