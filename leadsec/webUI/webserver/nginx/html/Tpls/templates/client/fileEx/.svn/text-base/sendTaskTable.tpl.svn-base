<{foreach $sendTask as $r }>
    <tr>
        <td><{$r.task_id}></td>
        <td><{$r.ip}></td>
        <td><{$r.share_name}></td>
        <td><{$r.fs}></td>
        <td>
            <{if $r.method === 'S'}>
                增量传输
            <{else if $r.method === 'C'}>
                改名传输
            <{else if $r.method === 'R'}>
                发送后删除
            <{else}>
                <{$r.method}>
            <{/if}>
        </td>
        <td>
            <{if $r.subdir === 'Y'}>
            是
            <{else}>
            否
            <{/if}>
        </td>
        <td>
            <{if $r.killvirus === 'Y'}>
            是
            <{else}>
            否
            <{/if}>
        </td>
        <td><{$r.interval}></td>
        <td>
            <form action="Function/client/fileEx/sendTask.php"
                method="POST" id="switchSendTaskForm_<{$r.task_id}>"
                onSubmit="return false;">
                <input type="hidden" name="sendTaskId" value="<{$r.task_id}>"/>
                <input type="hidden" name="sip" value="<{$r.ip}>"/>
                <input type="hidden" name="shareName" value="<{$r.share_name}>"/>
                <input type="hidden" name="fs" value="<{$r.fs}>"/>
                <input type="hidden" name="smbUser" value="<{$r.user}>"/>
                <input type="hidden" name="smbPwd" value="<{$r.password}>"/>
                <input type="hidden" name="sendMethod" value="<{$r.method}>"/>
                <input type="hidden" name="readyString" value="<{$r.ready_string}>"/>
                <input type="hidden" name="completeString" value="<{$r.complete_string}>"/>
                <input type="hidden" name="subdir" value="<{$r.subdir}>"/>
                <input type="hidden" name="killvirus" value="<{$r.killvirus}>"/>
                <input type="hidden" name="interval" value="<{$r.interval}>"/>
                <input type="hidden" name="time" value="<{$r.time}>"/>
                <input type="hidden" name="FEfilterOpt" value="<{$r.filter}>"/>
                <input type="hidden" name="lip" value="<{$r.lip}>"/>
                <input type="hidden" name="portReq" value="<{$r.port}>"/>
                <{if $r.active eq 1 || $r.active eq 'Y'}>
                    <a href="#" onClick="switchSendTaskAcl('<{$r.task_id}>', 'disable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="action" value="disable"/>
                    </a>
                <{else}>
                    <a href="#" onClick="switchSendTaskAcl('<{$r.task_id}>', 'enable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                        width="16" height="16"/>
                        <input type="hidden" name="action" value="enable"/>
                    </a>
                <{/if}>
            </form>
        </td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editSendTaskDialog('<{$r.task_id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delSendTaskDialog('<{$r.task_id}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='10'>No Data</td></tr>
<{/foreach}>
