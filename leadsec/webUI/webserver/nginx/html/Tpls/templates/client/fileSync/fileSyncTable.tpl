<{foreach $fileSyncClientAcl as $r}>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.sa}></td>
        <td><{$r.lip}></td>
        <td><{$r.lport}></td>
        <td>
            <{if $r.ssl === 'Y'}>
            是
            <{else if $r.ssl === 'N'}>
            否
            <{else}>
                <{$r.ssl}>
            <{/if}>
        </td>
        <td><{$r.commname}></td>
        <td>
            <{if $r.mode === 'Q'}>
            快速转发
            <{else if $r.mode === 'B'}>
            本地备份
            <{else}>
                <{$r.mode}>
            <{/if}>

        </td>
        <td>
            <{if $r.killvirus === 'Y'}>
            是
            <{else if $r.killvirus === 'N'}>
            否
            <{else}>
                <{$r.killvirus}>
            <{/if}>
        </td>
        <td><{$r.time}></td>
        <td><{$r.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="editFileSyncClientAclDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete" onclick="delFileSyncClientAclDialog('<{$r.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='11'>No Data</td></tr>
<{/foreach}>
