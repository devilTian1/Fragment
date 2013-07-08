<{foreach $ftpFilterOptions as $r}>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.name}></td>
        <td>
            <{if $r.user_info === '' && $r.user_act === '1'}>
                允许所有全部用户
            <{else if $r.user_info === '' && $r.user_act === '0'}>
                禁止所有全部用户
            <{else if $r.user_act === '1'}>
                允许:&nbsp;<{$r.user_info|truncate: 20: '...'}>
            <{else}>
                禁止:&nbsp;<{$r.user_info|truncate: 20: '...'}>
            <{/if}>
        </td>
        <td>
            <{if $r.cmd_info === '' && $r.cmd_act === '1'}>
                允许所有全部命令
            <{else if $r.cmd_info === '' && $r.cmd_act === '0'}>
                禁止所有全部命令
            <{else if $r.cmd_act === '1'}>
                允许:&nbsp;
                <{$r.cmd_info}>
            <{else}>
                禁止:&nbsp;
                <{$r.cmd_info}>
            <{/if}>
        </td>       
        <td title="<{$r.comment|escape}>" ><{$r.comment|escape|truncate:30:"... ..."}></td>
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
    <tr><td colspan='6'>无数据.</td></tr>
<{/foreach}>
