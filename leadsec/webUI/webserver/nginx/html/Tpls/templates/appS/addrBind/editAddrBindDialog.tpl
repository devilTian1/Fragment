<form action="Function/appS/addrBind/addrBind.php" method="POST" id="editIpAddrForm"
	onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<fieldset>
    <legend>地址列表维护</legend>
			<input type="hidden" name="ipaddressindex" value="<{$edit_result.id}>"/>
			<div class="row">
				<label for="dport"><em class="required">*</em>ip地址:</label>
				<input type="text" id="ipaddress" name='ipaddress' value="<{$edit_result.ip}>">
			</div>

            <div class="row">
				<label for="dport"><em class="required">*</em>MAC地址:</label>
				<input type="text" id="macaddress" name='macaddress' value="<{$edit_result.mac}>">
            </div>

			<div class="row">
				<label for="dport">唯一性检查:</label>
				<input type="checkbox" id="unique" name="unique"
				<{if $edit_result.doubledir eq 1}>
				checked="checked" 
				<{/if}> />
            </div>
	</fieldset>
</form>

<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editIpAddrForm"));
    });
</script>
