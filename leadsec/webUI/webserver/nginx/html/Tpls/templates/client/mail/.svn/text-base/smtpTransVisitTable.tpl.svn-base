<{foreach $smtpTransClientAcl as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.sa|regex_replace: "/_ipv(4|6)/" : ""}></td>
        <td><{$r.da|regex_replace: "/_ipv(4|6)/" : ""}></td>
        <td><{$r.dport}></td>
        <td><{$r.filter}></td>
        <td><{$r.time}></td>
        <td>
            <form action="Function/client/mail/smtpTransVisit.php"
                method="POST" id="switchSmtpTransClientForm_<{$r.id}>"
                onSubmit="return false;">
                <input type="hidden" name="smtpTransId" value="<{$r.id}>"/>
                <input type="hidden" name="sa" value="<{$r.sa}>"/>
                <input type="hidden" name="da" value="<{$r.da}>"/>
                <input type="hidden" name="dportReq" value="<{$r.dport}>"/>
                <input type="hidden" name="time" value="<{$r.time}>"/>
                <input type="hidden" name="filter" value="<{$r.filter}>"/>
                <input type="hidden" name="usergrp" value="<{$r.usergrp}>"/>
                <input type="hidden" name="comment" value="<{$r.comment|escape}>"/>
                <{if $r.active eq 1 || $r.active eq 'Y' || $r.active eq 'ok'}>
                    <a href="#" onClick="switchSmtpTransClientAcl('<{$r.id}>', 'disable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="action" value="disable"/>
                    </a>
                <{else}>
                    <a href="#" onClick="switchSmtpTransClientAcl('<{$r.id}>', 'enable')">
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
                onclick="editSmtpTransClientAclDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delSmtpTransClientAclDialog('<{$r.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='9'>No Data</td></tr>
<{/foreach}>
