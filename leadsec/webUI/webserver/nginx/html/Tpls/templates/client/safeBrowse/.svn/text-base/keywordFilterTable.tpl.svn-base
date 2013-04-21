<{foreach $keywordFilter as $key => $array }>
    <tr>
        <td><{$key+1}></td>        
        <td><{$array.name}></td>
        <td><{$array.context|regex_replace: "/,/" : "<br>"}></td>
        <td title="<{$array.comment|escape}>"><{$array.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditKeywordFilterDialog('<{$array.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelKeywordFilterDialog('<{$array.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Data</td></tr>
<{/foreach}>
