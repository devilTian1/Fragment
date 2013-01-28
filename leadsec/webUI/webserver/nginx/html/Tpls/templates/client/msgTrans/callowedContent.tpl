<{include file='layout/search.tpl' tableId='allowedContentTable'}>
<form action="Function/client/msgTrans/callowedContent.php" method="POST"
    id="ctlForm" onSubmit="return false;">
    <input type="hidden" name="ctl" value="1">
    <label for="banlist">
        <input type="checkbox" name="whilist"
            id ="whilist" onClick="switchCtl()"/>
    启用白名单控制
</label>
</form>
<table class="column_95 textMid tablesorter" id="allowedContentTable">
    <caption>内容白名单</caption>
    <thead>
        <tr>
            <th class="column_20" >序号</th>
            <th class="column_60" name="whitelist">禁止以下内容</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="3">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewAllowedContentDialog()">添加
</button>
<div class="pager floatRight" id="allowedContentPage">
    <{include file='layout/pagination.tpl'
        func='Function/client/msgTrans/callowedContent.php'}>
</div>

<script type="text/javascript" src="Public/js/client/msgTrans/callowedContent.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/msgTrans/callowedContent.php',
            $('#allowedContentTable'), 'ORDER BY whitelist ASC LIMIT 10');
        sortTableInit($('#allowedContentTable'), {0: {sorter: false},2: {sorter: false}}, [[1,0]]);
    });
</script>
