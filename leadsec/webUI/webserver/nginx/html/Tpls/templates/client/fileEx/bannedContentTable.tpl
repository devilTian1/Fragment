<{foreach $bannedContent as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.name}></td>
        <td><{$r.context}></td>
        <td title="<{$r.comment|escape}>"><{$r.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editBannedContentDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delBannedContentDialog('<{$r.id}>', '<{$r.name}>')">
                删除</a> 
        </td>

    </tr>
<{foreachelse}>
    <tr><td colspan='5'>无数据</td></tr>
<{/foreach}>
