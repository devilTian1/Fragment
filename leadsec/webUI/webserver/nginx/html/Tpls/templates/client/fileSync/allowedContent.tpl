<{include file='layout/search.tpl' tableId='allowedContentTable'}>
<form action="Function/client/fileSync/allowedContent.php" method="POST"
    id="ctlForm" onSubmit="return false;">
    <input type="hidden" name="ctl" value="1">
    <label for="allowlist">
        <input type="checkbox" name="allowlist"
            id ="allowlist" onClick="switchCtl()"/>
    启用白名单控制
</label>
<table class="column_95 textMid tablesorter" id="allowedContentTable">
    <caption>内容白名单</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">序号</th>
            <th class="column_60" name="context">允许以下内容</th>
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
    onclick="openNewAllowedContentDialog()">添加
</button>
<div class="pager floatRight" id="allowedContentPage">
    <{include file='layout/pagination.tpl'
        func='Function/client/fileSync/allowedContent.php'}>
</div>
<script type="text/javascript" src="Public/js/client/fileSync/allowedContent.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/fileSync/allowedContent.php',
            $('#allowedContentTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#allowedContentTable'), {3: {sorter: false}}, [[0,0]]);
    });
</script>
