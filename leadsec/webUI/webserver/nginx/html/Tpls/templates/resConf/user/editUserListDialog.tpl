<form action="Function/resConf/user/userList.php" method="POST" id="editUserListForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>用户列表维护</legend>
        <div class="row">
            <label for="timeListName">名称:<em class="required">*</em></label>
            <input type="text" name="timeListName" maxlength="15" value="<{$timeList.name}>"
            <{if $type === 'edit'}>readonly="readonly"<{/if}> id="timeListName"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="scheduleType">调度类型:</label>
            <{html_radios class="radio" name=scheduleType label_ids=true values=array('oneTime', 'week')
                output=array('一次性调度', '周循环调度')
                selected=$timeList.scheduleType|default: 'oneTime' onClick="changeScheduleType()"
            }>
        </div>
        <br class="clearFloat"/>
        <div class="row oneTimeDiv">
            <label>&nbsp;</label>
            <div class="column column_75">
                <label class="note">有效时间格式 YYYY/MM/DD hh:mm 或 YYYY/MM/DD hh:mm:ss</label>
                <br/><br/>
                <label class="radio" for="startTime_f">起始时间:&nbsp;</label>
                <input type="text" name="startTime_f" id="startTime_f" value="<{$timeList.startTime_f}>"/>
                <br/><br/>
                <label class="radio" for="endTime_f">终止时间:&nbsp;</label>
                <input type="text" name="endTime_f" id="endTime_f" value="<{$timeList.endTime_f}>"/>
            </div>
            <br class="clearFloat"/>
        </div>
        <div class="row weekDiv">
            <label>&nbsp;</label>
            <div class="column column_75">
                <label class="note">有效时间格式 hh:mm 或 hh:mm:ss</label>
                <br/>
                <{assign var=weekLabel value=['mon'=>'星期一', 'tue'=>'星期二', 'wed'=>'星期三', 'thur'=>'星期四', 'fri'=>'星期五', 'sat'=>'星期六', 'sun'=>'星期日']}>
                <{foreach $weekLabel as $k=>$v}>
                    <label><{$v}></label>
                    <br class="clearFloat"/>
                    <label class="radio" for="startTime_<{$k}>">起始时间:&nbsp;</label>
                    <input type="text" name="startTime_<{$k}>" id="startTime_<{$k}>" value="<{$timeList['startTime_'|cat:$k]}>"/>
                    <br class="clearFloat"/>
                    <label class="radio" for="endTime_<{$k}>">终止时间:&nbsp;</label>
                    <input type="text" name="endTime_<{$k}>" id="endTime_<{$k}>" value="<{$timeList['endTime_'|cat:$k]}>"/>
                    <br class="clearFloat"/><br/>
                <{/foreach}>
            </div>
            <br class="clearFloat"/>
        </div>
        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$timeList.comment}></textarea>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editUserListForm"));
});
</script>
