<form action="Function/statMonitor/network/network.php" method="POST" id="editNetworkForm" onSubmit="return false;">
    <div class="floatRight">
        设备:<{html_options  class="select" name="deviceList"
                 options=$deviceOptions selected=$net.external_name|default: ''}>
           <button name="freshStatus" class="standard" type="button" onClick="freshCurrentStatus()">刷新</button>
    </div>
    <div class="clearFloat"></div>
    <div id="freshCurrentContent">
        <{include file='statMonitor/network/editNetworkDialogTable.tpl'}>
    </div>
</form>