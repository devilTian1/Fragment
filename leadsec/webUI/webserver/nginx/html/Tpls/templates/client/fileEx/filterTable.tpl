<{foreach $filter as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.name}></td>
        <td><{$r.filename}></td>
        <td><{$r.blacklist}></td>
        <td><{$r.whitelist}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editFilterDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delFilterDialog('<{$r.id}>', '<{$r.name}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>无数据</td></tr>
<{/foreach}>
