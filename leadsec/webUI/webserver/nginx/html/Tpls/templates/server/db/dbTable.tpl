<{foreach $serverComm as $value }>
    <tr>
        <td><{$value.id}></td>
        <td><{$value.dbtype}></td>
        <td><{$value.serverip}></td>
        <td><{$value.sport}></td>
        <td>
            <form action="Function/server/db/db.php" method="POST"
                id="switchServerCommForm_<{$value.id}>" onSubmit="return false;">
                <input type="hidden" name="clientId" value="<{$value.id}>"/>
                <input type="hidden" name="dbType" value="<{$value.dbtype}>"/>
                <input type="hidden" name="ip" value="<{$value.serverip}>"/>
                <input type="hidden" name="sportReq" value="<{$value.sport}>"/>
                <input type="hidden" name="active" value="<{$value.active}>"/>
                <input type="hidden" name="comment" value="<{$value.comment}>"/>
            <{if $value.active eq Y}>
                <a href="#" onClick="switchServerCommSer('<{$value.id}>', 'disable')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png"
                         width="16" height="16" />
                    <input type="hidden" name="action" value="disable"/>
                </a>
            <{/if}>
            <{if $value.active eq N}>
                <a href="#" onClick="switchServerCommSer('<{$value.id}>', 'enable')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                         width="16" height="16"/>
                    <input type="hidden" name="action" value="enable"/>
                </a>
            <{/if}>
            </form>
        </td>
        <td><{$value.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditDVUserDialog('<{$value.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelDVUserDialog('<{$value.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='10'>No Data</td></tr>
<{/foreach}>
