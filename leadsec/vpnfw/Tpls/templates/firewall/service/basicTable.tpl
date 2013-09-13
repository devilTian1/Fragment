<{foreach $basicList as $basic }>
<tr>
        <td><input type="hidden" value='<{$basic.name}>'>
            <input class="checkSon" type="checkbox"/></td>
        <td><{$basic.id}></td>
        <td><{$basic.name}></td>
        <td><{$basic.comment}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="openEditBasicListDialog('<{$basic.id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delBasic('<{$basic.name}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>无数据</td></tr>
<{/foreach}>
