<{include file='layout/search.tpl' tableId='addrTable'}>
<table class="column_95 textMid tablesorter" id="addrTable">
    <caption>
  	地址列表
    </caption>
    <thead>
        <tr>
            <th class="column_10" name="id">序号</th>
            <th class="column_20" name="name">名称</th>
            <th class="column_30" name="ip">地址</th>
            <th class="column_20" name="comment">备注</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan='5'>Loading ... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewAddrListDialog()"
    id="addAddr">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addr/addrList.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addr/addrList.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        appendAddrList();
        sortTableInit($('#addrTable'), {4: {sorter: false}}, [[0,0]]);
    });
</script>
