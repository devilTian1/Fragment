<{foreach $timeList as $name => $t }>
    <tr>
        <td><{$t@iteration}></td>
        <td><{$t.name}></td>
        <td title="<{$t.comment|escape}>" ><{$t.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditTimeListDialog('<{$t.name}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelTimeListDialog('<{$t.name}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='4'>No Time List Data</td></tr>
<{/foreach}>
