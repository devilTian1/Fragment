<{foreach $bannedContent as $r }>
    <tr>
        <td><{$r@iteration}></td>
        <td><{$r.whitelist}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editAllowedContentDialog('<{$r.whitelist}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delAllowedContentDialog('<{$r.whitelist}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='3'>无数据</td></tr>
<{/foreach}>
