<{include file='layout/search.tpl' tableId='filterTable'}>
<table class="column_95 textMid tablesorter" id="filterTable">
    <caption>文件属性控制</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">序号</th>
            <th class="column_20" name="name">名称</th>
            <th class="column_20" name="filename">文件名控制</th>
            <th class="column_20" name="blacklist">内容黑名单</th>
            <th class="column_20" name="whitelist">内容白名单</th>
            <th class="column_10">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="6">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewFilterDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl'
        func='Function/client/fileEx/filter.php'}>
</div>
<script type="text/javascript" src="Public/js/client/fileEx/filter.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/fileEx/filter.php',
            $('#filterTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#filterTable'), {5: {sorter: false}}, [[0,0]]);
    });
</script>
