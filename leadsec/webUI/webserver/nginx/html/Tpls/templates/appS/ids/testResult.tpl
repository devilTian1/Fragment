<{include file='layout/search.tpl' tableId='testResultTable' colNames='event'}>
<table class="column_95 textMid tablesorter" id="testResultTable">
    <caption>显示检测结果</caption>
    <thead>
        <tr>
            <th class="column_10">行号</th>
            <th class="column_10">时间</th>
            <th class="column_15">攻击者</th>
            <th class="column_15">被攻击者</th>
            <th class="column_10">协议类型</th>
            <th class="column_30">事件主题</th>
            <th class="column_10">风险级别</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan='7'>Loading ... ...</td>
        </tr>
    </tbody>
</table>
<form class="inline" action="Function/appS/ids/testResult.php" method="POST"
    id="cleanLogForm">
	<input type="hidden" name="action" value="cleanAuthLog"/>
    <button class="inputbtn standard" type="button" onclick="cleanLog()">
        清空</button>
</form>
<script type="text/javascript" src="Public/js/appS/ids/testResult.js"></script> 
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/appS/ids/testResult.php'}>
</div>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/appS/ids/testResult.php',
            $('#testResultTable'), "LIMIT 10 OFFSET 0");
    });
</script>
