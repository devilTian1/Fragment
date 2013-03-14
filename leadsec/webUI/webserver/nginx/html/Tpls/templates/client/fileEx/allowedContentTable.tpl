<{foreach $allowedContent as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.name}></td>
        <td><{$r.context}></td>
        <td><{$r.comment}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editAllowedContentDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delAllowedContentDialog('<{$r.id}>', '<{$r.name}>')">
                删除</a> 
        </td>

    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Data</td></tr>
<{/foreach}>
