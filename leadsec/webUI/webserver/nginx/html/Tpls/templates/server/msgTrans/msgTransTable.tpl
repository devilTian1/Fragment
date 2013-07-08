<{foreach $serverMsg as $value }>
    <tr>
        <td><{$value.id}></td>
        <td><{$value.serip}></td>
        <td><{$value.serport}></td>
         <td>
            <{if $value.ssl == 'Y'}>
                                          是           
            <{else}>
                                         否
            <{/if}>
        </td>
        <td>
            <{if $value.backup == 'Y'}>
                                          是           
            <{else}>
                                         否
            <{/if}>
        </td>
        <td>
            <form action="Function/server/msgTrans/msgTrans.php" method="POST"
                id="switchServerMsgForm_<{$value.id}>" onSubmit="return false;">
                <input type="hidden" name="msgTransId" value="<{$value.id}>"/>
                <input type="hidden" name="ip" value="<{$value.serip}>"/>
                <input type="hidden" name="serverPortReq" value="<{$value.serport}>"/>
                <input type="hidden" name="ssl" value="<{$value.ssl}>"/> 
                <input type="hidden" name="backup" value="<{$value.backup}>"/>
                <input type="hidden" name="comment" value="<{$value.comment|escape}>"/>
            <{if $value.active eq ok}>
                <a href="#" onClick="switchServerMsg('<{$value.id}>', 'disable')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png"
                         width="16" height="16" />
                    <input type="hidden" name="action" value="disable"/>
                </a>
            <{/if}>
            <{if $value.active eq erro}>
                <a href="#" onClick="switchServerMsg('<{$value.id}>', 'enable')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                         width="16" height="16"/>
                    <input type="hidden" name="action" value="enable"/>
                </a>
            <{/if}>
            </form>
        </td>
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
