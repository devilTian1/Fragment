<{include file='layout/search.tpl' colNames='ip,interval,task_id'}>
<table class="column_95 textMid tablesorter" id="sendTaskTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_10" name="task_id">任务号</th>
            <th class="column_10" name="ip">服务器地址</th>
            <th class="column_10" name="share_name">服务器共享名</th>
            <th class="column_10" name="fs">文件系统</th>
            <th class="column_10" name="method">传输方式</th>
            <th class="column_10" name="subdir">包含子目录</th>
            <th class="column_10" name="killvirus">文件病毒扫描</th>
            <th class="column_10" name="interval">同步间隔</th>
            <th class="column_10" name="active">是否启动</th>
            <th class="column_10">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="10">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewSendTaskDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl'
        func='Function/client/fileEx/sendTask.php'}>
</div>
<script type="text/javascript" src="Public/js/client/fileEx/sendTask.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/fileEx/sendTask.php',
            $('#sendTaskTable'), 'ORDER BY task_id ASC LIMIT 10');
        sortTableInit($('#sendTaskTable'), {9: {sorter: false}}, [[0,0]]);
    });
</script>
