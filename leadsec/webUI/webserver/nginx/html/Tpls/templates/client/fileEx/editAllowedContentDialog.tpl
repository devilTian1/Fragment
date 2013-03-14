<form action="Function/client/fileEx/allowedContent.php" method="POST"
    id="editAllowedContentForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$data.id}>">
    <fieldset>
        <legend>添加内容白名单</legend>
        <div class="row">
            <label for="FECCname">名称:<em class="required">*</em></label>
            <input type="text" name="FECCname" value="<{$data.name}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>/>
            <{if $type ==='edit'}>
                <input type="hidden" name="FECCname" value="<{$data.name}>"/>
            <{/if}>
        </div>
        <div class="row">
            <label for="FEcontext">允许的内容:</label>
            <input type="text" name="FEcontext" id="FEcontext"/>
        </div>

        <div class="row">
            <label>&nbsp;<em class="required">*</em></label>
            <div class="column column_10">
                <button type="button" class="standard floatLeft"
                    onClick="moveToAFlist()"> &gt;&gt;
                </button>
                <br/><br/>
                <button type="button" class="standard floatLeft"
                    onClick="rmAFlist()"> &lt;&lt;
                </button>
            </div>
            <div class="column column_25">
                <{html_options class='multiSelect' size="5" multiple="multiple"
                    name="FEaflist[]" id="aflist"
                    output=$data.aflist values=$data.aflist}>
	        </div>
        </div>

        <div class="row">
            <label for="comment">备注:</label>            
             <input class="comment" name="comment" id="comment" value="<{$data.comment}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        validateForm($("#editAllowedContentForm"));
    });
</script>
