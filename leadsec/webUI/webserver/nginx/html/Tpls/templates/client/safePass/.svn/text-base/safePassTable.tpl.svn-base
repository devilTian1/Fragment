<{foreach $fpList as $array }>
    <tr>
        <td><{$array.id}></td>        
        <td>
            <{if $array.samenet eq 'yes'}>
                普通访问
            <{else if $array.samenet eq 'no'}>
                透明访问
            <{else}>
                Error
            <{/if}>
        </td>
        <td><{$array.sa}></td>
        <td><{$array.sport}></td>
        <td><{$array.da}></td>
        <td><{$array.dport}></td>
        <td><{$array.service}></td>
        <td>
        	<{if $array.time != 'none'}>
        		<{$array.time}>
        	<{/if}>
        </td>
        <td>
        	<form action="Function/client/safePass/safePass.php"
                method="POST" id="switchSafePassActiveForm_<{$array.id}>"
                onSubmit="return false;">
                <input type="hidden" name="activeSwitch" value="1"/>
                <input type="hidden" name="safePassId" value="<{$array.id}>"/>
                <input type="hidden" name="accessType" value="<{$array.samenet}>"/>
               	<input type="hidden" name="srcIpList" value="<{$array.sa}>_ipv4"/>
                <{if $array.samenet eq 'yes'}>                
                	<input type="hidden" name="destIpList_normal" value="<{$array.da}>"/>
                <{else}>
                	<input type="hidden" name="destIpList_trans" value="<{$array.da}>_ipv4"/>
                <{/if}>
                <input type="hidden" name="srcPort" value="<{$array.sport}>"/>
                <input type="hidden" name="destPort" value="<{$array.dport}>"/>
                <input type="hidden" name="timeList" value="<{$array.time}>"/>
                <input type="hidden" name="logChk" value="<{$array.log}>"/>
                <input type="hidden" name="serviceList" value="<{$array.service}>"/>
                <input type="hidden" name="syn" value="<{$array.syn}>"/>
                <input type="hidden" name="udp" value="<{$array.udp}>"/>
                <input type="hidden" name="icmp" value="<{$array.icmp}>"/>
                <input type="hidden" name="ping" value="<{$array.ping}>"/>
                <input type="hidden" name="comment" value="<{$array.comment|escape}>"/>
	        	<{if $array.active eq 'ok'}>
	        		<a href="#" onClick="switchSafePassActive('<{$array.id}>', 'disable')">
	                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
	                    <input type="hidden" name="activeChk" value="erro"/>
	                </a>
	            <{else}>
	                <a href="#" onClick="switchSafePassActive('<{$array.id}>', 'enable')">
	                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
	                    width="16" height="16"/>
	                    <input type="hidden" name="activeChk" value="ok"/>
	                </a>                	        		
	        	<{/if}>
	       </form>
        </td>
        <td title="<{$array.comment|escape}>"><{$array.comment|escape|truncate:16:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditSafePassDialog('<{$array.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelSafePassDialog('<{$array.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='11'>No Data</td></tr>
<{/foreach}>
