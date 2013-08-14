<{include file='layout/search.tpl' colNames='name,context,comment'}>
<table class="column_95 textMid tablesorter" id="bannedContentTable">
    <caption>内容黑名单</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">序号</th>
            <th class="column_10" name="name">名称</th>
            <th class="column_50" name="context">禁止以下内容</th>
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
    onclick="openNewBannedContentDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl'
        func='Function/client/fileEx/bannedContent.php'}>
</div>
<script type="text/javascript" src="Public/js/client/fileEx/bannedContent.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/fileEx/bannedContent.php',
            $('#bannedContentTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#bannedContentTable'), {4: {sorter: false}}, [[0,0]]);
    });
</script>
