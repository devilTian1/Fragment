<{foreach $userData as $u}>
    <tr>
        <td><{$u.user_id}></td>
        <td><{$u.user_name}></td>
        <td><{$u.true_name}></td>
        <td><{$u.auth_type}></td>
        <td><{$u.roles}></td>
        <td>bb</td>
        <td>aa</td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditSpecUserDialog('<{$u.user_name}>')" title="修改">&nbsp;</a>
            <a href="#" class="delete" onclick="openDelSpecUserDialog('<{$u.user_name}>')" title="删除">&nbsp;</a>&nbsp;&nbsp;
            <button class="standard" style="position: static" type="button"
                onclick="openLockSpecUserDialog('<{$u.user_name}>')"
                id="lockUserBtn">
            锁定用户
            </button>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='8'>无记录</td></tr>
<{/foreach}>
<input type="hidden" name="roleId" value="<{$roleId}>"/>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
    });
</script>
