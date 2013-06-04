<table class="column_95 textMid tablesorter" id="downHistoryTable">
    <caption>
           下载历史记录
    </caption>
    <thead>
    <tr>
      <th class="column_25" >客户端IP</th>
      <th class="column_25" >开始时间</th>
      <th class="column_25" >结束时间</th>
      <th class="column_25" >结果</th>
    </tr>
    </thead>
   <tbody>
    <{foreach $downData as $value }>
    <tr>
        <td><{$value.ip}></td>
        <td><{$value.start}></td>
        <td><{$value.end}></td>
        <td><{$value.result}></td>     
    </tr>
	<{foreachelse}>
    <tr><td colspan='4'>No Data</td></tr>
	<{/foreach}>
    </tbody>
  </table>

<script type="text/javascript" src="Public/js/networkManagement/HA/syncConf.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        validateForm($("#downHistoryTable"));
    });
</script>