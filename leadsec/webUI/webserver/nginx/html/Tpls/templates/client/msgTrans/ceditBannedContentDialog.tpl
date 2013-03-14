<form action="Function/client/msgTrans/cbannedContent.php" method="POST"
    id="editBannedContentForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加内容黑名单</legend>
        <div class="row">
            <label for="blacklist">禁止的内容:
                <em class="required">*</em></label>
            <input class="w150" type="text" name="cblacklist"
                value="<{$data.blacklist}>"/>
            <{if $type ==='edit'}>
                <input type="hidden" name="editname" value="<{$data.blacklist}>"/>
            <{/if}>
        </div>
        
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editBannedContentForm"));
    });
</script>
