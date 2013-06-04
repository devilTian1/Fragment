<{foreach $UsrMng as  $array }>
    <tr>
        <td><{$array@iteration}></td>        
        <td><{$array.username}></td>  
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditLocalUsrAuthenDialog('<{$array.username}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelLocalUsrAuthenDialog('<{$array.username}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='3'>无数据</td></tr>
<{/foreach}>
