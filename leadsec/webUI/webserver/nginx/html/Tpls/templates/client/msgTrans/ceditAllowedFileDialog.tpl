<form action="Function/client/msgTrans/callowedFile.php" method="POST"
    id="editAllowedFileForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加客户端文件名控制</legend>
        <div class="row">
            <label for="filename">允许的文件名:
                <em class="required">*</em></label>
            <input class="w150" type="text" name="cfilename"
                value="<{$data.filename}>"/>
            <{if $type ==='edit'}>
                <input type="hidden" name="editname" value="<{$data.filename}>"/>
            <{/if}>
        </div>
                 
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editAllowedFileForm"));
    });
</script>
