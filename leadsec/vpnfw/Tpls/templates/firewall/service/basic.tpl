<{include file='layout/search.tpl' width=400 height=300
    dialogFunc="index.php?R=firewall/service/basic/openAdvSearchDialog"
    searchFunc="index.php?R=firewall/service/basic/freshTableAndPagination"
    tableDom="$('#basicTable')" pageDom="$('div.pager')" }>
<table class="column_95 textMid tablesorter" id="basicTable">
    <caption>基本服务</caption>
    <thead>
        <tr>
       		<th class="column_10" name="checkall"><input class="checkAll" type="checkbox"
                    onClick="$(this).checkAll()"/></th>
            <th class="column_10" name="id">序号</th>
            <th class="column_20">服务名</th>
            <th class="column_20">协议</th>
            <th class="column_30">备注</th>
            <th class="column_10">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="6">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewBasicDialog()">添加
</button>
<button class="standard floatLeft" style="position: static"
    onclick="openBatchHandlerDialog('index.php?R=firewall/service/basic/batchDel')">删除 
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='index.php?R=firewall/service/basic/freshTableAndPagination'}>
</div>
<script type="text/javascript" src="Public/js/firewall/service/basic.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
		sortTableInit($('#basicTable'), [4,5], [[1,0]]);
    	initTable('index.php?R=firewall/service/basic/initTable', $('#basicTable'));
    });
</script>
