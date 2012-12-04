<form action="Function/networkMangement/basic/dns.php" method="POST" id="setDnsForm"
onSubmit="return false;">
<table class="column_95">
  <caption>
域名服务器
  </caption>
    <tbody>
    <tr>
      <td class="tdheader" width="250">域名服务器IP1:</td>
      <td class="tdbody">
        <input type="text" name="dnssrv" id="dnssrv" value="<{$dnssrv['dnssrv']}>"/>
       </td>
    </tr>
    <tr>
      <td class="tdheader">域名服务器IP2:</td>
      <td class="tdbody">
      	<input type="text" name="dnssrv2" id="dnssrv2" value="<{$dnssrv['dnssrv2']}>"/>
      </td>
    </tr>
    <tr>
      <td class="tdheader"></td>
      <td class="tdbody">
      	 <input type="button" class="inputbtn standard" value="确定" onclick="setDns()" />
      </td>
    </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript" src="Public/js/networkMangement/basic/dns.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#setDnsForm"));
});
</script>