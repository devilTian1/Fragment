<{include file='layout/search.tpl' tableId='safeBrowse_urlTable'}>
<table class="column_95 textMid tablesorter" id="safeBrowse_urlTable">
 <caption>
    URL过滤
 </caption>
<thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_10">名称</th>
      <th class="column_30">url列表</th>
      <th class="column_30">备注</th>
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
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/safeBrowse_url.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/safeBrowse_url.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/safeBrowse_url.php', $('#safeBrowse_urlTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#safeBrowse_urlTable'), {4: {sorter: false}}, [[0,0]]);
    });
</script>