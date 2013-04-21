<form action="Function/client/msgTrans/callowedContent.php" method="POST"
    id="editAllowedContentForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加内容白名单</legend>
        <div class="row">
            <label for="whitelist">允许的内容:
                <em class="required">*</em></label>
            <input class="w200" type="text" name="cwhitelist" maxlength="64"
                value="<{$data.whitelist}>"/>
            <{if $type ==='edit'}>
                <input type="hidden" name="editname" value="<{$data.whitelist}>"/>
            <{/if}>
        </div>
        <div class="row">
            <ul>
                <li>               
                                                      支持通配符： * 代表任意字符串，包括空串
                </li>
                <li>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;? 代表任意单个字符
                </li>
                <li>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\\ 表示单字'\'
                </li>
                <li>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\* 表示单字'*'
                </li>
                <li>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\? 表示单字'?'
                </li>
            </ul>
      
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editAllowedContentForm"));
    });
</script>
