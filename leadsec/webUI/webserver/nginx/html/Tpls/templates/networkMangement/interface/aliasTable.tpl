<{foreach $list as $value }>
    <tr>
        <td><{$value.external_name}></td>
        <td><{$value.ip}>/<{$value.mask}></td>
        <td><{$value.phy_device}></td>
        <td><{$value.alias_id}></td>
        <td>
        <form action="Function/networkMangement/interface/alias.php" method="POST"
            id="switchAliasDevForm_<{$value@index}>" onSubmit="return false;">
            <input type="hidden" name="switch_name" value="<{$value.external_name}>"/>
        <{if $value.enable eq 1}>
      		<a href="#" onClick="switchAliasDev('<{$value.external_name}>', 'disable', '<{$value@index}>')">
      		    <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
                <input type="hidden" name="action" value="disable"/>
            </a>
        <{else}>
      		<a href="#" onClick="switchAliasDev('<{$value.external_name}>', 'disable', '<{$value@index}>')">
        	    <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
                <input type="hidden" name="action" value="enable"/>
            </a>
        <{/if}>
        </form>
        </td>
        <td>
      	    <a href="#" class="edit" onclick="openEditAliasDialog('<{$value.external_name}>')">编辑</a>
      	    <a href="#" class="delete" onclick="openDelAliasDialog('<{$value.external_name}>')">删除</a>	
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>No Alias Data</td></tr>
<{/foreach}>
