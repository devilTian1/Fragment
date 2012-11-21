<{foreach $addrGroup as $ag }>
    <tr>
        <td><{$ag.id}></td>
        <td><{$ag.name}></td>
        <td><{$ag.member}></td>
        <td><{$addr.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditAddrGroupDialog('<{$addr.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelAddrGroupDialog('<{$addr.name}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Address Group Data</td></tr>
<{/foreach}>
