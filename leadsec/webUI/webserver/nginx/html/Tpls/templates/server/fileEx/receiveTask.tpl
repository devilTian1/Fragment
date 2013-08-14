<{include file='layout/search.tpl' colNames='task_id,ip,share_name,fs'}>
<table class="column_95 textMid tablesorter" id="receiveTaskTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_20" name="task_id">任务号</th>
            <th class="column_20" name="ip">服务器地址</th>
            <th class="column_20" name="share_name">服务器共享名</th>
            <th class="column_20" name="fs">文件系统</th>
            <th class="column_10" name="active">是否启动</th>
            <th class="column_10">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="6">Loading... ...</td>
        </tr>
    </tbody>
</table>
<form action="Function/server/fileEx/receiveTask.php"
	method="POST" id="switchReceiveTaskAddButton" onSubmit="return false;">
    <button class="standard floatLeft" style="position: static"
        onclick="openNewReceiveTaskDialog()">添加
    </button>
</form>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl'
        func='Function/server/fileEx/receiveTask.php'}>
</div>
<script type="text/javascript" src="Public/js/server/fileEx/receiveTask.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/server/fileEx/receiveTask.php',
            $('#receiveTaskTable'), 'ORDER BY task_id ASC LIMIT 10');
        sortTableInit($('#receiveTaskTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>
