<{foreach $bannedContent as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.context}></td>
        <td><{$r.comment}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editBannedContentDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delBannedContentDialog('<{$r.id}>', '<{$r.context}>')">删除</a> 
        </td>

    </tr>
<{foreachelse}>
    <tr><td colspan='4'>No Data</td></tr>
<{/foreach}>
