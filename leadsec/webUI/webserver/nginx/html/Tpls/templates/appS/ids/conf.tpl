<form action="Function/appS/ids/conf.php?conf=1" method="POST" id="setConfForm"
    onSubmit="return false;">
  <table class="column_95">
  <caption>
  基本配置
  </caption>
  <tbody>
    <tr>
      <td width="250" class="tdheader">启动入侵检测:</td>
      <td class="tdbody"><input class='floatLeft' type="checkbox" name="ipsenable" <{if $ipsenable eq 'YES'}>checked="checked"<{/if}>/></td>
    </tr>
     <tr>
      <td width="250" class="tdheader">监听网口:</td>
      <td class="tdbody">
        <label>
          <{foreach $ifnames as $key=>$value}>
          <input name="ifname" type="radio" value="<{$value}>" /><{$value}></label>
          <{/foreach}>
        </label>
      </td>
    </tr>
    <tr>
      <td width="250" class="tdheader"><p>监听网段:</p>
      <p>(多个网段用逗号分隔)</p></td>
      <td class="tdbody"><textarea name="ipaddr" cols="20" rows="5"><{$ipaddr}></textarea></td>
    </tr>
    <tr>
      <td class="tdheader">&nbsp;</td>
      <td class="tdbody"><label id="client"></label>
      <input name="input" type="button" value="确定" class="button" onclick="sendCmd()"/></td>
    </tr>
   </tbody>
</table>
</form>
<script type="text/javascript" src="Public/js/appS/ids/conf.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $(".button").button();

    initIfRadio();
    renderStandardUi();
    validateForm($("#setConfForm"));
});
</script>
