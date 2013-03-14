<{foreach $res as $d}>
    <tr>
        <td><input type="checkbox" name="checkSpecPolicy"/></td>
        <td><{$d@index+1}></td>
        <td><{$d.auth_policy_name}></td>
        <td>
            <{if $d.sa_type eq 1}>
                <{$d.ip}>
            <{elseif $d.sa_type eq 2}>
                <{$d.ip|cat:'/'|cat: $d.netmask}>
            <{elseif $d.sa_type eq 3}>
                <{$d.ip|cat:' - '|cat: $d.netmask}>
            <{elseif $d.sa_type eq 4 || $d.sa_type eq 5 || $d.sa_type eq 6}>
                <{$d.sa_id}>
            <{/if}>
        </td>
        <td><{$d.ingress}></td>
        <td><{$d.port}></td>
        <td>
            <form action="Function/resConf/user/auth.php"
                method="POST" id="switchAuthPolicyForm_<{$d@index+1}>"
                onSubmit="return false;">
                <input type="hidden" name="switch_name" value="<{$d.auth_policy_name}>"/>
                <{if $d.active eq 1 || $d.active eq 'Y'}>
                    <a href="#" onClick="switchAuthPolicyAcl('<{$d.auth_policy_name}>', 'disable', '<{$d@index+1}>')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="action" value="disable"/>
                    </a>
                <{else}>
                    <a href="#" onClick="switchAuthPolicyAcl('<{$d.auth_policy_name}>', 'enable', '<{$d@index+1}>')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                        width="16" height="16"/>
                        <input type="hidden" name="action" value="enable"/>
                    </a>
                <{/if}>
            </form>
        </td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditAuthPolicyDialog('<{$d.auth_policy_name}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelAuthPolicyDialog('<{$d.auth_policy_name}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='7'>No Auth Policy Data</td></tr>
<{/foreach}>
