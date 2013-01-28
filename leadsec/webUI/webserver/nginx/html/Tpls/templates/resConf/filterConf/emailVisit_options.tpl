<{include file='layout/search.tpl' tableId='emailVisit_optionsTable'}>
<table class="column_95 textMid tablesorter" id="emailVisit_optionsTable">
    <caption>
           过滤选项集
    </caption>
    <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_10">名称</th>
      <th class="column_10">协议</th>
      <th class="column_10">主题关键字</th>
      <th class="column_10">正文关键字</th>
      <th class="column_20">文件病毒扫描</th>
      <th class="column_10">流病毒扫描</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tr>
      <td colspan="8">Loading……</td>
    </tr>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/emailVisit_options.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/emailVisit_options.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/emailVisit_options.php', $('#emailVisit_optionsTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#emailVisit_optionsTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>