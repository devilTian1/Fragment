<{include file='layout/search.tpl' colNames='name,comment'}>
<table class="column_95 textMid tablesorter" id="addrGroupTable">
    <caption>
  	地址组
    </caption>
    <thead>
        <tr>
            <th class="column_10" name="id">序号</th>
            <th class="column_10" name="name">名称</th>
            <th class="column_40">成员</th>
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
    onclick="openNewAddrGroupDialog()"
    id="addAddrGroup">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addr/addrGroup.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addr/addrGroup.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addr/addrGroup.php', $('#addrGroupTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#addrGroupTable'), {2: {sorter: false}, 4: {sorter: false}}, [[0,0]]);
    });
</script>
