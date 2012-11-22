  <table class="column_95">
  <caption>
  自动响应配置
  </caption>
  <tbody>
    <tr>
      <td width="250" class="tdheader">启动自动响应:</td>
      <td class="tdbody"><input name="input2" type="checkbox" value="" /></td>
    </tr>
     <tr>
      <td width="250" class="tdheader">阻断间隔:</td>
      <td class="tdbody"><label>
          <input type="text" name="textfield" id="textfield" />
       秒</label></td>
    </tr>
    <tr>
      <td width="250" class="tdheader"><p>忽略对以下IP地址的自动阻断:</p>
      <p>(用英文逗号分隔)</p></td>
      <td class="tdbody"><textarea name="" cols="20" rows="5"></textarea></td>
    </tr>
    <tr>
      <td class="tdheader">&nbsp;</td>
      <td class="tdbody"><label id="client"></label>
      <input name="input" type="button" value="确定" class="button" />
      <input name="input3" type="button" value="清除已经阻挡的IP地此" class="button" /></td>
    </tr>
   </tbody>
</table>
<script type="text/javascript">
$(document).ready(function() {
    $(".button").button();
});
</script>
