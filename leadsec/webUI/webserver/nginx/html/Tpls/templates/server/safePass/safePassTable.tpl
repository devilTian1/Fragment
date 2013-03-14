<{foreach $fpServerList as $array }>
    <tr>
        <td><{$array.id}></td>        
        <td><{$array.sip}></td>
        <td><{$array.sport}></td>
        <td><{$array.eip}></td>
        <td><{$array.service}></td>
        <td>
        	<form action="Function/server/safePass/safePass.php"
                method="POST" id="switchSafePassServerActiveForm_<{$array.id}>"
                onSubmit="return false;">
                <input type="hidden" name="activeSwitch" value="1"/>
                <input type="hidden" name="safePassId" value="<{$array.id}>"/>
                <input type="hidden" name="spServerIp" value="<{$array.sip}>"/>
               	<input type="hidden" name="serverPort" value="<{$array.sport}>"/>
               	<input type="hidden" name="publicPort" value="<{$array.inport}>"/>
               	<input type="hidden" name="outflowIpList" value="<{$array.eip}>"/>
                <input type="hidden" name="serviceList" value="<{$array.service}>"/>
                <input type="hidden" name="log" value="<{$array.log}>"/>
                <input type="hidden" name="comment" value="<{$array.comment}>"/>
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
        <td><{$array.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditSafePassDialog('<{$array.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelSafePassDialog('<{$array.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='8'>No Data</td></tr>
<{/foreach}>
