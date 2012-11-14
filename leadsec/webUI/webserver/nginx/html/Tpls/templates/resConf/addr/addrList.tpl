<{include file='layout/search.tpl' tableId='addrTable'}>
<table class="column_95 textMid tablesorter" id="addrTable">
    <caption>
  	地址列表
    </caption>
    <thead>
        <tr>
            <th class="column_10">序号</th>
            <th class="column_20">名称</th>
            <th class="column_30">地址</th>
            <th class="column_20">备注</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
    <{foreach $addrList as $addr }>
        <tr>
            <td><{$addr.id}></td>
            <td><{$addr.name}></td>
            <td><{$addr.ip}>/<{$addr.mask}></td>
            <td><{$addr.comment}></td>
            <td class="no_search">
                <a href="#" class="edit" onclick="openEditAddrListDialog('<{$addr.id}>')">编辑</a>
                <a href="#" class="delete" onclick="delRedundance()">
                    删除</a> 
            </td>
        </tr>
    <{foreachelse}>
        <tr><td colspan='5'>No Address Data</td></tr>
    <{/foreach}>
    </tbody>
</table>
<{include file='layout/pagination.tpl'}>
<button class="standard" onclick="openNewAddrListDialog()"
    id="addValue">添加
</button>
<script type="text/javascript" src="Public/js/resConf/addr/addrList.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        $('#addrTable').tablesorter({
            sortList: [[0,0]],
        }).tablesorterPager({container: $("#pager")}); 
    });
</script>
