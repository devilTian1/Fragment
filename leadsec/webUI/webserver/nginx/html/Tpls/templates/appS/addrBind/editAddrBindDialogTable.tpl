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
		<td colspan='4'>No Data</td>
	</tr>
<{/foreach}>
