<form action="/index.php?R=systemManagement/systemConf/systemInformation/dynamicDN/setDdnsUser" method="POST" id="setDnsUserForm"    onSubmit="return false;">    <table class="column_95">        <caption>动态DNS注册：用户信息</caption>        <tbody>        <tr>            <td class="tdheader" width="250">用户名:</td>            <td class="tdbody">                <input class='floatLeft' type="text" name="account" id="dnssrv" value="<{$initData.username}>"/>            </td>        </tr>        <tr>            <td class="tdheader">密码:</td>            <td class="tdbody">            <input class='floatLeft' type="password" name="passwd"                id="passwd" value="<{$initData.password}>"                onChange="$('#setDnsUserForm').valid()"/>            </td>        </tr>        <tr>            <td class="tdheader">确认密码:</td>            <td class="tdbody">            <input class='floatLeft' type="password" name="passwd_again"                id="" value=""                onChange="$('#setDnsUserForm').valid()"/>            </td>        </tr>        <tr>            <td class="tdheader"></td>            <td class="tdbody">                <button type="button" class="inputbtn standard" onclick="setDdnsUser()">确定</button>            </td>        </tr>        </tbody>    </table></form><script type="text/javascript" src="Public/js/systemManagement/systemConf/systemInformation/dns.js"></script><script type="text/javascript">$(document).ready(function() {    renderStandardUi();    validateForm($("#setDnsUserForm"));});</script>