<{include file='layout/search.tpl' tableId='ipDetectTable'}>
<table class="column_95 textMid tablesorter" id="ipDetectTable">
    <caption>IP探测信息列表</caption>
    <thead>
        <tr>
            <th class="column_10">序号</th>
            <th class="column_20" name="ip">探测IP</th>
            <th class="column_50" name="comment">备注</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="4">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewipDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/networkManagement/HA/ipDetect.php'}>
</div>
<script type="text/javascript" src="Public/js/networkManagement/HA/ipDetect.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/networkManagement/HA/ipDetect.php',$('#ipDetectTable'),'ORDER BY ip ASC LIMIT 10');
		sortTableInit($('#ipDetectTable'), {0: {sorter: false}, 2: {sorter: false}, 3: {sorter: false}}, [[0,0]]);
    });
</script>
