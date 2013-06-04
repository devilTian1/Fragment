 <{foreach $upgradeList as $key => $val}>
	<tr>
		<td><{$val.id}></td>
		<td><{$val.up_version}></td>
		<td><{iconv('gb2312','utf-8',$val.del_bugs)}></td>
		<td><{$val.up_time}></td>
	</tr>
<{foreachelse}>
    <tr><td colspan='4'>ÎÞÊý¾Ý</td></tr>
<{/foreach}>

<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi(); 
    });
</script>
