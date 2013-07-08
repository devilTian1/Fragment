<form action="Function/log/conf/ftpConf.php" method="POST"
    id="ftpTransForm" onSubmit='return false;'>
<input type='hidden' name="action" value="" id="action"/>
<table class="column_95">
    <caption>
    ftp相关配置
    </caption>
    <tbody>        
        <tr>
          <td width="250" class="tdheader">ftp服务器 IP:</td>
          <td class="tdbody">
            <input class="w150" type="text" name="ip" id="ftpSerIP" value="<{$ftp.ftpsrv}>" />         
          </td>
        </tr>
        <tr>
          <td width="250" class="tdheader">端口:</td>
          <td class="tdbody">
            <input type="text" class="port" name="ftpPort" id="ftpPort" value="<{$ftp.port}>" size="5" maxlength="5"/>         
          </td>
        </tr>
        <tr>
          <td width="250" class="tdheader">传输模式:</td>
          <td class="tdbody">
            <{html_options  class="w100" name="ftpMode" id="ftpMode"
                    output=array('主动','被动') 
                    values=array('1','0')
                    selected=$ftp.passive|default: '1'  }>          
          </td>
        </tr>
        <tr>
          <td width="250" class="tdheader">用户名:</td>
          <td class="tdbody">
            <input class="w150" type="text" name="ftpName" id="ftpName" value="<{$ftp.user}>" size="15" maxlength="15"/>         
          </td>
        </tr>
        <tr>
          <td width="250" class="tdheader">密码:</td>
          <td class="tdbody">
            <input class="w150" type="password" name="password1" id="ftpPasswd" value="<{$ftp.pass}>" />
                           
          </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button" id="logServerBtn" onClick="ftpTransBtn()">
                确定</button>
                <button class="inputbtn standard" type="button" id="logServerBtn" onClick="testFtpBtn()">
                测试</button>
                <button class="inputbtn standard" type="button" id="ClearlogServerBtn" onClick="clearFtpBtn()">
               清除</button>
            </td>
        </tr>
    </tbody>
</table>
</form>
<br/>
<form action="Function/log/conf/ftpConf.php?auto=1" method="POST" id="logTransForm"
    onSubmit='return false;'>
<table class="column_95">
    <caption>
          自动上传日志
    </caption>
    <tbody>
    	<tr>
          <td width="250" class="tdheader">自动上传:</td>
          <td class="tdbody">
              <input class='floatLeft' type="checkbox" id ="autoUploadChk" name="autoUpload" 
                  <{if $auto.enable eq 1}>checked="checked"<{/if}>/>
          </td>
        </tr>
        <tr>
          <td width="250" class="tdheader">上传间隔:</td>
          <td class="tdbody">                                  
              <div>
        	      <label>
          		      <input type="radio" id="upWay" name="upWay" value="1" />
        		  </label>
        				每隔
        		  <label>
          		      <{html_options name="selectLengthList" id="selectLengthList"
					      output=array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
						  values=array(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
						  selected=<{$auto.shour|default:1}> }>    
						小时
				  </label>
			  </div>
			  <div class="rowElem">
          	      <label>
            		   <input type="radio" id="upWay" name="upWay" value="2" />
          		  </label>
          				每天
          		  <label>
            	      <{html_options name="selectTimeList" id="selectTimeList"
            		      output=array(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
				          values=array(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
				          selected=<{$auto.sday|default:1}> }> 
						 点（小时）
				   </label>
        	   </div>
        	   <div class="rowElem">
          	       <label>
            				<input type="radio" id="upWay" name="upWay" value="3" />
          		   </label>
          				每周

				       <{html_options name="selectDayList" id="selectDayList"
				           output=array('星期一','星期二','星期三','星期四','星期五','星期六','星期日')
				           values=array(1,2,3,4,5,6,0) 
				           selected=<{$auto.sweek|default:1}> }> 
							天&nbsp;
				       <{html_options name="selectHourList" id="selectHourList"
				           output=array(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
				           values=array(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23) 
				           selected=<{$auto.swh|default:1}> }>
            			       点（小时） 

              </div>                                                                                    
          </td>         
        </tr>             
        <tr>
            <td>&nbsp;</td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button" id="logServerBtn" onClick="logTransBtn()">
              	 确定</button>
              	<button class="inputbtn standard" type="button" id="logTransAllright" onClick="logTransAllrightBtn()">
              	 立即上传</button>
            </td>
        </tr>
    </tbody>
</table>
</form>

<script type="text/javascript" src="Public/js/log/conf/ftpConf.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#ftpTransForm"));
    validateForm($("#logTransForm"));        
    initAutoUpSet();
    upWayTimeCtrl();
    $("input[name='upWay']").click(function(){
		upWayTimeCtrl();
	});  
});
function initAutoUpSet(){
	$("input[name='upWay'][value=<{$auto.upway}>]").attr("checked",'checked');
		
}
</script>
