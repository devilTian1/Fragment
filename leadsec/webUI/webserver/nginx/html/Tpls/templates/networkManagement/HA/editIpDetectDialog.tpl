<form action="Function/networkManagement/HA/ipDetect.php" method="POST" id="editIpDetectForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加探测IP</legend>
		<div class="row">
            <label for="sip">探测IP:<em class="required">*</em></label>
            <input type="text" class="width132" name="sip" id="sip" value="<{$res.ip}>"/>
			<input type="hidden" name="old_sip" id="ols_sip" value="<{$res.ip}>"/>
        </div>
        <div class="row">
			<label for="comment">备注:</label>
			<input id="comment" class="width132" value="<{$res.comment}>" name="comment">
		</div>
    </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editIpDetectForm"));
});
</script>
