<{foreach $list as $value }>
    <tr>
        <td><{$value@index+1}></td>
        <td><{$value.source_address}></td>
        <td><{$value.source_port}></td>
        <td><{$value.target_address}></td>
		<td><{$value.target_port}></td>
		<td><{$value.link_mode}></td>
		<td><{$value.txt_msg}></td>
        <td>
            <form action="Function/networkManagement/interface/physical.php" method="POST"
                id="switchPhyDevForm_<{$value@index}>" onSubmit="return false;">
                <input type="hidden" name="switch_id" value="<{$value.rule_id}>"/>
            <{if $value.active =='on'}>
                <a href="#" onClick="switchPhysicalDev('<{$value.rule_id}>', 'disable', '<{$value@index}>')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png"
                    width="16" height="16" />
                    <input type="hidden" name="action" value="disable"/>
                </a>
            <{else}>
                <a href="#" onClick="switchPhysicalDev('<{$value.rule_id}>', 'enable', '<{$value@index}>')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                    width="16" height="16"/>
                    <input type="hidden" name="action" value="enable"/>
                </a>
            <{/if}>
            </form>
        </td>
        <td><a href="#" class="edit" onclick="openEditCustomTestDialog('<{$value.rule_id}>')">编辑</a>
		<a href="#" class="delete" onclick="openDelAliasDialog('<{$value.rule_id}>')">删除</a></td>
    </tr>
<{foreachelse}>
    <tr><td colspan='9'>No Address Data</td></tr>
<{/foreach}>
