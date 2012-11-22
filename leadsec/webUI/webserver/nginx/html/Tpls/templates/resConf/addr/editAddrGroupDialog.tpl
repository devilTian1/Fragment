<form action="Function/resConf/addr/addrGroup.php" method="POST" id="editAddrGroupForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>地址组维护</legend>
        <div class="row">
            <label for="addrGrpName">名称:<em class="required">*</em></label>
            <input type="text" name="addrGrpName" maxlength="15" value="<{$addrGroup.name}>"
                <{if $type === 'edit'}>disabled="disabled"<{/if}> id="addrGrpName"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>地址组添加元素表:</label>
	    <div class="column column_25">
		<label for="addrList">地址列表</label>
            <{html_options class='multiSelect' size="5" name="addrList" multiple="multiple" id="addrList"
                output=$addrListArr values=$addrListArr}>
	    </div>
	    <div class="column column_15">
	    	<br/>
            <button class="standard floatLeft" onClick="moveToAddrGrpMember()"> &gt;&gt;
            </button>
		    <br/><br/>
            <button class="standard floatLeft" onClick="moveToAddrList()"> &lt;&lt;
            </button>
            </div>
	    <div class="column column_25">
		<label for="addrGrpMember">地址组成员</label>
            <{html_options class='multiSelect' size="5" multiple="multiple"
                name="addrGrpMember[]" id="addrGrpMember"
                output=$addrGrpMemberArr values=$addrGrpMemberArr }>
	    </div>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$addrGroup.comment}></textarea>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function(){
        renderStandardUi();
        validateForm($("#editAddrGroupForm"));
        changeAddrType();
    });
</script>
