<{foreach $bannedContent as $r }>
    <tr>
        <td><{$r@iteration}></td>
        <td><{$r.blacklist}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editBannedContentDialog('<{$r.blacklist}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delBannedContentDialog('<{$r.blacklist}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='3'>无数据</td></tr>
<{/foreach}>
