<{foreach $UsrMng as $key => $array }>
    <tr>
        <td><{$key+1}></td>        
        <td><{$array.name}></td>  
        <td><{$array.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditLocalUsrManageDialog('<{$array.name}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelLocalUsrManageDialog('<{$array.name}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='4'>No Data</td></tr>
<{/foreach}>
