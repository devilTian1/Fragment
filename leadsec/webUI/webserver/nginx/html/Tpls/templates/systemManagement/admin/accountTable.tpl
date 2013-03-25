    <{foreach $accounts as $value }>
        <tr>
            <td><{$value['account']}></td>
	    <td>
	    <{if ($value.super == '1')}>
	        <span class="red">超级管理员</span>&nbsp;
	    <{/if}>
	    <{if ($value.manager == '1')}>
	        配置管理员&nbsp;
	    <{/if}>
	    <{if ($value.policyer == '1')}>
	        策略管理员&nbsp;
	    <{/if}>
	    <{if ($value.auditor == '1')}>
	        审计管理员
	    <{/if}>
	    </td>
            <td>
	        <a href="#" class="edit" onclick="openEditUserDialog('<{$value["account"]}>')">编辑</a>
		<{if ($value.super === '0')}>
		    &nbsp;&nbsp;&nbsp;
		    <a href="#" class="delete" onclick="openDelUserDialog('<{$value["account"]}>')">删除</a>
		<{/if}>
	    </td>
        </tr>
    <{foreachelse}>
        <tr><td colspan='3'>No Accounts</td></tr>
    <{/foreach}>