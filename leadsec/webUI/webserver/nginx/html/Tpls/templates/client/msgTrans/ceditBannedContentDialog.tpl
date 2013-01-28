<form action="Function/client/msgTrans/cbannedContent.php" method="POST"
    id="editBannedContentForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加内容黑名单</legend>
        <div class="row">
            <label for="blacklist">禁止的内容:
                <em class="required">*</em></label>
            <input class="banned" type="text" name="cblacklist"
                value="<{$data.blacklist}>"/>
        </div>
        <div class="row">
                             支持通配符： * 代表任意字符串，包括空串
                      ? 代表任意单个字符
                      \\ 表示单个字符'\'
                      \* 表示单个字符'*'
                      \? 表示单个字符'?'   
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editBannedContentForm"));
    });
</script>
