<form action="Function/client/fileEx/allowedFile.php" method="POST"
    id="editAllowedFileForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$data.id}>">
    <fieldset>
        <legend>添加客户端文件名控制</legend>
        <div class="row">
            <label for="FEname">名称:<em class="required">*</em></label>
            <input type="text" name="FEname" value="<{$data.name}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>/>
            <{if $type ==='edit'}>
                <input type="hidden" name="FEname" value="<{$data.name}>"/>
            <{/if}>
        </div>
        <div class="row">
            <label for="filename">允许的文件名:</label>
            <input type="text" name="FEfilename" id="filename"/>
        </div>

        <div class="row">
            <label>&nbsp;<em class="required">*</em></label>
            <div class="column column_10">
                <button type="button" class="standard floatLeft"
                    onClick="moveToFileNames()"> &gt;&gt;
                </button>
                <br/><br/>
                <button type="button" class="standard floatLeft"
                    onClick="rmFileName()"> &lt;&lt;
                </button>
            </div>
            <div class="column column_25">
                <{html_options class='multiSelect' size="5" multiple="multiple"
                    name="FEfilenames[]" id="filenames"
                    output=$data.filenames values=$data.filenames}>
	        </div>
        </div>

        <div class="row">
            <label for="comment">备注:</label>            
            <input class="comment" name="comment" id="comment" value="<{$data.comment}>"/>       
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        validateForm($("#editAllowedFileForm"));
    });
</script>
