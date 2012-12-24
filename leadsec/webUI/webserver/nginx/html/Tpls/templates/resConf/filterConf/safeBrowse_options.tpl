<{include file='layout/search.tpl' tableId='safeBrowse_optionsTable'}>
<table class="column_95 textMid tablesorter" id="safeBrowse_optionsTable">
    <caption>
           过滤选项集
    </caption>
    <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_10">名称</th>
      <th class="column_10">URL过滤</th>
      <th class="column_10">MIME类型过滤</th>
      <th class="column_10">文件扩展名过滤</th>
      <th class="column_10">文件病毒扫描</th>
      <th class="column_10">流病毒扫描</th>
      <th class="column_10">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tr>
      <tr>
      <td colspan="9">Loading……</td>
    </tr>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/safeBrowse_options.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/safeBrowse_options.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/safeBrowse_options.php', $('#safeBrowse_optionsTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#safeBrowse_optionsTable'), {8: {sorter: false}}, [[0,0]]);
    });
</script>