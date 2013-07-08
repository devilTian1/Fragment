<{foreach $keyword as $key => $array }>
    <tr>
        <td><{$key+1}></td>        
        <td><{$array.name}></td>
        <td><{$array.value}></td>
        <td>
            <{if $array.type == '主题'}>
                                          主题           
            <{else}>
                                        正文
            <{/if}>
        </td>
        <td title="<{$array.comment|escape}>"><{$array.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditKeywordDialog('<{$array.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelKeywordDialog('<{$array.id}>', '<{$array.name}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>无数据</td></tr>
<{/foreach}>
