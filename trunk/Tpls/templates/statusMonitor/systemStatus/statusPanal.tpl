<form action="index.php?R=networkConf/setDns" method="POST"
    id="setDnsForm" onSubmit="return false;">
    <table class="column_95">
        <caption>域名服务器</caption>
        <tbody>
        <tr>
            <td class="tdheader" width="250">域名服务器IP1:</td>
            <td class="tdbody">
                <input class='floatLeft' type="text" name="dnssrv"
                    id="dnssrv" value="<{$initData.dnssrv}>"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader">域名服务器IP2:</td>
            <td class="tdbody">
            <input class='floatLeft' type="text" name="dnssrv2"
                id="dnssrv2" value="<{$initData.dnssrv2}>"
                onChange="$('#setDnsForm').valid()"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" class="inputbtn standard" onclick="setDns()">确定</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script type="text/javascript" src="Public/js/networkManagement/basic/dns.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#setDnsForm"));
});
</script>
