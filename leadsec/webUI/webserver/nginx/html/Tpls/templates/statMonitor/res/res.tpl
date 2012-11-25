  <table class="column_95">
  <caption>
  系统资源当前利用率
  </caption>
  <tbody>
    <tr>
      <td width="200" class="tdheader">CPU利用率:</td>
      <td class="tdbody"></td>
      <td width="100">&nbsp;</td>
      <td width="100"><a href="#">统计图</a></td>
    </tr>
     <tr>
      <td class="tdheader">内存利用率:</td>
      <td class="tdbody"></td>
      <td><a href="#">详细信息</a></td>
      <td><a href="#">统计图</a></td>
    </tr>
    <tr>
      <td class="tdheader">磁盘利用率:</td>
      <td class="tdbody"></td>
      <td><a href="#">详细信息</a></td>
      <td></td>
    </tr>
   </tbody>
</table>

<table class="column_95">
  <tbody>
    <tr>
      <td width="200" class="tdheader">资源监控服务</td>
      <td width="80">
      	<img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="16" />
        </td>
      <td class="tdbody">
      	<input name="input2" type="button" value="停止" class="button" />
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
