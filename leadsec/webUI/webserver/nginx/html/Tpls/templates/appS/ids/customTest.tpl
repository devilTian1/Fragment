<{include file='layout/search.tpl' tableId='customTestTable'}>
<table class="column_95 textMid tablesorter" id="customTestTable">
    <caption>
  	自定义检测
    </caption>
    <thead>
        <tr>
            <th class="column_8">序号</th>
            <th class="column_10">源地址</th>
            <th class="column_10">端口</th>
            <th class="column_15">目的地址 </th>
            <th class="column_10">端口</th>
            <th class="column_10">协议类型</th>
            <th class="column_10">事件主题</th>
			<th class="column_10">状态</th>
            <th class="column_17">操作</th>
        </tr>
    </thead>
    <tbody>
    	<tr>
     		<td colspan='8'>Loading ... ...</td>
		</tr>
    </tbody>
</table>
  <button class="standard floatLeft" style="position: static"
    onclick="openNewCustomTestDialog()"
    id="addAlias">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/appS/ids/customTest.php'}>
</div>

<script type="text/javascript" src="Public/js/appS/ids/customTest.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    freshTable('Function/appS/ids/customTest.php', $('#customTestTable'));
    sortTableInit($('#customTestTable'), {7: {sorter: false}});
});
</script>

