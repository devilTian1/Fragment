<{foreach $attach as $key => $array }>
    <tr>
        <td><{$key+1}></td>        
        <td><{$array.name}></td>
        <td><{$array.value}></td>
        <td title="<{$array.comment|escape}>"><{$array.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditAttachExtDialog('<{$array.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelAttachExtDialog('<{$array.id}>', '<{$array.name}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Data</td></tr>
<{/foreach}>
