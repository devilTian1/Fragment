<{foreach $dataInfo as $val }>
    <tr>
        <td><{$val.id}></td>
        <td><{$val.serverip}></td>
        <td><{$val.sport}></td> 
		<td><{if $val.ssl == Y}>是<{else if $val.ssl == N}>否<{/if}></td>
		<td><{$val.commname}></td>
		<td>
		<form action="Function/server/dbSync/dbSync.php" method="POST" 
			id="switchForm_<{$val@index}>" onSubmit="return false;">
		<input type="hidden" name="switch_id" value="<{$val.id}>"/>
		<input type="hidden" name="switch_serverip" value="<{$val.serverip}>"/>
		<input type="hidden" name="switch_sport" value="<{$val.sport}>"/>
		<input type="hidden" name="switch_ssl" value="<{$val.ssl}>"/>
		<input type="hidden" name="switch_active" value="<{$val.active}>"/>
		<input type="hidden" name="switch_commname" value="<{$val.commname}>"/>
		<input type="hidden" name="switch_comment" value="<{$val.comment}>"/>
		<{if $val.active == Y}>
			<a href="#" onClick="switchPhysicalDev('<{$val.id}>', 'disable', '<{$val@index}>')">
			<img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" 
				width="16" height="16" />
			<input type="hidden" name="action" value="disable"/></a>
		<{else}>
			<a href="#" onClick="switchPhysicalDev('<{$val.id}>', 'enable', '<{$val@index}>')">
            <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
				width="16" height="16"/>
            <input type="hidden" name="action" value="enable"/></a>
		<{/if}>
		</form>
		</td>
		<td><{$val.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditDialog('<{$val.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelDialog('<{$val.id}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='11'>No Data</td></tr>
<{/foreach}>
