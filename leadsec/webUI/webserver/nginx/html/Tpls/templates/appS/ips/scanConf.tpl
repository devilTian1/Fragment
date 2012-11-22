  <table class="column_95">
  <caption>
  扫描检测配置
  </caption>
  <tbody>
    <tr>
      <td width="250" class="tdheader">启动扫描检测:</td>
      <td class="tdbody"><input name="input2" type="checkbox" value="" /></td>
    </tr>
     <tr>
      <td width="250" class="tdheader">时间间隔: </td>
      <td class="tdbody"><label>
          <input type="text" name="textfield" id="textfield" />
       秒</label></td>
    </tr>
     <tr>
       <td class="tdheader">发现端口连接次数:</td>
       <td class="tdbody"><label>
         <input type="text" name="textfield" id="textfield" />
       </label></td>
     </tr>
    <tr>
      <td width="250" class="tdheader"><p>忽略来自以下源IP地址的扫描检测:</p>
      <p>(用英文逗号分隔)</p></td>
      <td class="tdbody"><textarea name="" cols="20" rows="5"></textarea></td>
    </tr>
    <tr>
      <td class="tdheader">&nbsp;</td>
      <td class="tdbody"><label id="client"></label>
      <input name="input" type="button" value="确定" class="button" /></td>
    </tr>
   </tbody>
</table>
<script type="text/javascript">
$(document).ready(function() {
    $(".button").button();
});
</script>
