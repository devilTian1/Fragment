<form action="Function/statMonitor/res/res.php" method="POST" id="setConfForm"
    onSubmit="return false;">
  <table class="column_95">
  <caption>
  系统资源当前利用率
  </caption>
  <tbody>
    <tr>
      <td width="200" class="tdheader">CPU利用率:</td>
      <td class="tdbody"><{$cpuused}></td>
      <td width="100">&nbsp;</td>
      <td width="100"><a href="#" onclick="openCPUChartDialog()">统计图</a></td>
    </tr>
     <tr>
      <td class="tdheader">内存利用率:</td>
      <td class="tdbody"><{$memused}></td>
      <td><a href="javascript:openInfo('statMonitor/res/meminfo.tpl','mem','内存详细信息')">详细信息</a></td>
      <td><a href="#" onclick="openMemChartDialog()">统计图</a></td>
    </tr>
    <tr>
      <td class="tdheader">磁盘利用率:</td>
      <td class="tdbody"><{$devused}></td>
      <td><a href="javascript:openInfo('statMonitor/res/devinfo.tpl','dev','磁盘详细信息')">详细信息</a></td>
      <td></td>
    </tr>
   </tbody>
</table>

<table class="column_95">
  <tbody>
    <tr>
      <td width="200" class="tdheader">资源监控服务</td>
      <td width="80">
      	<{if $active eq 'on'}>
            <img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="16" />
        <{else}>
            <img src="<{$smarty.const.THEME_PATH}>/images/icon/stoplink.gif" width="16" height="16" />
        <{/if}>
      </td>
      <td class="tdbody">
      	<{if $active eq 'on' or $active eq 'off'}><input name="active" id="active" type="button" value="<{if $active eq 'on'}>停止<{elseif $active eq 'off'}>开始<{/if}>" class="button" onClick="resActive()"/><{/if}>
       </td>
    </tr>
  </tbody>
</table>
</form>
<script type="text/javascript" src="Public/js/statMonitor/res/res.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $(".button").button();
});
</script>
