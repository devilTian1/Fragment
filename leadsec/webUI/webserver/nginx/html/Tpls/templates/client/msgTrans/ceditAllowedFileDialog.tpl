<form action="Function/client/msgTrans/callowedFile.php" method="POST"
    id="editAllowedFileForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="hid_list" value="<{$data.filename}>">
    <fieldset>
        <legend>添加客户端文件名控制</legend>
        <div class="row">
            <label for="filename">允许的文件名:
                <em class="required">*</em></label>          
            <textarea rows="5" cols="30" name="cfilename" id="cfilename" maxlength="129"><{$data.filename}></textarea>            	
            <{if $type ==='edit'}>
                <input type="hidden" name="editname" value="<{$data.filename}>"/>
            <{/if}>
        </div>
        <div class="row">
            <label>&nbsp;</label>
            <span>文件名中可以使用通配符*和? 但不能包括以下字符 % \ / : " < > | '</span>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editAllowedFileForm"));
        $('#editAllowedFileForm').bind('keypress', function(event){
            if (event.keyCode == '13') {
     	        if ($('#editAllowedFileForm').valid()) {
     	            ajaxSubmitForm($('#editAllowedFileForm'), '结果');
     	            freshTableAndPage();
     	        }
                return false;
            }
        });
    });
</script>
