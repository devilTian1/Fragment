<{foreach $postfixFilter as $key => $array }>
    <tr>
        <td><{$key+1}></td>        
        <td><{$array.list}></td>
        <td title="<{$array.comment|escape}>"><{$array.comment|escape|truncate:40:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditPostfixFilterDialog('<{$array.list}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelPostfixFilterDialog('<{$array.list}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='4'>No Data</td></tr>
<{/foreach}>
