<form action="Function/client/fileEx/bannedContent.php" method="POST"
    id="editBannedContentForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$data.id}>">
    <fieldset>
        <legend>添加内容黑名单</legend>
        <div class="row">
            <label for="FECCname">名称:<em class="required">*</em></label>
            <input class="width10em" type="text" name="FECCname" value="<{$data.name}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>/>
            <{if $type ==='edit'}>
                <input type="hidden" name="FECCname" value="<{$data.name}>"/>
            <{/if}>
        </div>
        <div class="row">
            <label for="FEcontext">禁止的内容:</label>
            <input class="width10em" type="text" name="FEcontext" id="FEcontext"/>
        </div>
        <div class="row paraminfo">
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
            <div class="column column_65">
                <{html_options class='multiSelect' size="5" multiple="multiple"
                    name="FEbflist[]" id="bflist"
                    output=$data.bflist values=$data.bflist}>
	        </div>
        </div>

        <div class="row">
            <label for="comment">备注:</label>            
            <input class="width10em comment" name="comment" id="comment" value="<{$data.comment|escape}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        validateForm($("#editBannedContentForm"));
    });
</script>
