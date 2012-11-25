<table class="column_95">
  <caption>
  网络调试工具
  </caption>
  <thead>
  	<tr>
      <th width="120">调试工具</th>
      <th class="tdbody">调试参数</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><label><input name="test" type="radio" value="" />Ping</label></td>
      <td class="tdbody"><label>IP地址<input name="" type="text" /></label></td>
    </tr>
    <tr>
      <td><label><input name="test" type="radio" value="" />traceroute</label></td>
      <td class="tdbody"><label>IP地址<input name="" type="text" /></label></td>
    </tr>
    <tr>
      <td><label><input name="test" type="radio" value="" />tcpdump</label></td>
      <td class="tdbody"><label>网络接口
        <select name="select" id="select">
        </select>
      </label></td>
    </tr>
    <tr>
      <td><label><input name="test" type="radio" value="" />arp</label></td>
      <td class="tdbody">&nbsp;</td>
    </tr>
    <tr>
      <td><label><input name="test" type="radio" value="" />routeshow</label></td>
      <td class="tdbody">&nbsp;</td>
    </tr>
    <tr>
      <td></td>
      <td class="tdbody"><input type="button" class="button" name="button" id="button" value="开启调试" /></td>
    </tr>
   </tbody>
</table>
<script type="text/javascript">
$(document).ready(function() {
    $(".button").button();
});
</script>
