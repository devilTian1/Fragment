<{foreach $udpCommClientAcl as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.sa|regex_replace: "/_ipv(4|6)/" : ""}></td>
        <td><{$r.lip}></td>
        <td><{$r.lport}></td>
        <td><{$r.time}></td>
        <td>
            <form action="Function/client/customized/udpGeneralVisit.php"
                method="POST" id="switchUdpCommClientForm_<{$r.id}>"
                onSubmit="return false;">
                <input type="hidden" name="customUdpGeneralId" value="<{$r.id}>"/>
                <input type="hidden" name="sa" value="<{$r.sa}>"/>
                <input type="hidden" name="udpGeneralLip" value="<{$r.lip}>"/>
                <input type="hidden" name="udpGeneralLport" value="<{$r.lport}>"/>
                <input type="hidden" name="time" value="<{$r.time}>"/>
                <input type="hidden" name="usergrp" value="<{$r.usergrp}>"/>
                <input type="hidden" name="killVirus" value="<{$r.killvirus}>"/>
                <input type="hidden" name="ipType" value="<{$r.ip_ver}>"/>
                <input type="hidden" name="comment" value="<{$r.comment|escape}>"/>
                <{if $r.active eq 1 || $r.active eq 'Y'}>
                    <a href="#" onClick="switchUdpCommClientAcl('<{$r.id}>', 'disable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="action" value="disable"/>
                    </a>
                <{else}>
                    <a href="#" onClick="switchUdpCommClientAcl('<{$r.id}>', 'enable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                        width="16" height="16"/>
                        <input type="hidden" name="action" value="enable"/>
                    </a>
                <{/if}>
            </form>
        </td>
        <td title="<{$r.comment|escape}>"><{$r.comment|escape|truncate:25:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="editUdpCommClientAclDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete" onclick="delUdpCommClientAclDialog('<{$r.id}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='8'>无数据</td></tr>
<{/foreach}>
