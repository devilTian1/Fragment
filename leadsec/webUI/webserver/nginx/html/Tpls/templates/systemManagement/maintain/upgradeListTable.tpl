 <{foreach $upgradeList as $key => $val}>
	<tr>
		<td><{$val.id}></td>
		<td><{$val.up_version}></td>
		<td><{$val.del_bugs}></td>
		<td><{$val.up_time}></td>
	</tr>
<{foreachelse}>
    <tr><td colspan='4'>No Data</td></tr>
<{/foreach}>

<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi(); 
    });
</script>