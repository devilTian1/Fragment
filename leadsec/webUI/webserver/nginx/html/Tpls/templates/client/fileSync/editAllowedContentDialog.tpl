<form action="Function/client/fileSync/allowedContent.php" method="POST"
    id="editAllowedContentForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$data.id}>">
    <fieldset>
        <legend>添加内容白名单</legend>
        <div class="row">
            <label for="context">允许的内容:
                <em class="required">*</em></label>
            <input class="allow" type="text" name="context"
                value="<{$data.context}>"/>
        </div>

        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$data.comment}></textarea>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editAllowedContentForm"));
    });
</script>
