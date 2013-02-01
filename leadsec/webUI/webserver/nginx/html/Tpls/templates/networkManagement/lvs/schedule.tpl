<{include file='layout/search.tpl' tableId='scheduleTable'}>
<table class="column_95 textMid tablesorter" id="scheduleTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">序号</th>
            <th class="column_20" name="virtual_ip">虚拟地址</th>
            <th class="column_10" name="virtual_port">虚拟端口</th>
            <th class="column_50">真实地址/端口</th>
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
            $('#scheduleTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#scheduleTable'), {3: {sorter: false}, 4: {sorter: false}}, [[0,0]]);
    });
</script>
