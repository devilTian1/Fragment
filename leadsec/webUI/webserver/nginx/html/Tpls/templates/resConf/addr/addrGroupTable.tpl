<{foreach $addrGroup as $k => $ag }>
    <tr>
        <td><{$ag.id}></td>
        <td><{$ag.name}></td>
        <td><{$ag.addrNames}></td>
        <td title="<{$ag.comment|escape}>"><{$ag.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditAddrGroupDialog('<{$ag.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelAddrGroupDialog('<{$ag.fullName}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>无数据</td></tr>
<{/foreach}>
