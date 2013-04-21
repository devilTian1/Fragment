<{include file='layout/search.tpl' tableId='virtualAddrTable'}>
<table class="column_95 textMid tablesorter" id="virtualAddrTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">序号</th>
            <th class="column_20" name="ifname">网络接口</th>
            <th class="column_50">虚拟地址/掩码</th>
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
    onclick="openNewVirtualAddrDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/networkManagement/virtualAddr/virtualAddr.php'}>
</div>
<script type="text/javascript" src="Public/js/networkManagement/virtualAddr/virtualAddr.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/networkManagement/virtualAddr/virtualAddr.php',
            $('#virtualAddrTable'), 'ORDER BY ifname ASC LIMIT 10');
        sortTableInit($('#virtualAddrTable'), {0: {sorter: false}, 2: {sorter: false}, 3: {sorter: false}}, [[0,0]]);
    });
</script>
