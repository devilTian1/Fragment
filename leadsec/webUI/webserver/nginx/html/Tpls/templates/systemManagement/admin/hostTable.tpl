    <{foreach $hosts as $host }>
        <tr>
            <td><{$host.id}></td>
            <td><{$host.ip}></td>
            <td><{$host.netmask}></td>
            <td><{$host.comment}></td>
            <td>
	        <a href="#" class="edit" onclick="openEditHostDialog('<{$host.id}>')">编辑</a>
		    &nbsp;&nbsp;&nbsp;
		    <a href="#" class="delete" onclick="openDelHostDialog('<{$host.ip}>', '<{$host.netmask}>')">删除</a>
	    </td>
        </tr>
    <{foreachelse}>
        <tr><td colspan='4'>No Host</td></tr>
    <{/foreach}>

