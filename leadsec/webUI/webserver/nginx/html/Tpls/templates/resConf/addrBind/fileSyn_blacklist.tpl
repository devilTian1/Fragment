<table class="column_95">
    <tr>
      <td class="tdbody">
      <label>
        <input type="checkbox" name="checkbox" id="checkbox" />启动黑名单控制
      </label>
      </td>
    </tr>
</table>
<{include file='layout/search.tpl' tableId='fileSyn_blacklistTable'}>
<table class="column_95 textMid tablesorter" id="fileSyn_blacklistTable">
<caption>
      内容黑名单
   </caption>
   <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_40">禁止以下内容</th>
      <th class="column_30">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
     <tr>
      <td colspan="4">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/fileSyn_blacklist.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/fileSyn_blacklist.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/fileSyn_blacklist.php', $('#fileSyn_blacklistTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#fileSyn_blacklistTable'), {3: {sorter: false}}, [[0,0]]);
    });
</script>