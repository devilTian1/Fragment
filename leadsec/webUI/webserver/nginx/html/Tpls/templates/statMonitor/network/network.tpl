<table class="column_95 textMid" id="networkTable">
    <caption> 网络状态 </caption>
    <thead>
        <tr>
            <th width="200">网络设备</th>
            <th>状态</th>
            <th colspan="3">流量</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="5">loading... ...</td>      
        </tr>
    </tbody>
</table>

<form action="Function/statMonitor/network/network.php" method="POST" id="setInterfacemonForm" onSubmit="return false;">
    <input type="hidden" name="interfacemonActive"  value="<{$interfacemon}>"/>
    <table class="column_95">
        <tbody>
            <tr>
                <td width="200" class="tdheader">网闸隔离卡状态:</td>
                <td colspan="2" class="tdbody">
                    <{if $cardStatus === '1'}>
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="16" />
                     <{else}>
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/stoplink.gif" width="16" height="16" />
                     <{/if}>
                </td>
            </tr>
        </tbody>
    </table>
     <button name="input3" type="button" class="standard" onClick="freshMonitorTable()">刷新</button>
</form>
<script type="text/javascript" src="Public/js/statMonitor/network/network.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    freshTable('Function/statMonitor/network/network.php',
            $('#networkTable'), 'ORDER BY external_name ASC');
});
</script>
