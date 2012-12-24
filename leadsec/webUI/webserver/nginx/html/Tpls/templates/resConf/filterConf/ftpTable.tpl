<{foreach $ftpFilterOptions as $r}>
    <tr>
        <td><{$r.name}></td>
        <td><{$r.user_info}></td>
        <td><{$r.cmd_info}></td>
        <td>
            <{if $r.virus === 'Y' || $r.virus === '1'}>
            开启
            <{else}>
            关闭
            <{/if}>
        </td>
        <td><{$r.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditAddrListDialog('<{$r.name}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelAddrDialog('<{$r.name}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Address Data</td></tr>
<{/foreach}>
