<form action="Function/appS/ids/autoConf.php?autoConf=1" method="POST" id="setConfForm"
    onSubmit="return false;">
  <table class="column_95">
  <caption>
  自动响应配置
  </caption>
  <tbody>
    <tr>
      <td width="250" class="tdheader">启动自动响应:</td>
      <td class="tdbody"><input class='floatLeft' name="autoenable" type="checkbox" <{if $autoenable eq 'YES'}>checked="checked"<{/if}>/></td>
    </tr>
     <tr>
      <td width="250" class="tdheader">阻断间隔:</td>
      <td class="tdbody"><label>
          <input class="width10em" type="text" name="timeLimit" id="timeLimit" value="<{$time}>"/>
       秒</label></td>
    </tr>
    <tr>
      <td width="250" class="tdheader"><p>忽略对以下IP地址的自动阻断:</p>
      <p>(用英文逗号分隔)</p></td>
      <td class="tdbody"><textarea name="iplist" cols="20" rows="5"><{$iplist}></textarea></td>
    </tr>
    <tr>
      <td class="tdheader">&nbsp;</td>
      <td class="tdbody"><label id="client"></label>
      <input name="input" type="button" value="确定" class="button" onclick="sendCmd()"/>
      <input name="input3" type="button" value="清除已经阻挡的IP地址" class="button" onClick="clearIpAddr()"/></td>
    </tr>
   </tbody>
</table>
</form>
<script type="text/javascript" src="Public/js/appS/ids/autoConf.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $(".button").button();
    renderStandardUi();
    validateForm($("#setConfForm"));
});
</script>
