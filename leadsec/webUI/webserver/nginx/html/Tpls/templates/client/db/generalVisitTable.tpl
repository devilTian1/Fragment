<{foreach $clientComm as $value }>
    <tr>
        <td><{$value.id}></td>
        <td><{$value.dbtype}></td>
        <td><{$value.sa}></td>
        <td><{$value.lip}></td>
        <td><{$value.lport}></td>
        <td><{$value.filter}></td>
        <td>
            <form action="Function/client/db/generalVisit.php" method="POST"
                id="switchClientCommForm_<{$value.id}>" onSubmit="return false;">
                <input type="hidden" name="cdbGeneralId" value="<{$value.id}>"/>
                <input type="hidden" name="dbType" value="<{$value.dbtype}>"/>
                <input type="hidden" name="cdbGeneralsAddress" value="<{$value.sa}>"/>
                <input type="hidden" name="cdbGeneralLip" value="<{$value.lip}>"/>
                <input type="hidden" name="cdbGeneralLport" value="<{$value.lport}>"/>
                <input type="hidden" name="filter" value="<{$value.filter}>"/>
                <input type="hidden" name="active" value="<{$value.active}>"/>
                <input type="hidden" name="timeList" value="<{$value.time}>"/>
                <input type="hidden" name="roleList" value="<{$value.usergrp}>"/>
                <input type="hidden" name="comment" value="<{$value.comment|escape}>"/>
            <{if $value.active eq Y}>
                <a href="#" onClick="switchClientCommSer('<{$value.id}>', 'disable')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png"
                         width="16" height="16" />
                    <input type="hidden" name="action" value="disable"/>
                </a>
            <{/if}>
            <{if $value.active eq N}>
                <a href="#" onClick="switchClientCommSer('<{$value.id}>', 'enable')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                         width="16" height="16"/>
                    <input type="hidden" name="action" value="enable"/>
                </a>
            <{/if}>
            </form>
        </td>
        <td><{$value.time}></td>
        <td title="<{$value.comment|escape}>" ><{$value.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditDialog('<{$value.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelDialog('<{$value.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='10'>无数据</td></tr>
<{/foreach}>
