<{foreach $list as $value }>
    <tr>
        <td>
            <{$value.external_name}>
        </td>
        <td>
            <{$value.ip}>/<{$value.mask}>
        </td>
        <td>
            <{$workmodeArr[$value.workmode]}>
        </td>
        <td>
            <{$ipaddrArr[$value.ipaddr_type]}>
        </td>
        <td>
            <{$value.interface_list|default: '空'}>
        </td>
        <td>
            <form action="Function/networkMangement/interface/redundance.php" method="POST"
                id="switchRedundanceDevForm_<{$value@index}>" onSubmit="return false;">
                <input type="hidden" name="switch_name" value="<{$value.external_name}>"/>
            <{if $value.enable eq 1}>
                <a href="#" onClick="switchRedundanceDev('<{$value.external_name}>', 'disable', '<{$value@index}>')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png"
                        width="16" height="16" />
                    <input type="hidden" name="action" value="disable"/>
                </a>
            <{else}>
                <a href="#" onClick="switchRedundanceDev('<{$value.external_name}>', 'enable', '<{$value@index}>')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                        width="16" height="16" />
                    <input type="hidden" name="action" value="enable"/>
                </a>
            <{/if}>
            </form>
        </td>
        <td>
            <a href="#" class="edit"
                onclick="openEditRedundanceDevDialog('<{$value.external_name}>')">
                编辑</a>
      	    <a href="#" class="delete"
                onclick="openDelRedundanceDevDialog('<{$value.external_name}>')">
                删除</a>	
        </td>
    </tr>
<{foreachelse}>
    <tr>
        <td colspan='7'>No Redundance Device Data</td>
    </tr>
<{/foreach}>
