<{foreach $ruleList as $key => $val }>
    <tr>
        <td class="no_search"><input type="checkbox" name="checkSpecRole"/></td>
        <td><{$val@index+1}></td>
        <td><{$val.rule_name}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditSpecRuleDialog('<{$val.rule_name}>')" title="编辑">编辑</a>
            <a href="#" class="delete" onclick="openDelSpecRuleDialog('<{$val.rule_name}>')" title="删除">删除</a>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='4'>没有接入控制信息</td></tr>
<{/foreach}>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        $("input:checkbox[name='checkSpecRole']").click(function() {
            dynCheckbox();
        });
    });
</script>
