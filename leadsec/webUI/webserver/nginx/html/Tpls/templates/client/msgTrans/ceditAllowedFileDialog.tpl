<form action="Function/client/msgTrans/callowedFile.php" method="POST"
    id="editAllowedFileForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加客户端文件名控制</legend>
        <div class="row">
            <label for="filename">允许的文件名:
                <em class="required">*</em></label>
            <input type="text" name="cfilename"
                value="<{$data.filename}>"/>
        </div>
        <div class="row">
                                 文件名中可以使用通配符*和? 但不能包括以下字符 % \ / : " < > | '    
        </div>            
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editAllowedFileForm"));
    });
</script>
