<{foreach $fileSyncServerAcl as $r}>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.serverip}></td>
        <td><{$r.sport}></td>
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
        <td><{$r.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="editFileSyncServerAclDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete" onclick="delFileSyncServerAclDialog('<{$r.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='8'>无数据</td></tr>
<{/foreach}>
