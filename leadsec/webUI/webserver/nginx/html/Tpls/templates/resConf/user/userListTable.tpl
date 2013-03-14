<{foreach $userList as $name => $u }>
    <tr>
        <td class="no_search"><input type="checkbox" name="checkSpecUser"/></td>
        <td><{$u.user_id}></td>
        <td><{$u.user_name}></td>
        <td><{$u.true_name}></td>
        <td>
            <form action="Function/resConf/user/userList.php"
                method="POST" id="switchUserActiveForm_<{$u.user_id}>"
                onSubmit="return false;">
                <input type="hidden" name="userName" value="<{$u.user_name}>"/>
                <{if $u.active === '1'}>
                    <a href="#" onClick="switchUserActive('<{$u.user_id}>', 'disable','<{$u.user_name}>')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="activeChk" value="erro"/>
                    </a>
                <{else}>
                    <a href="#" onClick="switchUserActive('<{$u.user_id}>', 'enable','<{$u.user_name}>')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"  width="16" height="16"/>
                        <input type="hidden" name="activeChk" value="ok"/>
                    </a>
                <{/if}>
            </form>
        </td>
        <td><{$u.validtime}></td>
        <td class="no_search">
            <{if $u.auth_type === '5'}>
                <a href="#" onClick="openImportSnFileDialog('<{$u.user_name}>')">导入</a>
            <{/if}>
        </td>
        <td class="no_search">
            <{if $u.auth_type === '5'}>
                <a href="#" onClick="openActiveSpecUserDialog('<{$u.user_name}>')">同步</a>
            <{/if}>
        </td>
        <td><{if $u.auth_type === '5'}><{$u.dyn_sn}><{/if}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditSpecUserDialog('<{$u.user_name}>')" title="更改状态">&nbsp;</a>
            <a href="#" class="delete" onclick="openDelSpecUserDialog('<{$u.user_name}>')" title="删除">&nbsp;</a>&nbsp;&nbsp;
            <button class="standard" style="position: static" type="button"
                onclick="openLockSpecUserDialog('<{$u.user_name}>')"
                id="lockUserBtn">
            锁定用户
            </button>
            <{if $u.auth_type === '1' || $u.auth_type === '5'}>
	            <button class="standard" style="position: static" type="button"
	                onclick="openResetSpecUserPwdDialog('<{$u.user_name}>')"
	                id="resetPwdBtn">
	            重置密码
	            </button>
            <{/if}>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='10'>No User List Data</td></tr>
<{/foreach}>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        $("input:checkbox[name='checkSpecUser']").click(function() {
            dynCheckbox();
        });
    });
</script>
