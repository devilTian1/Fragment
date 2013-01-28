<form action="Function/client/fileEx/bannedContent.php" method="POST"
    id="editBannedContentForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$data.id}>">
    <fieldset>
        <legend>添加内容黑名单</legend>
        <div class="row">
            <label for="FECCname">名称:<em class="required">*</em></label>
            <input type="text" name="FECCname" value="<{$data.name}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>/>
            <{if $type ==='edit'}>
                <input type="hidden" name="FECCname" value="<{$data.name}>"/>
            <{/if}>
        </div>
        <div class="row">
            <label for="FEcontext">禁止的内容:</label>
            <input type="text" name="FEcontext" id="FEcontext"/>
        </div>

        <div class="row">
            <label>&nbsp;<em class="required">*</em></label>
            <div class="column column_10">
                <button type="button" class="standard floatLeft"
                    onClick="moveToBFlist()"> &gt;&gt;
                </button>
                <br/><br/>
                <button type="button" class="standard floatLeft"
                    onClick="rmBFlist()"> &lt;&lt;
                </button>
            </div>
            <div class="column column_25">
                <{html_options class='multiSelect' size="5" multiple="multiple"
                    name="FEbflist[]" id="bflist"
                    output=$data.bflist values=$data.bflist}>
	        </div>
        </div>

        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$data.comment}></textarea>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        validateForm($("#editBannedContentForm"));
    });
</script>
