<{foreach $userOnline as $k => $u }>
    <tr>
        <td><{$u.user_id}></td>
        <td><{$u.user_name}></td>
        <td>
        <{if ($u.auth_type == '0')}>
	                     免认证&nbsp;
	    <{/if}>
	    <{if ($u.auth_type == '1')}>
	                     本地密码认证&nbsp;
	    <{/if}>
	    <{if ($u.auth_type == '5')}>
	                     双因子认证&nbsp;
	    <{/if}>	   
        </td>
        <td><{$u.role_name}></td>
        <td><{$u.ip}></td>        
        <td><{$u.online_time}></td>
        <td><{$u.logon_time}></td>
        <td class="no_search">       
            <button class="standard" style="position: static" type="button"
                onclick="onlineUserToDownDialog('<{$u.user_name}>')"
                id="lockUserBtn">
            	强制下线
            </button>
            <button class="standard" style="position: static" type="button"
                onclick="onlineUserToLockDialog('<{$u.user_name}>')"
                id="resetPwdBtn">
           		锁定
            </button>
            <button class="standard" style="position: static" type="button"
                onclick="onlineUserTimeResetDialog('<{$u.user_name}>')"
                id="resetPwdBtn">
           		 重置时间
            </button>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='8'>No online user Data</td></tr>
<{/foreach}>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
    });
</script>
