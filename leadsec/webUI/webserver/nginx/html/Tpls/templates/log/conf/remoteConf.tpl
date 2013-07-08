<{include file='layout/search.tpl'}>
<table class="column_95 textMid tablesorter" id="remoteLogServerTable">
    <caption>
          远程日志服务器
    </caption>
    <thead>
    <tr>
      <th class="column_20" name="logsrv">服务器IP</th>
      <th class="column_20" name="port">端口</th>
      <th class="column_20" >协议</th>
      <th class="column_20" >备注</th>
      <th class="column_20" >操作</th>
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
    <{include file='layout/pagination.tpl' func='Function/log/conf/remoteConf.php'}>
</div>
<script type="text/javascript" src="Public/js/log/conf/remoteConf.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/log/conf/remoteConf.php', $('#remoteLogServerTable'), 'ORDER BY logsrv ASC LIMIT 10');
        sortTableInit($('#remoteLogServerTable'), {2: {sorter: false}, 3: {sorter: false}, 4: {sorter: false}}, [[0,0]]);
    });
</script>