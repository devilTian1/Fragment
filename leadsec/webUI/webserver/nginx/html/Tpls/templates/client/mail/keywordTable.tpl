<{foreach $keyword as $key => $array }>
    <tr>
        <td><{$key+1}></td>        
        <td><{$array.name}></td>
        <td><{$array.value}></td>
        <td><{$array.type}></td>
        <td><{$array.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditKeywordDialog('<{$array.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelKeywordDialog('<{$array.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>No Data</td></tr>
<{/foreach}>
