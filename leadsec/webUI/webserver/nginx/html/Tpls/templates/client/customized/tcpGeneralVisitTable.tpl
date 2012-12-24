<{foreach $tcpCommClientAcl as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.sa}></td>
        <td><{$r.lip}></td>
        <td><{$r.lport}></td>
        <td><{$r.time}></td>
        <td>
            <form action="Function/client/customized/tcpGeneralVisit.php"
                method="POST" id="switchTcpCommClientForm_<{$r.id}>"
                onSubmit="return false;">
                <input type="hidden" name="customId" value="<{$r.id}>"/>
                <input type="hidden" name="sa" value="<{$r.sa}>"/>
                <input type="hidden" name="lip" value="<{$r.lip}>"/>
                <input type="hidden" name="lportReq" value="<{$r.lport}>"/>
                <input type="hidden" name="time" value="<{$r.time}>"/>
                <input type="hidden" name="usergrp" value="<{$r.usergrp}>"/>
                <input type="hidden" name="killVirus" value="<{$r.killvirus}>"/>
                <input type="hidden" name="comment" value="<{$r.comment}>"/>
                <{if $r.active eq 1 || $r.active eq 'Y'}>
                    <a href="#" onClick="switchTcpCommClientAcl('<{$r.id}>', 'disable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="action" value="disable"/>
                    </a>
                <{else}>
                    <a href="#" onClick="switchTcpCommClientAcl('<{$r.id}>', 'enable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                        width="16" height="16"/>
                        <input type="hidden" name="action" value="enable"/>
                    </a>
                <{/if}>
            </form>
        </td>
        <td title="<{$r.comment}>"><{$r.comment|truncate:25:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="editTcpCommClientAclDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete" onclick="delTcpCommClientAclDialog('<{$r.id}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='8'>No Data</td></tr>
<{/foreach}>
