<form action="Function/client/msgTrans/cbannedContent.php" method="POST"
    id="editBannedContentForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="hid_list" value="<{$data.blacklist}>">
    <fieldset>
        <legend>添加内容黑名单</legend>
        <div class="row">
            <label for="blacklist">禁止的内容:
                <em class="required">*</em></label>
            <textarea rows="3" cols="30" name="cblacklist" id="cblacklist" maxlength="65"><{$data.blacklist}></textarea>            	
            <{if $type ==='edit'}>
                <input type="hidden" name="editname" value="<{$data.blacklist}>"/>
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
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editBannedContentForm"));
        $('#editBannedContentForm').bind('keypress', function(event){
            if (event.keyCode == '13') {
     	        if ($('#editBannedContentForm').valid()) {
     	            ajaxSubmitForm($('#editBannedContentForm'), '结果');
     	            freshTableAndPage();
     	        }
                return false;
            }
        });
    });
</script>
