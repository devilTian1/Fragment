<{foreach $res as $value }>
    <tr>
        <td><{$value.name}></td>
        <td title="<{$value.usrnamelist|escape}>" ><{$value.usrnamelist|escape|truncate:90:"... ..."}></td>
        <td>
            <{if $value.allow == 'A'}>
                                          允许           
            <{else}>
                                         阻止                          
            <{/if}>
        </td>
        <td title="<{$value.comment|escape}>" ><{$value.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
           <a href="#" class="edit" onclick="openEditUserDialog('<{$value.name}>')">编辑</a>
           <a href="#" class="delete" onclick="openDelUserDialog('<{$value.name}>','<{$value.id}>')">
                删除</a>            
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>无数据</td></tr>
<{/foreach}>
