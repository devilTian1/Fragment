<{foreach $userList as $name => $u }>
    <tr>
        <td class="no_search"><input type="checkbox" name="checkSpecUser"/></td>
        <td><{$u.user_id}></td>
        <td><{$u.user_name}></td>
        <td><{$u.true_name}></td>
        <td><{if $u.active === 1}>Y<{else}>N<{/if}></td>
        <td><{$u.validtime}></td>
        <td class="no_search"><a href="#">导入</a></td>
        <td class="no_search"><a href="#">同步</a></td>
        <td><{$u.dyn_sn}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditSpecUserDialog('<{$u.user_name}>')" title="更改状态">&nbsp;</a>
            <a href="#" class="delete" onclick="openDelSpecUserDialog('<{$u.user_id}>')" title="删除">&nbsp;</a>&nbsp;&nbsp;
            <button class="standard" style="position: static"
                onclick="openLockSpecUserDialog()"
                id="lockUserBtn">
            锁定用户
            </button>
            <button class="standard" style="position: static"
                onclick="openResetSpecUserPwdDialog()"
                id="resetPwdBtn">
            重置密码
            </button>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='10'>No User List Data</td></tr>
<{/foreach}>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
    });
</script>
