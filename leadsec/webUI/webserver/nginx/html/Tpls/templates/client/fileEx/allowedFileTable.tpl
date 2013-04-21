<{foreach $allowedFile as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.name}></td>
        <td><{$r.filename}></td>
        <td title="<{$r.comment|escape}>"><{$r.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editAllowedFileDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delAllowedFileDialog('<{$r.id}>', '<{$r.name}>')">
                删除</a> 
        </td>

    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Data</td></tr>
<{/foreach}>
