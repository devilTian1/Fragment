<{foreach $shareDir as $r }>
    <tr>
        <td><{$r.task_id}></td>
        <td>
            <{if $r.mode === 'C'}>
            发送
            <{else}>
            接收
            <{/if}>
        </td>
        <td><{$r.ip}></td>
        <td><{$r.share_name}></td>
        <td><{$r.fs}></td>
        <td class="no_search">
            <a href="#" class="detail"
                onclick="showShareDirDialog('<{$r.task_id}>')">详情</a>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>No Data</td></tr>
<{/foreach}>
