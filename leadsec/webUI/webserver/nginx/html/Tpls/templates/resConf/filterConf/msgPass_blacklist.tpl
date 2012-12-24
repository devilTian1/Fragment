<table class="column_95">
    <tr>
      <td class="tdbody">
      <label>
        <input type="checkbox" name="checkbox" id="checkbox" />启动黑名单控制
      </label>
      </td>
    </tr>
</table>
<{include file='layout/search.tpl' tableId='msgPass_blacklistTable'}>
<table class="column_95 textMid tablesorter" id="msgPass_blacklistTable">
<caption>
      内容黑名单
   </caption>
   <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_70">禁止以下内容</th>
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
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/msgPass_blacklist.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/msgPass_blacklist.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/msgPass_blacklist.php', $('#msgPass_blacklistTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#msgPass_blacklistTable'), {2: {sorter: false}}, [[0,0]]);
    });
</script>