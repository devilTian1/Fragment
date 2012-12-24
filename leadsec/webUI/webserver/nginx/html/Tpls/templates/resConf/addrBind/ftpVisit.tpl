<{include file='layout/search.tpl' tableId='ftpVisitTable'}>
<table class="column_95 textMid tablesorter" id="ftpVisitTable">
 <caption>
    FTP过滤选项
 </caption>
	<thead> 
        <tr>
          <th class="column_10">序号</th>
          <th class="column_20">用户控制</th>
          <th class="column_20">命令控制</th>
          <th class="column_20">文件病毒扫描</th>
          <th class="column_10">备注</th>
          <th class="column_20">操作</th>
        </tr>
    </thead>
	<tbody>
      <tr>
      <td colspan="6">Loading……</td>
    </tr>
      </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/ftpVisit.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/ftpVisit.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/ftpVisit.php', $('#ftpVisitTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#ftpVisitTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>