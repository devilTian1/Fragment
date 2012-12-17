<form action="Function/resConf/user/userList.php" method="POST" id="editImportSnFileForm" onSubmit="return false;">
    <fieldset>
        <legend>SN文件导入</legend>
        <div class="row">
            <label>导入SN文件:</label>
            <input class="uploadFile" type="file" name="importFile" id="sn"/>
            <input type="hidden" name="snName" value="<{$name}>"/>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editImportSnFileForm"));
});
</script>
