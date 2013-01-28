<{foreach $res as $value }>
    <tr>
        <td><{$value.name}></td>        
        <td>
            <{if $value.allow == 'A'}>
                                          允许           
            <{else}>
                                          阻止
            <{/if}>
        </td>
        <td><{$value.sqllist}></td>
         <td><{$value.comment}></td>
        <td class="no_search">
           <a href="#" class="edit" onclick="openEditDialog('<{$value.id}>')">编辑</a>
           <a href="#" class="delete" onclick="openDelDialog('<{$value.name}>','<{$value.id}>')">
                删除</a>            
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Data</td></tr>
<{/foreach}>
