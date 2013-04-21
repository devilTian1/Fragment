<{foreach $receiveTask as $r }>
    <tr>
        <td><{$r.task_id}></td>
        <td><{$r.ip}></td>
        <td><{$r.share_name}></td>
        <td><{$r.fs}></td>
        <td>
            <form action="Function/server/fileEx/receiveTask.php"
                method="POST" id="switchReceiveTaskForm_<{$r.task_id}>"
                onSubmit="return false;">
                <input type="hidden" name="receiveTaskId" value="<{$r.task_id}>"/>
                <input type="hidden" name="sip" value="<{$r.ip}>"/>
                <input type="hidden" name="shareName" value="<{$r.share_name}>"/>
                <input type="hidden" name="fs" value="<{$r.fs}>"/>
                <input type="hidden" name="smbUser" value="<{$r.user}>"/>
                <input type="hidden" name="smbPwd" value="<{$r.password}>"/>
                <input type="hidden" name="lip" value="<{$r.lip}>"/>
                <input type="hidden" name="portReq" value="<{$r.port}>"/>
                <{if $r.active eq 1 || $r.active eq 'Y'}>
                    <a href="#" onClick="switchReceiveTaskAcl('<{$r.task_id}>', 'disable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="action" value="disable"/>
                    </a>
                <{else}>
                    <a href="#" onClick="switchReceiveTaskAcl('<{$r.task_id}>', 'enable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                        width="16" height="16"/>
                        <input type="hidden" name="action" value="enable"/>
                    </a>
                <{/if}>
            </form>
        </td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editReceiveTaskDialog('<{$r.task_id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delReceiveTaskDialog('<{$r.task_id}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>No Data</td></tr>
<{/foreach}>
