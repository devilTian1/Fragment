<{include file='layout/search.tpl' tableId='safeBrowse_extendTable'}>
<table class="column_95 textMid tablesorter" id="safeBrowse_extendTable">
    <caption>
           文件扩展名过滤
   </caption>
   <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20">名称</th>
      <th class="column_30">文件扩展名列表</th>
      <th class="column_20">备注</th>
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
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/safeBrowse_extend.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/safeBrowse_extend.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/safeBrowse_extend.php', $('#safeBrowse_extendTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#safeBrowse_extendTable'), {4: {sorter: false}}, [[0,0]]);
    });
</script>