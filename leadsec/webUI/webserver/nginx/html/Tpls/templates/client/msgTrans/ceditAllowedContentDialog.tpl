<form action="Function/client/msgTrans/callowedContent.php" method="POST"
    id="editAllowedContentForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加内容白名单</legend>
        <div class="row">
            <label for="whitelist">禁止的内容:
                <em class="required">*</em></label>
            <input class="banned" type="text" name="cwhitelist"
                value="<{$data.whitelist}>"/>
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
        validateForm($("#editAllowedContentForm"));
    });
</script>
