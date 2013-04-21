<form action="Function/resConf/time/timeGroup.php" method="POST" id="editTimeGroupForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>时间组维护</legend>
        <div class="row">
            <label for="timeGroupName">名称:<em class="required">*</em></label>
            <input class="w150" type="text" name="resTimeName" id="resTimeName" size="15" maxlength="15" value="<{$timeGroup.name}>"
            <{if $type ==='edit'}>disabled="disabled" <{/if}> id="timeGroupName"/>
            <{if $type ==='edit'}>
                <input type="hidden" name="resTimeName" value="<{$timeGroup.name}>"/>
            <{/if}>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>时间组添加元素表:</label>
            <div class="column column_25">
            <label for="timeGroup">时间列表成员</label>
                <{html_options class='multiSelect' size="5" name="timeGroup" multiple="multiple" id="timeGroup"
                    output=$timeGroupArr values=$timeGroupArr}>
            </div>
            <div class="column column_15">
                <br/>
                <button type="button" class="standard floatLeft" onClick="moveToTimeGrpMember()"> &gt;&gt;
                </button>
                <br/><br/>
                <button type="button" class="standard floatLeft" onClick="moveToTimeGroup()"> &lt;&lt;
                </button>
            </div>
            <div class="column column_25">
                <label for="timeGrpMember">时间组成员</label>
                <{html_options class='multiSelect' size="5" multiple="multiple"
                    name="timeGrpMember[]" id="timeGrpMember"
                    output=$timeGrpMemberArr values=$timeGrpMemberArr}>
	        </div>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="comment">备注:</label>           
            <input class="comment" name="comment" id="comment" value="<{$timeGroup.comment|escape}>"/>
        </div>
        <br class="clearFloat"/>
    </fieldset>

</form>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        validateForm($("#editTimeGroupForm"));
        $('#timeGroup').dblclick(function(){
        	moveToTimeGrpMember();
        });
    });
</script>
