<form action="Function/resConf/time/timeList.php" method="POST" id="editTimeListForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>时间列表维护</legend>
        <div class="row">
            <label for="timeListName">名称:<em class="required">*</em></label>
            <input class="w150" type="text" name="resTimeName" id="resTimeName"  value="<{$timeList.name}>"
            	size="15" maxlength="15" <{if $type ==='edit'}>disabled="disabled" <{/if}>/>
            <{if $type ==='edit'}>
                <input type="hidden" name="resTimeName" value="<{$timeList.name}>"/>
            <{/if}>
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
                                          有效时间格式 YYYY/MM/DD hh:mm(:ss) 
                <br/><br/>
                <label for="startTime_f">起始时间:&nbsp;</label>
                <input  class="w200"type="text" name="startTime_f" id="startTime_f" size="19" maxlength = "19" value="<{$timeList.startTime_f}>"/>
                <br/><br/>
                <label  for="endTime_f">终止时间:&nbsp;</label>
                <input class="w200" type="text" name="endTime_f" id="endTime_f"  size="19" maxlength = "19" value="<{$timeList.endTime_f}>"/>
            </div>
            <br class="clearFloat"/>
        </div>
        <div class="row weekDiv">
            <label>&nbsp;</label>
            <div class="column column_75">
                                         有效时间格式 hh:mm(:ss) 
                <br/>
                <{assign var=weekLabel value=['mon'=>'星期一', 'tue'=>'星期二', 'wed'=>'星期三', 'thu'=>'星期四', 'fri'=>'星期五', 'sat'=>'星期六', 'sun'=>'星期日']}>
                <{foreach $weekLabel as $k=>$v}>
                    <label><{$v}></label>
                    <br class="clearFloat"/>
                    <label class="w100" for="startTime_<{$k}>">起始时间:&nbsp;</label>
                    <input type="text" name="startTime_<{$k}>" id="startTime_<{$k}>" maxlength = "8" value="<{$timeList['startTime_'|cat:$k]}>"/>
                    <br class="clearFloat"/>
                    <label class="w100" for="endTime_<{$k}>">终止时间:&nbsp;</label>
                    <input type="text" name="endTime_<{$k}>" id="endTime_<{$k}>" maxlength = "8" value="<{$timeList['endTime_'|cat:$k]}>"/>
                    <br class="clearFloat"/><br/>
                <{/foreach}>
            </div>
            <br class="clearFloat"/>
        </div>
        <div class="row">
            <label for="comment">备注:</label>           
            <input class="comment" name="comment" id="comment" value="<{$timeList.comment|escape}>"/>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript"> 
$(document).ready(function() {
    changeScheduleType();
    renderStandardUi();
    validateForm($("#editTimeListForm"));
    var scheType = '<{$timeList.scheduleType}>';
    if (scheType != '') {
        $('input:radio[id!="scheduleType_' + scheType + '"]').attr('disabled', 'disabled');
    }
});
</script>
