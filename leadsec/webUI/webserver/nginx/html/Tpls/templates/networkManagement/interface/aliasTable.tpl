<{foreach $list as $value }>
    <tr>
        <td><{$value.external_name}></td>
        <td>
            <{if $value.ip != ''}>
				<{if !empty($value.mask)}>
					<{$value.ip|cat: '/'|cat: $value.mask}>
				<{else}>
					<{$value.ip}>
				<{/if}>
            <{/if}>
            <{if $value.ip != '' AND $value.ipv6 != ''}>
                <br/>
            <{/if}>
            <{if $value.ipv6 != ''}>
				<{if !empty($value.ipv6_mask)}>
					<{$value.ipv6|cat: '/'|cat: $value.ipv6_mask}>
				<{else}>
					<{$value.ipv6}>
				<{/if}>
            <{/if}>
        </td>
        <td><{$value.phy_device}></td>
        <td><{$value.alias_id}></td>
        <td>
        <form action="Function/networkManagement/interface/alias.php" method="POST"
            id="switchAliasDevForm_<{$value@index}>" onSubmit="return false;">
            <input type="hidden" name="switch_name" value="<{$value.external_name}>"/>
        <{if $value.enable eq 1}>
      		<a href="#" onClick="isSwitchCheck('<{$value.external_name}>', 'disable', '<{$value@index}>',switchAliasDev)">
      		    <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
                <input type="hidden" name="action" value="disable"/>
            </a>
        <{else}>
      		<a href="#" onClick="switchAliasDev('<{$value.external_name}>', 'enable', '<{$value@index}>')">
        	    <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
                <input type="hidden" name="action" value="enable"/>
            </a>
        <{/if}>
        </form>
        </td>
        <td>
      	    <a href="#" class="edit" onclick="isInUseCheck('<{$value.external_name}>',openEditAliasDialog, true)">编辑</a>
      	    <a href="#" class="delete" onclick="isInUseCheck('<{$value.external_name}>',openDelAliasDialog, false)">删除</a>	
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>没有别名设备信息</td></tr>
<{/foreach}>
