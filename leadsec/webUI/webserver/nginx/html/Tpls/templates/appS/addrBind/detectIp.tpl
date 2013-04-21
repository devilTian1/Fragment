<form action="Function/appS/addrBind/addrBind.php" method="POST" id="addrBindDialogForm"
	onSubmit="return false;">
<table class="column_95 textMid tablesorter" id="ipListTable">
    <caption>探测到的 IP/MAC 对</caption>
    <thead>
    <tr>
        <th class="column_5"><input type="checkbox" onClick="checkAll()" title="全选" id="checkAllUser"/></th>
		<th class="column_5" name="index_id">序号</th>
        <th class="column_5" name="ipaddress">ip</th>
        <th class="column_5" name="macaddress">MAC</th>
        <th class="column_10" name="fec">网口</th>
    </tr>
    </thead>
	<tdbody>
        <{foreach $array_value as $k => $val}>
		<tr>
			<td class="no_search"><input type="checkbox" name="checkSpecUser[]" value="<{$val@index}>"/></td>
			<td><{$val@index+1}></td>
			<td><{$val.0}></td>
			<td><{$val.1}></td>
			<td><{$val.2}></td>
		</tr>
		<{foreachelse}>
		<tr>
			<td colspan='5'>No Data</td>
		</tr>
		<{/foreach}>
	</tdbody>
</table>

<input type="hidden" name="action" id="action" value=''/>
<label>
<input type="checkbox" name="uniqueChk" id="uniqueChk" value=''/>
<input type="hidden" name="switch_chk" id="switch_chk" value=''/>
	唯一性检查
</label>
</form>
<script type="text/javascript" src="Public/js/appS/addrBind/addrBind.js"></script> 
<script type="text/javascript"> 
	$("#uniqueChk").click(function(){
		if($(this).attr("checked")){
			$("#switch_chk").val('on');
		} else {
			$("#switch_chk").val('');
		}					   
	});
	renderStandardUi();
</script>