<{foreach $list as $value }>
    <tr>
        <td><{$value.external_name}></td>
        <td>
            <{if $value.ip != ''}>
                <{$value.ip|cat: '/'|cat: $value.mask}>
            <{/if}>
            <{if $value.ip != '' AND $value.ipv6 != ''}>
                <br/>
            <{/if}>
            <{if $value.ipv6 != ''}>
                <{$value.ipv6|cat: '/'|cat: $value.ipv6_mask}>
            <{/if}>
        </td>
        <td>
      	    <{$propertyArr[$value.if_property]}>
        </td>
        <td><{$ipaddrArr[$value.ipaddr_type]}></td>
        <td><{$workmodeArr[$value.workmode]}></td>
        <td>
            <form action="Function/networkManagement/interface/physical.php" method="POST"
                id="switchPhyDevForm_<{$value@index}>" onSubmit="return false;">
                <input type="hidden" name="switch_name" value="<{$value.external_name}>"/>
            <{if $value.enable eq 1}>
                <a href="#" onClick="switchPhysicalDev('<{$value.external_name}>', 'disable', '<{$value@index}>')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png"
                    width="16" height="16" />
                    <input type="hidden" name="action" value="disable"/>
                </a>
            <{else}>
                <a href="#" onClick="switchPhysicalDev('<{$value.external_name}>', 'enable', '<{$value@index}>')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                    width="16" height="16"/>
                    <input type="hidden" name="action" value="enable"/>
                </a>
            <{/if}>
            </form>
        </td>
        <td><a href="#" class="edit" onclick="openEditPhysicalDialog('<{$value.external_name}>')">编辑</a></td>
    </tr>
<{foreachelse}>
    <tr><td colspan='7'>No Address Data</td></tr>
<{/foreach}>
