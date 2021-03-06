<{foreach $udpTransClientAcl as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.sa|regex_replace: "/_ipv(4|6)/" : ""}></td>
        <td><{$r.da|regex_replace: "/_ipv(4|6)/" : ""}></td>
        <td><{$r.dport}></td>
        <td><{$r.time}></td>
        <td>
            <form action="Function/client/customized/udpTransVisit.php"
                method="POST" id="switchUdpTransClientForm_<{$r.id}>"
                onSubmit="return false;">
                <input type="hidden" name="customUdpTransId" value="<{$r.id}>"/>
                <input type="hidden" name="sa" value="<{$r.sa}>"/>
                <input type="hidden" name="da" value="<{$r.da}>"/>
                <input type="hidden" name="customUdpTransLport" value="<{$r.dport}>"/>
                <input type="hidden" name="usergrp" value="<{$r.usergrp}>"/>
                <input type="hidden" name="time" value="<{$r.time}>"/>
                <input type="hidden" name="active" value="<{$r.active}>"/>
                <input type="hidden" name="killVirus" value="<{$r.killvirus}>"/>
                <input type="hidden" name="ipType" value="<{$r.ip_ver}>"/>
                <input type="hidden" name="comment" value="<{$r.comment|escape}>"/>
            <{if $r.active eq 1 || $r.active eq 'Y'}>
                <a href="#" onClick="switchUdpTransClientAcl('<{$r.id}>', 'disable')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
                    <input type="hidden" name="action" value="disable"/>
                </a>
            <{else}>
                <a href="#" onClick="switchUdpTransClientAcl('<{$r.id}>', 'enable')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                    width="16" height="16"/>
                    <input type="hidden" name="action" value="enable"/>
                </a>
            <{/if}>
            </form>
        </td>
        <td title="<{$r.comment|escape}>"><{$r.comment|escape|truncate:25:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="editUdpTransClientAclDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete" onclick="delUdpTransClientAclDialog('<{$r.id}>', '<{$r.name}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='8'>无数据</td></tr>
<{/foreach}>
