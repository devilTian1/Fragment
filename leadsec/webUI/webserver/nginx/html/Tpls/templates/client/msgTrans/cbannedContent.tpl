<{include file='layout/search.tpl'}>
<form action="Function/client/msgTrans/cbannedContent.php" method="POST"
    id="blackListForm" onSubmit="return false;">
    <label for="banlist">
         <{if $status.blacklist_status eq Y}>
	      		<input type="checkbox" checked="checked" onClick="switchBlackChk('off')" name="blacklist" id="blacklist">
	            <input id="action_chk" type="hidden" name="action_chk" value="off"/>
	      <{/if}>
	      <{if $status.blacklist_status eq N}>
	      		<input type="checkbox"   onClick="switchBlackChk('on')" name="blacklist" id="blacklist">
	            <input id="action_chk" type="hidden" name="action_chk" value="on"/>
	      <{/if}>
    启用黑名单控制
</label>
</form>
<table class="column_95 textMid tablesorter" id="bannedContentTable">
    <caption>内容黑名单</caption>
    <thead>
        <tr>
            <th class="column_20" >序号</th>
            <th class="column_60" name="blacklist">禁止以下内容</th>
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
    onclick="openNewBannedContentDialog()">添加
</button>
<div class="pager floatRight" id="bannedContentPage">
    <{include file='layout/pagination.tpl'
        func='Function/client/msgTrans/cbannedContent.php'}>
</div>

<script type="text/javascript" src="Public/js/client/msgTrans/cbannedContent.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/msgTrans/cbannedContent.php',
            $('#bannedContentTable'), 'ORDER BY blacklist ASC LIMIT 10');
        sortTableInit($('#bannedContentTable'), {0: {sorter: false},2: {sorter: false}}, [[1,0]]);
    });
</script>
