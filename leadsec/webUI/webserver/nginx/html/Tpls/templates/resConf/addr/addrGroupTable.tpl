<{foreach $addrGroup as $k => $ag }>
    <tr>
        <td><{$ag.id}></td>
        <td><{$ag.name}></td>
        <td><{$ag.addrNames}></td>
        <td><{$ag.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditAddrGroupDialog('<{$ag.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelAddrGroupDialog('<{$ag.name}>','<{$ag.id}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Address Group Data</td></tr>
<{/foreach}>
