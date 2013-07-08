<{foreach $dataInfo as $val }>
    <tr>
        <td><{$val.id}></td>
        <td><{$val.sa}></td>
        <td><{$val.lip}></td> 
		<td><{$val.lport}></td>
		<td><{if $val.ssl == Y}>是<{else if $val.ssl == N}>否<{/if}></td>
		<td><{$val.commname}></td>
		<td><{if $val.killvirus == 2}>扫描<{else if $val.killvirus == 0}>不扫描<{else if $val.killvirus == 1}>二进制扫描<{/if}></td>
		<td>
			<form action="Function/client/dbSync/dbSync.php" method="POST" 
				id="switchForm_<{$val@index}>" onSubmit="return false;">
			<input type="hidden" name="switch_id" value="<{$val.id}>"/>
			<input type="hidden" name="switch_sa" value="<{$val.sa}>"/>
			<input type="hidden" name="switch_lip" value="<{$val.lip}>"/>
			<input type="hidden" name="switch_lport" value="<{$val.lport}>"/>
			<input type="hidden" name="switch_ssl" value="<{$val.ssl}>"/>
			<input type="hidden" name="switch_commname" value="<{$val.commname}>"/>
			<input type="hidden" name="switch_time" value="<{$val.time}>"/>
			<input type="hidden" name="switch_killvirus" value="<{$val.killvirus}>"/>
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
		<td><{$val.time}></td>
        <td title="<{$val.comment|escape}>"><{$val.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditDialog('<{$val.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelDialog('<{$val.id}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='11'>无数据</td></tr>
<{/foreach}>
