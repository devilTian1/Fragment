<form action="Function/client/safeBrowse/urlFilter.php" method="POST"  id="editUrlFilterForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<input type="hidden" name="hid_list" value="<{$editUrl.list}>">
	<fieldset>
    	<legend>管理URL过滤</legend>
    	<div class="row">
    		<label>URL:<em class="required">*</em></label>
    		<input type="text" name="url_list" value="<{$editUrl.list}>" size="50" maxlength="1023" class="width132"/>
    		<br class="clearFloat">(域名前加"."表示禁止该域名及其子域名，否则表示只禁止该域名)
    	</div>
    
        <div class="row">
        	<label>备注:</label>        	
        	<input class="comment" name="comment" id="comment" value="<{$editUrl.comment|escape}>"/>
        </div>
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	validateForm($("#editUrlFilterForm"));	
});
</script>