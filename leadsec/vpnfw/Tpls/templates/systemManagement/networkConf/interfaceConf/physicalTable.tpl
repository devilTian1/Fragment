<{foreach $list as $value }>
    <tr>
        <td><input type="checkbox" name="checkSpecPhysical"/></td>
        <td><{$value.external_name}></td>
        <td>
                <{$value.ip|cat: '/'|cat: $value.mask}>
        </td>
        <td><{$workmodeArr[$value.workmode]}></td>        
        <td><{$ipaddrArr[$value.ipaddr_type]}></td> 
        <td>
      	    <{if $value.ha_enable eq 1}>
      	        <img src="<{$smarty.const.THEME_PATH}>/<{$smarty.const.DEFAULT_LOCALE}>/images/icon/select.png"
                    width="16" height="16" />
             <{else}>
                 <img src="<{$smarty.const.THEME_PATH}>/<{$smarty.const.DEFAULT_LOCALE}>/images/icon/stop.png"
                    width="16" height="16"/>
             <{/if}>
        </td>       
        <td>
            <form action="index.php?R=systemManagement/networkConf/interfaceConf/physical/switchPhysicalDev" method="POST"
                id="switchPhyDevForm_<{$value@index}>" onSubmit="return false;">
                <input type="hidden" name="switch_name" value="<{$value.external_name}>"/>
            <{if $value.enable eq 1}>
                <a href="#" onClick="switchPhysicalDev('<{$value.external_name}>', 'disable', '<{$value@index}>')">
                    <img src="<{$smarty.const.THEME_PATH}>/<{$smarty.const.DEFAULT_LOCALE}>/images/icon/select.png"
                    width="16" height="16" />
                    <input type="hidden" name="action" value="disable"/>
                </a>
            <{else}>
                <a href="#" onClick="switchPhysicalDev('<{$value.external_name}>', 'enable', '<{$value@index}>')">
                    <img src="<{$smarty.const.THEME_PATH}>/<{$smarty.const.DEFAULT_LOCALE}>/images/icon/stop.png"
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
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        $("input:checkbox[name='checkSpecPhysical']").click(function() {
            dynCheckbox();
        });
    });
</script>