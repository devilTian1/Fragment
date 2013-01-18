<form action="Function/client/fileSync/allowedFile.php" method="POST"
    id="editAllowedFileForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$data.id}>">
    <fieldset>
        <legend>添加客户端文件名控制</legend>
        <div class="row">
            <label for="filename">允许的文件名:
                <em class="required">*</em></label>
            <input type="text" name="filename"
                value="<{$data.filename}>"/>
        </div>

        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$data.comment}></textarea>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editAllowedFileForm"));
    });
</script>
