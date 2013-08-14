<form action="Function/appS/ids/scanConf.php?scanConf=1" method="POST" id="setScanConfForm"
    onSubmit="return false;">
    <table class="column_95">
        <caption>
            扫描检测配置
        </caption>
        <tbody>
            <tr>
                <td width="250" class="tdheader">启动扫描检测:</td>
                <td class="tdbody">
                    <input name="enableScan" type="checkbox" class="checkbox"
                    <{if $enableScan eq 1}>checked="checked"<{/if}>/></td>
            </tr>
            <tr>
                <td width="250" class="tdheader">时间间隔(单位:秒): </td>
                <td class="tdbody"><label>
                    <input type="text" name="scanInterval" id="scanInterval" value="<{$interval}>" class="width149"/>
                    </label>
                </td>
            </tr>
            <tr>
                <td class="tdheader">发现端口连接次数:</td>
                <td class="tdbody"><label>
                    <input type="text" name="connectTimes" value="<{$connectTimes}>" class="width149"/>
                    </label>
                </td>
            </tr>
            <tr>
                <td width="250" class="tdheader"><p>忽略来自以下源IP地址的扫描检测:</p>
                    <p>(用英文逗号分隔)</p></td>
                <td class="tdbody"><textarea name="ignoreIp" cols="20" rows="5"><{$ipList}></textarea></td>
            </tr>
            <tr>
                <td class="tdheader">&nbsp;</td>
                <td class="tdbody">
                    <button class="inputbtn standard" type="button" onclick="setScanConf()">确定</button>
                    <button class="inputbtn standard" type="button" onclick="clearScanConfIpAddr()">清除已经阻挡的IP地址</button>                   	
            </tr>
        </tbody>
    </table>
</form>
<script type="text/javascript" src="Public/js/appS/ids/scanConf.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#setScanConfForm"));
});
</script>
