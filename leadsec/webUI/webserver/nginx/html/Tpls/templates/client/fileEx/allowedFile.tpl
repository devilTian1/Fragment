<{include file='layout/search.tpl' tableId='allowedFileTable'}>
<table class="column_95 textMid tablesorter" id="allowedFileTable">
    <caption>文件名控制</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">序号</th>
            <th class="column_10" name="name">名称</th>
            <th class="column_50" name="filename">允许以下文件名</th>
            <th class="column_20" name="comment">备注</th>
            <th class="column_10">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="5">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewAllowedFileDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl'
        func='Function/client/fileEx/allowedFile.php'}>
</div>
<script type="text/javascript" src="Public/js/client/fileEx/allowedFile.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/fileEx/allowedFile.php',
            $('#allowedFileTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#allowedFileTable'), {4: {sorter: false}}, [[0,0]]);
    });
</script>
