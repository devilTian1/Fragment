<table class="column_95">
  <caption>
    服务状态
  </caption>
  <thead>
    <tr>
      <th class="column_30 tdheader">服务名称</th>
      <th class="column_70">状态</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <{foreach $list_out as $service}>
	    <tr>
	      <td class="tdheader"><{$service.name}></td>    
	      <td>
	        <form action="Function/systemManagement/conf/service.php" method="POST"
	            id="switchServiceForm_<{$service.index}>" onSubmit="return false;">
	            <input type="hidden" name="switch_name_<{$service.index}>" value="<{$service.name}>"/>
	      	<{if $service.value eq 1}>
	      		<a href="#" onClick="switchService('<{$service.name}>', 'disable','<{$service.index}>')">
	                <img id="img_<{$service.index}>" class="service_img" src="<{$smarty.const.THEME_PATH}>/images/icon/select.png"
	                width="16" height="16" />
	                <input id="action_<{$service.index}>" type="hidden" name="action_<{$service.index}>" value="disable"/>
	            </a>
	        <{/if}>
	        <{if $service.value eq 0}>
	      		<a href="#" onClick="switchService('<{$service.name}>', 'enable','<{$service.index}>')">
	        	    <img id="img_<{$service.index}>" class="service_img" src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
	                width="16" height="16"/>
	                <input id="action_<{$service.index}>" type="hidden" name="action_<{$service.index}>" value="enable"/>
	            </a>
	        <{/if}>
	        </form>
	        </td>       
	    </tr>
		<{foreachelse}>
	    <tr><td colspan='2'>No service </td></tr>
		<{/foreach}>
    </tr>
   </tbody>
</table>
<script type="text/javascript" src="Public/js/systemManagement/conf/service.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();  
});
</script>

