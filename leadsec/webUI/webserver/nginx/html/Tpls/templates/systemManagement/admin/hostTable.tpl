    <{foreach $hosts as $id => $host }>
        <tr>
            <td><{$id+1}></td>
            <td><{$host.ip}></td>
            <td><{$host.netmask}></td>
			<td title="<{$host.comment|escape}>" ><{$host.comment|escape|truncate:30:"... ..."}></td>
            <td>
	        <a href="#" class="edit" onclick="openEditHostDialog('<{$id+1}>')">编辑</a>
		    &nbsp;&nbsp;&nbsp;
		    <a href="#" class="delete" onclick="openDelHostDialog('<{$host.ip}>', '<{$host.netmask}>')">删除</a>
	    </td>
        </tr>
    <{foreachelse}>
        <tr><td colspan='5'>没有管理主机</td></tr>
    <{/foreach}>
	<input type = 'hidden' id = "hostnum" value="<{count($hosts)}>"/>

