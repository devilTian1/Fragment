<{foreach $allowedFile as $r }>
    <tr>
        <td><{$r@iteration}></td>
        <td title="<{$r.filename|escape}>"><{$r.filename|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editAllowedFileDialog('<{$r.filename}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delAllowedFileDialog('<{$r.filename}>')">
                删除</a> 
        </td>

    </tr>
<{foreachelse}>
    <tr><td colspan='3'>无数据</td></tr>
<{/foreach}>
