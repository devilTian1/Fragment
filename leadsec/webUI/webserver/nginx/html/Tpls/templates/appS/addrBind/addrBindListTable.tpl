<{foreach $sql_value_array as $k => $val}>
	<tr>
		<td class="no_search"><input type="checkbox" name="checkSpecIp"/></td>
		<td><{$val.ip}></td>
		<td><{$val.mac}></td>
		<td><{if $val.doubledir == 1}>Y<{else}>N<{/if}></td>
		<td class="no_search">
            <a href="#" class="edit" title="更改状态" onclick="edit('<{$val.id}>')">&nbsp;</a>
            <a href="#" class="delete" title="删除" onclick="openDelSpecIpDialog('<{$val.ip}>')">&nbsp;</a>&nbsp;&nbsp;
        </td>
	</tr>
<{foreachelse}>
	<tr>
		<td colspan='4'>无数据</td>
	</tr>
<{/foreach}>