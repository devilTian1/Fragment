<{include file='layout/search.tpl' colNames='task_id,ip,share_name,fs'}>
<table class="column_95 textMid tablesorter" id="shareDirTable">
    <caption>共享目录</caption>
    <thead>
        <tr>
            <th class="column_10" name="task_id">任务号</th>
            <th class="column_20" name="mode">发送/接收</th>
            <th class="column_20" name="ip">服务器IP</th>
            <th class="column_20" name="share_name">服务器共享名</th>
            <th class="column_20" name="fs">文件系统</th>
            <th class="column_10">详情</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="6">Loading... ...</td>
        </tr>
    </tbody>
</table>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl'
        func='Function/client/fileEx/shareDir.php'}>
</div>
<script type="text/javascript" src="Public/js/client/fileEx/shareDir.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/fileEx/shareDir.php',
            $('#shareDirTable'), 'ORDER BY task_id ASC LIMIT 10');
        sortTableInit($('#shareDirTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>
