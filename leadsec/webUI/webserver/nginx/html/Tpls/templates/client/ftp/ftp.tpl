<{include file='layout/search.tpl' colNames='name,user_info,cmd_info,comment'}>
<table class="column_95 textMid tablesorter" id="ftpFilterOptionsTable">
 <caption>FTP过滤选项</caption>
	<thead> 
        <tr>
          <th class="column_10" name="id">序号</th>
          <th class="column_10" name="name">名称</th>
          <th class="column_25" name="user_info">用户控制</th>
          <th class="column_25" name="cmd_info">命令控制</th>       
          <th class="column_15" name="comment">备注</th>
          <th class="column_15">操作</th>
        </tr>
    </thead>
	<tbody>
        <tr>
            <td colspan="6">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewFtpFilterOptionsDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/ftp/ftp.php'}>
</div>
<script type="text/javascript" src="Public/js/client/ftp/ftp.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/ftp/ftp.php',
            $('#ftpFilterOptionsTable'), 'ORDER BY name ASC LIMIT 10');
        sortTableInit($('#ftpFilterOptionsTable'), {0: {sorter: false}, 5: {sorter: false}}, [[0,0]]);
    });
</script>
