<form action="Function/client/msgTrans/callowedContent.php" method="POST"
    id="editAllowedContentForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加内容白名单</legend>
        <div class="row">
            <label for="whitelist">禁止的内容:
                <em class="required">*</em></label>
            <input class="w150" type="text" name="cwhitelist"
                value="<{$data.whitelist}>"/>
            <{if $type ==='edit'}>
                <input type="hidden" name="editname" value="<{$data.whitelist}>"/>
            <{/if}>
        </div>
       
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editAllowedContentForm"));
    });
</script>
