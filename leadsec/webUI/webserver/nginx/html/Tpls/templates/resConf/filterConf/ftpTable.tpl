<{foreach $ftpFilterOptions as $r}>
    <tr>
        <td><{$r.name}></td>
        <td>
            <{if $r.user_info === '' && $r.user_act === '1'}>
                允许所有全部用户
            <{else if $r.user_info === '' && $r.user_act === '0'}>
                禁止所有全部用户
            <{else if $r.user_act === '1'}>
                禁止:&nbsp;<{$r.user_info}>
            <{else}>
                允许:&nbsp;<{$r.user_info}>
            <{/if}>
        </td>
        <td>
            <{if $r.cmd_info === '' && $r.cmd_act === '1'}>
                允许所有全部命令
            <{else if $r.cmd_info === '' && $r.cmd_act === '0'}>
                禁止所有全部命令
            <{else if $r.cmd_act === '1'}>
                禁止:&nbsp;
                <{$r.cmd_info}>
            <{else}>
                允许:&nbsp;
                <{$r.cmd_info}>
            <{/if}>
        </td>
        <td>
            <{if $r.virus === 'Y' || $r.virus === '1'}>
            开启
            <{else}>
            关闭
            <{/if}>
        </td>
        <td><{$r.comment}></td>
        <td class="no_search">
            <a href="#" class="edit"
            onclick="editFtpFilterOptionsDialog('<{$r.id}>')">
                编辑</a>
            <a href="#" class="delete"
            onclick="delFtpFilterOptionsDialog('<{$r.id}>', '<{$r.name}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>No Data</td></tr>
<{/foreach}>
