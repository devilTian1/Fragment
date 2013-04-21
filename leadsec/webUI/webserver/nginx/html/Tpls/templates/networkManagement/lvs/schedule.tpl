<{include file='layout/search.tpl' tableId='scheduleTable'}>
<table class="column_95 textMid tablesorter" id="scheduleTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_10">序号</th>
            <th class="column_20" name="virtual_ip">虚拟地址</th>
            <th class="column_10" name="virtual_port">虚拟端口</th>
            <th class="column_15">真实地址1</th>
            <th class="column_10">端口1</th>
            <th class="column_15">真实地址2</th>
            <th class="column_10">端口2</th>
            <th class="column_10">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="8">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewRealAddrDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/networkManagement/lvs/schedule.php'}>
</div>
<script type="text/javascript" src="Public/js/networkManagement/lvs/schedule.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/networkManagement/lvs/schedule.php',
            $('#scheduleTable'), 'ORDER BY virtual_ip ASC LIMIT 10');
        sortTableInit($('#scheduleTable'), {0: {sorter: false},3: {sorter: false}, 4: {sorter: false},5: {sorter: false}, 6: {sorter: false}, 7: {sorter: false}}, [[1,0]]);

    });
</script>
