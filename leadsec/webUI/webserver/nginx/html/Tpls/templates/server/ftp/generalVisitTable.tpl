<{foreach $ftpCommServerAcl as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.serverip}></td>
        <td><{$r.sport}></td>
        <td>
            <form action="Function/server/ftp/generalVisit.php"
                method="POST" id="switchFtpCommServerForm_<{$r.id}>"
                onSubmit="return false;">
                <input type="hidden" name="ftpId" value="<{$r.id}>"/>
                <input type="hidden" name="serverIp" value="<{$r.serverip}>"/>
                <input type="hidden" name="sportReq" value="<{$r.sport}>"/>
                <input type="hidden" name="comment" value="<{$r.comment|escape}>"/>
                <{if $r.active eq 1 || $r.active eq 'Y'}>
                    <a href="#" onClick="switchFtpCommServerAcl('<{$r.id}>', 'disable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="action" value="disable"/>
                    </a>
                <{else}>
                    <a href="#" onClick="switchFtpCommServerAcl('<{$r.id}>', 'enable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                        width="16" height="16"/>
                        <input type="hidden" name="action" value="enable"/>
                    </a>
                <{/if}>
            </form>
        </td>
        <td title="<{$r.comment|escape}>" ><{$r.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="editFtpCommServerAclDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete" onclick="delFtpCommServerAclDialog('<{$r.id}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>没有任务.</td></tr>
<{/foreach}>
