<form action="Function/resConf/time/timeList.php" method="POST" id="editTimeListForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>时间列表维护</legend>
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
        <div class="row">
            <label>&nbsp;</label>
            <label class="radio" for="startTime">起始时间:</label>
            <input type="text" name="startTime" id="startTime"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>&nbsp;</label>
            <label class="radio" for="endTime">终止时间:</label>
            <input type="text" name="endTime" id="endTime"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>&nbsp;</label>
            <div class="column column_60">
                <label>周日</label>
                <label class="radio" for="startTime">起始时间:</label>
                <input type="text" name="startTime" id="startTime"/>
            </div>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$timeList.comment}></textarea>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
    
<table style="display:none" class="column_100">
    <tr>
      <td class="tdheader" width="120"><span class="red">*</span>名称</td>
      <td class="tdbody">
        <input type="text" name="inputtext2" class="inputtext"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 ) 
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>一次性调度：
        <input name="radio" type="radio" id="radio3" value="radio" checked="checked" />      </td>
      <td class="tdbody">
         起始时间:  
        &nbsp;
        <input type="text" name="inputtext3"/>
      终止时间: 
      <input type="text" name="inputtext4"/><br/>
      有效时间格式 ( YYYY/MM/DD hh:mm 或 YYYY/MM/DD hh:mm:ss)</td>
    </tr>
    
    <tr>
      <td class="tdheader">周循环调度：
        <input type="radio" name="radio" id="radio2" value="radio" /></td>
      <td class="tdbody">
      
      <table class="column_95">
      <thead>
        <tr>
          <th width="80">调度日期</th>
          <th width="130">起始时间
            </th>
          <th width="130">终止时间 
		</th>
        </tr>
        </thead>
        <tr>
          <td>星期天</td>
          <td>
            <input type="text" name="inputtext5" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext12" class="inputtext"/>
         </td>
        </tr>
        <tr>
          <td>星期一</td>
          <td>
            <input type="text" name="inputtext6" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext13" class="inputtext"/>
          </td>
        </tr>
        <tr>
          <td>星期二</td>
          <td>
            <input type="text" name="inputtext7" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext14" class="inputtext"/>
          </td>
        </tr>
        <tr>
          <td>星期三</td>
          <td>
            <input type="text" name="inputtext8" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext15" class="inputtext"/>
          </td>
        </tr>
        <tr>
          <td>星期四</td>
          <td>
            <input type="text" name="inputtext9" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext16" class="inputtext"/>
          </td>
        </tr>
        <tr>
          <td>星期五</td>
          <td>
            <input type="text" name="inputtext10" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext17" class="inputtext"/>
          </td>
        </tr>
        <tr>
          <td>星期六</td>
          <td>
            <input type="text" name="inputtext11" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext18" class="inputtext"/>
         </td>
        </tr>
        </table>
      
        </td>
    </tr>
    <tr>
        <td class="tdheader">备注:</td>
        <td class="tdbody">
            <input name="inputtext" type="text" class="inputtext" size="50"/>
        </td>
    </tr>
</table>
</form>
<script type="text/javascript"> 
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editTimeListForm"));
});
function addRedun(){
	var dialog = StandardUiFactory.createDialog('编辑');
	var buttons = {};
	buttons['确定'] = function() {
		location.href = "index.php";
	};
	var dialogParams = {
		buttons : buttons,
		width   : 800,
		height  : 480
	};
	dialog.setOptions(dialogParams);
	$('#editRedunHtml').show();
	var htmlText=$('#editRedunHtml');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>
