<form action="Function/appS/addrBind/addrBind.php" method="POST" id="addrBindDialogForm"
	onSubmit="return false;">
<{include file='layout/search.tpl' tableId='userListTable'}>
<table class="column_95 textMid tablesorter" id="userListTable">
    <caption>探测到的 IP/MAC 对</caption>
    <thead>
    <tr>
        <th class="column_5"><input type="checkbox" onClick="checkAll()" title="全选" id="checkAllUser"/></th>
        <th class="column_5" name="user_id">ip</th>
        <th class="column_5" name="user_name">MAC</th>
        <th class="column_10" name="true_name">网口</th>
    </tr>
    </thead>
    <{foreach $array_value as $k => $val}>
        <tr>
			<td class="no_search"><input type="checkbox" name="checkSpecUser"/></th>
            <td><{$val.0}></td>
            <td><{$val.1}></td>
            <td><{$val.2}></td>
        </tr>
    <{foreachelse}>
        <tr><td colspan='4'>No Data</td></tr>
    <{/foreach}>
</table>
<script type="text/javascript" src="Public/js/appS/addrBind/editAddrBindDialog.js"></script> 
<script type="text/javascript"> 
    
</script>