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
            <input type="text" name="ip" id="ftpSerIP" value="<{$ftp.ftpsrv}>" />         
          </td>
        </tr>
        <tr>
          <td width="250" class="tdheader">端口:</td>
          <td class="tdbody">
            <input type="text" name="ftpPort" id="ftpPort" value="<{$ftp.port}>" size="5" maxlength="5"/>         
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
            <input type="text" name="ftpName" id="ftpName" value="<{$ftp.user}>" size="15" maxlength="15"/>         
          </td>
        </tr>
        <tr>
          <td width="250" class="tdheader">密码:</td>
          <td class="tdbody">
            <input type="password" name="password1" id="ftpPasswd" value="<{$ftp.pass}>" />
                           
          </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button" id="logServerBtn" onClick="ftpTransBtn()">
                确定</button>
                <button class="inputbtn standard" type="button" id="logServerBtn" onClick="testFtpBtn()">
                测试</button>
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
                                   分钟：<input type="text" name="ftpMinute" id="ftpMinute"  <{if $auto.minute eq 0}> value="" <{else}> value="<{$auto.minute}>" <{/if}> size="2" maxlength="2"/>&nbsp;&nbsp;&nbsp;&nbsp;  
                                  小时：<input type="text" name="ftpHour" id="ftpHour" <{if $auto.hour eq 0}> value="" <{else}> value="<{$auto.hour}>" <{/if}> size="2" maxlength="2"/> &nbsp;&nbsp;&nbsp;&nbsp;
                                  日：<input type="text" name="ftpDay" id="ftpDay" <{if $auto.day eq 0}> value="" <{else}> value="<{$auto.day}>" <{/if}> size="2" maxlength="2"/>                                                     
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
});
</script>
