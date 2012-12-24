<form action="Function/appS/virusProtection/virusUpgrade.php" method="POST" id="autoUpSetForm"
	onSubmit="return false;">
	<table class="column_95">
		<caption>
			自动升级
		</caption>
		<tbody>
			<tr>
				<td class="tdheader" width="200">
					<label><input type="checkbox" name="autoUpEnable" id="autoUpEnable" />
					启用 </label>:
				</td>
      			<td class="tdbody">升级服务器地址：
        			<input type="text" name="upAddr" id="upAddr" value="<{$autoUpSet.upaddr}>"/>
        			&nbsp;&nbsp;升级服务器端口：
        			<input type="text" name="upPort" id="upPort" value="<{$autoUpSet.upport}>"/>
      			</td>
			</tr>
    		<tr>
				<td class="tdheader">
        			<input type="radio" name="upType" value="1" />
					实时升级:
				</td>
      			<td class="tdbody">&nbsp;</td>
    		</tr>
    		<tr>
				<td class="tdheader"><input type="radio" name="upType" value="2" />
					定时升级:
				</td>
      			<td class="tdbody">
					<div>
        				<label>
          					<input type="radio" name="upWay" value="1" />
        				</label>
        				每隔
        				<label>
          					<{html_options name="selectLengthList"
							output=array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
							values=array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
							selected=<{$autoUpSet.shour|default:1}> id="selectLengthList" }>    
							小时
						</label>
					</div>  
        			<div class="rowElem">
          				<label>
            				<input type="radio" name="upWay" value="2" />
          				</label>
          				每天
          				<label>
            				<{html_options name="selectTimeList"
            				output=array(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
				          	values=array(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
				          	selected=<{$autoUpSet.sday|default:1}> id="selectTimeList"}> 
							点（小时）
						</label>
        			</div>
        			<div class="rowElem">
          				<label>
            				<input type="radio" name="upWay" value="3" />
          				</label>
          				每周
          				<label>
				            <{html_options name="selectDayList" id="selectDayList"
				            output=array('星期一','星期二','星期三','星期四','星期五','星期六','星期天')
				          	values=array(1,2,3,4,5,6,0) 
				          	selected=<{$autoUpSet.sweek|default:1}> }> 
							天
				            <{html_options name="selectHourList" id="selectHourList"
				            output=array(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
				          	values=array(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23) 
				          	selected=<{$autoUpSet.swh|default:1}> }>
            				点（小时） 
            			</label>
        			</div>
      			</td>
    		</tr>
    		<tr>
      			<td class="tdheader"></td>
      			<td>
      				<input type="hidden" name="flgUpNow" id="flgUpNow" value="0"/>
			        <button type="button" width="50" class="inputbtn standard " onclick="upVirusForm()">确定</button>
			        <button type="button" width="50" class="inputbtn standard " onclick="upNowForm()" >立即升级</button>
      			</td>
    		</tr>
    	</tbody>
  	</table>
  
</form>
<br/>
<form action="Function/appS/virusProtection/virusUpgrade.php?c=1" method="POST" id="limitErrForm"
onSubmit="return false;">
	<table class="column_95">
	    <caption>
	    	手动升级
	    </caption>
	    <tbody>
	        <tr>
	            <td class="tdheader" width="200">病毒库当前版本：</td>
	            <td class="tdbody"><span class="red">2001.8.1</span></td>
	        </tr>
	        <tr>
	            <td class="tdheader"><span class="red">*</span>升级文件:</td>
	            <td class="tdbody">
	               <input name="" type="file" />
	            </td>
	        </tr>
        	<tr>
	            <td></td>
	            <td class="tdbody">
	                <button class="inputbtn standard" type="button"
	                    id="setLimitErrTimeBtn" onClick="setLimitErrTime()">
	                	升级
	                </button>
	            </td>
	        </tr>
    	</tbody>
	</table>
</form>
<br/>
<table class="column_95 textMid tablesorter" id="accountTable">
    <caption>导出升级历史</caption>
    <thead>
        <tr>
            <th class="column_20">序号</th>
            <th class="column_30">更新版本</th>
            <th class="column_30">当前时间</th>
            <th class="column_20">时间</th>
        </tr>
    </thead>
    <tbody>
        <tr><td colspan='4'>Loading ...</td></tr>
    </tbody>
</table>
<button class="floatLeft inputbtn" type="button"
    onClick="openNewAccountDialog()" id="add">
导出升级历史</button>

<script type="text/javascript" src="Public/js/appS/virusProtection/virusUpgrade.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	renderStandardUi();
	validateForm($("#autoUpSetForm"));
	initAutoUpSet();
	$("#autoUpEnable").click(function(){
		if($("#autoUpEnable").attr("checked") == "checked")
		{
			$("input[name='upType']").removeAttr("disabled");
			$("#upAddr").removeAttr("disabled");
			$("#upPort").removeAttr("disabled");
		}
		else{
			$("input[name='upType']").attr("disabled",'disabled');
			$("#upAddr").attr("disabled",'disabled');
			$("#upPort").attr("disabled",'disabled');
		}
		upTypeCtrl();
	});
	$("input[name='upType']").click(function(){
		upTypeCtrl();
	});
	$("input[name='upWay']").click(function(){
		upWayTimeCtrl();
	});
});

function initAutoUpSet(){
	if('<{$autoUpSet.upenable}>' == '1')
	{
		$("#autoUpEnable").attr("checked",'checked');
	}
	$("input[name='upType']:eq(<{$autoUpSet.uptype}>)").attr("checked",'checked');
	$("input[name='upWay']:eq(<{$autoUpSet.upway}>)").attr("checked",'checked');
	// 逻辑控制
	if($("#autoUpEnable").attr("checked") == "checked")
	{
		$("input[name='upType']").removeAttr("disabled");
		$("#upAddr").removeAttr("disabled");
		$("#upPort").removeAttr("disabled");
	}
	else{
		$("input[name='upType']").attr("disabled",'disabled');
		$("#upAddr").attr("disabled",'disabled');
		$("#upPort").attr("disabled",'disabled');
	}
	upTypeCtrl();	
}
</script>
