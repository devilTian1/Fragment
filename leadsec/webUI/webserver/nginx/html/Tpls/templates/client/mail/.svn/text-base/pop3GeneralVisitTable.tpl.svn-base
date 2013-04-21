<{foreach $pop3CommClientAcl as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.sa|regex_replace: "/_ipv(4|6)/" : ""}></td>
        <td><{$r.lip}></td>
        <td><{$r.lport}></td>
        <td><{$r.filter}></td>
        <td><{$r.time}></td>
        <td>
            <form action="Function/client/mail/pop3GeneralVisit.php"
                method="POST" id="switchPop3CommClientForm_<{$r.id}>"
                onSubmit="return false;">
                <input type="hidden" name="pop3Id" value="<{$r.id}>"/>
                <input type="hidden" name="sa" value="<{$r.sa}>"/>
                <input type="hidden" name="pop3lip" value="<{$r.lip}>"/>
                <input type="hidden" name="pop3lportReq" value="<{$r.lport}>"/>
                <input type="hidden" name="time" value="<{$r.time}>"/>
                <input type="hidden" name="filter" value="<{$r.filter}>"/>
                <input type="hidden" name="usergrp" value="<{$r.usergrp}>"/>
                <input type="hidden" name="ipType" value="<{$r.ip_ver}>"/>
                <input type="hidden" name="comment" value="<{$r.comment|escape}>"/>
                <{if $r.active eq 1 || $r.active eq 'Y' || $r.active eq 'ok'}>
                    <a href="#" onClick="switchPop3CommClientAcl('<{$r.id}>', 'disable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="action" value="disable"/>
                    </a>
                <{else}>
                    <a href="#" onClick="switchPop3CommClientAcl('<{$r.id}>', 'enable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                        width="16" height="16"/>
                        <input type="hidden" name="action" value="enable"/>
                    </a>
                <{/if}>
            </form>
        </td>
        <td title="<{$r.comment|escape}>"><{$r.comment|escape|truncate:10:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editPop3CommClientAclDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delPop3CommClientAclDialog('<{$r.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='9'>No Data</td></tr>
<{/foreach}>
