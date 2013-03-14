<form action="Function/client/safeBrowse/postfixFilter.php" method="POST"  id="editPostfixFilterForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<input type="hidden" name="hid_list" value="<{$editPostfix.list}>">
	<fieldset>
    	<legend>管理文件名后缀过滤</legend>
    	<div class="row">
    		<label>文件名后缀:<em class="required">*</em></label>
    		<input type="text" name="postfix_list" value="<{$editPostfix.list}>" size="50" maxlength="1023"/>
    		(文件名后缀按.exe或.txt的方式输入,只有.表示所有的没有后缀的文件)
    	</div>
    
        <div class="row">
        	<label>备注:</label>        	
        	<input class="comment" name="comment" id="comment" value="<{$editPostfix.comment}>"/>
        </div>
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	validateForm($("#editPostfixFilterForm"));	
});
</script>