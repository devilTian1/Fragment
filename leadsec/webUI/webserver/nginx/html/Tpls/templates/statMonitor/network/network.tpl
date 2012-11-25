<table class="column_95 textMid">
  <caption>
  网络状态
  </caption>
  <thead>
  	<tr>
      <th width="200">网络设备</th>
      <th>状态</th>
      <th colspan="3">流量</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td width="200">fs1</td>
      <td class="tdbody"><img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="16" /></td>
      <td>发送 0 字节 </td>
      <td>接收 0 字节 </td>
      <td><a id="showzt" href="#">当前状态</a> <a id="showtj" href="#">统计图</a></td>
    </tr>
   </tbody>
</table>

<table class="column_95">
  <tbody>
  <tr>
      <td width="200" class="tdheader">网闸隔离卡状态:</td>
      <td colspan="2" class="tdbody">
      	<img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="16" />
      </td>
    </tr>
    <tr>
      <td width="200" class="tdheader">设备监控服务:</td>
      <td width="80" class="tdbody">
      	<img src="<{$smarty.const.THEME_PATH}>/images/icon/stoplink.gif" width="16" height="16" />
        </td>
      <td class="tdbody">
      	<input name="input2" type="button" value="启动" class="button" />
      	<input name="input3" type="button" value="刷新" class="button" />
<input name="input" type="button" value="清空数据文件" class="button" />
       </td>
    </tr>
  </tbody>
</table>
<script type="text/javascript">
$(document).ready(function() {
    $(".button").button();
});
</script>
