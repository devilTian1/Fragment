<form action="index.php?R=logAudit/logConf/logServer/setLogServer" method="POST"
    id="setLogServerForm" onSubmit="return false;">
    <table class="column_95">
        <caption>日志服务器</caption>
        <tbody>
        <tr>
            <td class="tdheader" width="250">日志服务器IP:</td>
            <td class="tdbody">
                <input class='floatLeft' type="text" name="logsrv"
                    id="logsrv" value="<{$initData.logsrv}>"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader">协议:</td>
            <td class="tdbody">
              <select name="protocol" id="protocol">
              	<option value="udp">udp</option>
              </select>
			</td>
        </tr>
        <tr>
            <td class="tdheader"><span class="red">*</span>端口:</td>
            <td class="tdbody">
            <input class='floatLeft' type="text" name="port"
                id="port" value="<{$initData.port}>"
                />
            </td>
        </tr>
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" class="inputbtn standard" onclick="setLogServer()">确定</button>
                <button type="button" class="inputbtn standard" onclick="lookLog()">查看日志</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script type="text/javascript" src="Public/js/logAudit/logConf/logServer.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#setLogServerForm"));
});
</script>
