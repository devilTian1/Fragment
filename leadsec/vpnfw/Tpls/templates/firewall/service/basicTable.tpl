<{foreach $list as $r }>
<tr>
        <td><input name="checkflag" type="checkbox" value="" /></td>
        <td><{$r.ip}></td>
        <td><{$r.mask}></td>
        <td><{$r.ipv6}></td>
        <td><{$r.ipv6_mask}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editFilterDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="openDelDialog()">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>无数据</td></tr>
<{/foreach}>
