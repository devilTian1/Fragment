<{foreach $remote as $value }>
    <tr>
        <td><{$value.logsrv}></td>
        <td><{$value.port}></td>
        <td><{$value.protocol}></td>
        <td title="<{$value.comment|escape}>" ><{$value.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditDialog('<{$value.logsrv}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelDialog('<{$value.logsrv}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>无数据</td></tr>
<{/foreach}>
