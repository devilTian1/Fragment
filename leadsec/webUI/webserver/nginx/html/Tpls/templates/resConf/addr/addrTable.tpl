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
