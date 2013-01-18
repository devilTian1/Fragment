<{include file='layout/search.tpl' tableId='allowedFileTable'}>
<form action="Function/client/fileSync/allowedFile.php" method="POST"
    id="ctlForm" onSubmit="return false;">
    <input type="hidden" name="ctl" value="1">
    <label for="namefilter">
        <input type="checkbox" name="namefilter" id="namefilter"
            onClick="switchCtl()"/>
        启用文件名控制
    </label>
    &nbsp;&nbsp;&nbsp;
    <label for="binfile">
        <input type="checkbox" name="binfile" id="binfile"
            onClick="switchCtl()"/>
        允许二进制文件
    </label>
</form>
<table class="column_95 textMid tablesorter" id="allowedFileTable">
    <caption>文件名控制</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">序号</th>
            <th class="column_60" name="filename">允许以下文件名</th>
            <th class="column_20" name="comment">备注</th>
            <th class="column_10">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="4">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewAllowedFileDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl'
        func='Function/client/fileSync/allowedFile.php'}>
</div>
<script type="text/javascript" src="Public/js/client/fileSync/allowedFile.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/fileSync/allowedFile.php',
            $('#allowedFileTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#allowedFileTable'), {3: {sorter: false}}, [[0,0]]);
    });
</script>
