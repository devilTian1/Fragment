<form action="Function/appS/addrBind/addrBind.php" method="POST" id="editIpDialogForm"
	onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: ''}>"/>
	<fieldset>
    <legend>添加IP/MAC地址</legend>
			<div class="row">
				<label for="dport"><em class="required">*</em>ip地址:</label>
				<input type="text" id="addip" name="addip" value=''/>
			</div>

            <div class="row">
				<label for="dport"><em class="required">*</em>MAC地址:</label>
				<input type="text" id="addmac" name="addmac" value=''>
            </div>

			<div class="row">
				<label for="dport">唯一性检查:</label>
				<input type="checkbox" id="addUnique" name="addUnique">
            </div>
	</fieldset>
</form>

<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editIpDialogForm"));
    });
</script>
