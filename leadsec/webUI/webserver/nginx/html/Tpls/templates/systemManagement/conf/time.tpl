  <table class="column_95">
  <caption>
  日期时间
  </caption>
  <tbody>
    <tr>
      <td width="250" class="tdheader">安全隔离网闸当前时间:</td>
      <td class="tdbody">2012/09/02 09:49:19</td>
    </tr>
    <tr>
      <td class="tdheader">管理主机当前时间:</td>
      <td class="tdbody">2012/08/17 12:46:35
      <input name="input" type="button" value="时间同步" class="btn_tb" /></td>
    </tr>
   </tbody>
</table>

<table class="column_95">
  <caption>
  时钟服务器<
  </caption>
  <tbody>
    <tr>
      <td width="250" class="tdheader">启用时钟服务器:</td>
      <td class="tdbody"><input type="checkbox" name="ch_location" /></td>
    </tr>
    <tr>
      <td class="tdheader">时钟服务器 IP:</td>
      <td class="tdbody">
        <input type="text" name="inputtext" value="192.168.5.3"/>
        <input name="input2" type="button" value="立即同步" class="btn_tb" />
      </td>
    </tr>
    <tr>
      <td class="tdheader">每隔:</td>
      <td class="tdbody">
        <input type="text" name="inputtext2" value="5" disabled="disabled" style="width:50px"/>
     分钟同步一次 ( 范围: 1-65535 默认: 5 分钟 )</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td class="tdbody"><input name="input" type="button" value="确定" class="btn_tb" /></td>
    </tr>
   </tbody>
</table>
<script type="text/javascript">
$(document).ready(function() {
    $("#add").button();
});
</script>
