<{include file='layout/search.tpl' tableId='bannedContentTable'}>
<form action="Function/client/fileSync/bannedContent.php" method="POST"
    id="ctlForm" onSubmit="return false;">
    <input type="hidden" name="ctl" value="1">
    <label for="banlist">
        <input type="checkbox" name="banlist"
            id ="banlist" onClick="switchCtl()"/>
    启用黑名单控制
</label>
<table class="column_95 textMid tablesorter" id="bannedContentTable">
    <caption>内容黑名单</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">序号</th>
            <th class="column_60" name="context">禁止以下内容</th>
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
    onclick="openNewBannedContentDialog()">添加
</button>
<div class="pager floatRight" id="bannedContentPage">
    <{include file='layout/pagination.tpl'
        func='Function/client/fileSync/bannedContent.php'}>
</div>

<script type="text/javascript" src="Public/js/client/fileSync/bannedContent.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/fileSync/bannedContent.php',
            $('#bannedContentTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#bannedContentTable'), {3: {sorter: false}}, [[0,0]]);
    });
</script>
