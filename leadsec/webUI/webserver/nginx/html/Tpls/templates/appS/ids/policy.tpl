<table class="column_95">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_30 tdheader">检测策略</th>
      <th class="column_70">状态</th>
    </tr>
    </thead>
  <tbody>
    <tr>
      <{foreach $dataInfo as $val }>
    <tr title="<{$val.description}>">
        <td class="tdheader"><{$val.ChineseName}></td>
		<td>
		<form action="Function/appS/ids/policy.php" method="POST" 
			id="switchForm_<{$val@index}>" onSubmit="return false;">
		<input type="hidden" name="policyName" value="<{$val.EnglishName}>"/>
		<{if $val.status == Y}>
			<a href="#" onClick="switchPhysicalDev('<{$val.ChineseName}>', 'disable', '<{$val@index}>')">
			<img id="img_<{$val@index}>" src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" 
				width="16" height="16" />
			<input id="action_<{$val@index}>" type="hidden" name="action_type" value="disable"/>
			</a>
		<{else}>
			<a href="#" onClick="switchPhysicalDev('<{$val.ChineseName}>', 'enable', '<{$val@index}>')">
            <img id="img_<{$val@index}>" src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
				width="16" height="16"/>
			<input id="action_<{$val@index}>" type="hidden" name="action_type" value="enable"/>
		<{/if}>
		</form>
		</td>
    </tr>
<{foreachelse}>
    <tr><td colspan='11'>No Data</td></tr>
<{/foreach}>
    </tr>
    </tbody>
  </table>
<script type="text/javascript" src="Public/js/appS/ids/policy.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
		renderStandardUi(); 
		$('tr').tooltip();
    });
</script>
