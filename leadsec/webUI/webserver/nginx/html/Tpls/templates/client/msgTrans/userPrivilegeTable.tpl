<{foreach $UsrMng as  $array }>
    <tr>
        <td><{$array@iteration}></td>        
        <td><{$array.username}></td> 
        <td>
            <{if $array.send_pri == 'Y'}>
                                          是           
            <{else}>
                                         否
            <{/if}>
        </td>
        <td>
            <{if $array.recv_pri == 'Y'}>
                                          是           
            <{else}>
                                         否
            <{/if}>
        </td> 
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditUserPriDialog('<{$array.username}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelUserPriDialog('<{$array.username}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Data</td></tr>
<{/foreach}>
