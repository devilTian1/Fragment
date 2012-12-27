<{foreach $roleList as $name => $u }>
    <tr>
        <td class="no_search"><input type="checkbox" name="checkSpecRole"/></td>
        <td><{$u.role_id}></td>
        <td><{$u.role_name}></td>
        <td><{$u.create_by}></td>
        <td><{$u.create_time}></td>
        <td><{$u.time}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditSpecRoleDialog('<{$u.role_name}>')" title="编辑">&nbsp;</a>
            <a href="#" class="delete" onclick="openDelSpecRoleDialog('<{$u.role_name}>')" title="删除">&nbsp;</a>&nbsp;&nbsp;
            <button class="standard" style="position: static" type="button" onClick="alert(123)">查看用户</button>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='7'>No Role List Data</td></tr>
<{/foreach}>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        $("input:checkbox[name='checkSpecRole']").click(function() {
            dynCheckbox();
        });
    });
</script>
