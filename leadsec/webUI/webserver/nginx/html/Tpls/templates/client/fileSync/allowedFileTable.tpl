<{foreach $allowedFile as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.filename}></td>
        <td><{$r.comment}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editAllowedFileDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delAllowedFileDialog('<{$r.id}>', '<{$r.filename}>')">
                删除</a> 
        </td>

    </tr>
<{foreachelse}>
    <tr><td colspan='4'>No Data</td></tr>
<{/foreach}>
