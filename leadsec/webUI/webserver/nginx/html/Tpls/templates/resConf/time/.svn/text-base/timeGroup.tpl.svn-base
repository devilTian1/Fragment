<{include file='layout/search.tpl' tableId='timeGroupTable'}>
<table class="column_95 textMid tablesorter" id="timeGroupTable">
    <caption>时间组</caption>
    <thead>
        <tr>
            <th class="column_10">序号</th>
            <th class="column_20" name="name">名称</th>
            <th class="column_20">时间组成员</th>
            <th class="column_30">备注</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan='5'>Loading ... ...</td>
        </tr>
   </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewTimeGroupDialog()"
    id="addTimeGroupBtn">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/time/timeGroup.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/time/timeGroup.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/time/timeGroup.php', $('#timeGroupTable'), 'ORDER BY name ASC LIMIT 10');
        sortTableInit($('#timeGroupTable'), {0: {sorter: false}, 2: {sorter: false}, 3: {sorter: false}, 
            4: {sorter: false}}, [[1,0]]);
    });
</script>
