<form action="Function/resConf/user/userList.php" method="POST" id="editImportSnFileForm"
    enctype="multipart/form-data">
    <input type="hidden" name="snName" value="<{$name}>"/>
    <fieldset>
        <legend>SN文件导入</legend>
        <div class="row">
            <label for="importFile">导入SN文件:</label>
            <input class="uploadFile" type="file" name="importFile" id="importFile"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editImportSnFileForm"));
});
</script>
