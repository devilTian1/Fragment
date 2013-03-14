<{foreach $timeGroup as $name => $t }>
    <tr>
        <td><{$t@iteration}></td>
        <td><{$name}></td>
        <td><{foreach $t.subname as $subname}>
        <{$subname}><br/>
        <{foreachelse}>
        无
        <{/foreach}></td>
        <td><{$t.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditTimeGroupDialog('<{$name}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelTimeGroupDialog('<{$name}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Time Group Data</td></tr>
<{/foreach}>
