<{foreach $addrList as $addr }>
    <tr>
        <td><{$beginId++}></td>
        <td><{$addr.name}></td>
        <td>
        	<{if $addr.name == 'any'}>
        		--
            <{else if $addr.type == 1}>
                <{$addr.ip}>/<{$addr.mask}>
            <{else if $addr.type == 2}>
                <{$addr.ip}> - <{$addr.mask}>
            <{else}>
                Error
            <{/if}>
        </td>
        <td title="<{$addr.comment|escape}>"><{$addr.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
        	<{if $addr.name != 'any'}>
            	<a href="#" class="edit" onclick="openEditAddrListDialog('<{$addr.id}>')">编辑</a>
            	<a href="#" class="delete" onclick="openDelAddrDialog('<{$addr.name}>', '<{$addr.id}>')">删除</a> 
            <{/if}>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>无数据</td></tr>
<{/foreach}>
