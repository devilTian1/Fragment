<form action="Function/resConf/addr/addrGroup.php" method="POST" id="editAddrGroupForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>地址组维护</legend>
        <div class="row">
            <label for="addrGrpName">名称:<em class="required">*</em></label>
            <input type="text" name="addrGrpName" maxlength="15" value="<{$addrGroup.name}>"
                <{if $type === 'edit'}>readonly="readonly"<{/if}> id="addrGrpName"/>
            <input id="addrGrpIpType" type="hidden" name="addrGrpIpType" value="<{$nameIpType}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>地址组添加元素表:</label>
            <div class="column column_25">
            <label for="addrList">地址列表</label>
                <{html_options class='multiSelect' size="5" name="addrList" multiple="multiple" id="addrList"
                    output=$addrListArr values=$addrListArrValue}>
            </div>
            <div class="column column_15">
                <br/>
                <button type="button" class="standard floatLeft" onClick="moveToAddrGrpMember()"> &gt;&gt;
                </button>
                <br/><br/>
                <button type="button" class="standard floatLeft" onClick="moveToAddrList()"> &lt;&lt;
                </button>
            </div>
            <div class="column column_25">
                <label for="addrGrpMember">地址组成员</label>
                <{html_options class='multiSelect' size="5" multiple="multiple"
                    name="addrGrpMember[]" id="addrGrpMember"
                    output=$addrGrpMemberArr values=$addrGrpMemberArrValue}>
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
    });
</script>
