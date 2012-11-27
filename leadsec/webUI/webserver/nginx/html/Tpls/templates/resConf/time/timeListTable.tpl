<{foreach $timeList as $t }>
    <tr>
        <td><{$t.id}></td>
        <td><{$t.name}></td>
        <td><{$t.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditTimeListDialog('<{$t.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelTimeListDialog('<{$t.name}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='4'>No Time List Data</td></tr>
<{/foreach}>
