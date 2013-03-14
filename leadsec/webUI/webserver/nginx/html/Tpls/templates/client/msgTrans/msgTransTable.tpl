<{foreach $msgTrans as $value }>
    <tr>
        <td><{$value.id}></td>
        <td><{$value.sa}></td>
        <td><{$value.lip}></td>
        <td><{$value.lport}></td>
        <td>
            <{if $value.ssl == 'Y'}>
                                          是           
            <{else}>
                                         否
            <{/if}>
        </td>
        <td>
            <{if $value.scanvirus == 'Y'}>
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
            <form action="Function/client/msgTrans/msgTrans.php" method="POST"
                id="switchmsgTransForm_<{$value.id}>" onSubmit="return false;">
                <input type="hidden" name="msgTransId" value="<{$value.id}>"/>
                <input type="hidden" name="sAddress" value="<{$value.sa}>"/>
                <input type="hidden" name="lAddress" value="<{$value.lip}>"/>
                <input type="hidden" name="lPort" value="<{$value.lport}>"/>
                <input type="hidden" name="ssl" value="<{$value.ssl}>"/>
                <input type="hidden" name="scanvirus" value="<{$value.scanvirus}>"/>
                <input type="hidden" name="backup" value="<{$value.backup}>"/>
                <input type="hidden" name="active" value="<{$value.active}>"/>
                <input type="hidden" name="timeList" value="<{$value.time}>"/>
                <input type="hidden" name="comment" value="<{$value.comment}>"/>
            <{if $value.active eq ok}>
                <a href="#" onClick="switchmsgTrans('<{$value.id}>', 'disable')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png"
                         width="16" height="16" />
                    <input type="hidden" name="action" value="disable"/>
                </a>
            <{/if}>
            <{if $value.active eq erro}>
                <a href="#" onClick="switchmsgTrans('<{$value.id}>', 'enable')">
                    <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                         width="16" height="16"/>
                    <input type="hidden" name="action" value="enable"/>
                </a>
            <{/if}>
            </form>
        </td>
        <td><{$value.time}></td>
        <td><{$value.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditDialog('<{$value.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelDialog('<{$value.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='11'>No Data</td></tr>
<{/foreach}>
