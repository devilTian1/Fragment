<{include file='layout/search.tpl' tableId='timeListTable'}>
<table class="column_95 textMid tablesorter" id="timeListTable">
    <caption>时间列表</caption>
    <thead>
    <tr>
        <th class="column_10">序号</th>
        <th class="column_30">名称</th>
        <th class="column_40">备注</th>
        <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan='4'>Loading ... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewTimeListDialog()"
    id="addTimeListBtn">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/time/timeList.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/time/timeList.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/time/timeList.php', $('#timeListTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#addrTable'), {3: {sorter: false}}, [[0,0]]);
    });
</script>
