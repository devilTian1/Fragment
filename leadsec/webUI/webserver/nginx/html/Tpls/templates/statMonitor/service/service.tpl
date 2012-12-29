<form action="Function/statMonitor/service/service.php" method="POST"
            id="switchServiceForm" onSubmit="return false;">    
<table class="column_95">
  <caption>
    服务状态
  </caption>
  <thead>
    <tr>
      <th width="250" class="tdheader">服务名称</th>
      <th class="tdbody">状态</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td width="250" class="tdheader">定制访问(TCP):</td>
      <td class="tdbody"><span class="red">启动</span></td>          
    </tr>
    <tr>
      <td class="tdheader">定制访问(UDP):</td>
      <td class="tdbody">停止</td>
    </tr>
    <tr>
      <td class="tdheader">抗DDos攻击：</td>
      <td class="tdbody">停止</td>
    </tr>
    <tr>
      <td class="tdheader">病毒防护:</td>
      <td class="tdbody">停止</td>
    </tr>
    <tr>
      <td class="tdheader">数据库同步:</td>
      <td class="tdbody"><span class="red">启动</span></td>
    </tr>
    <tr>
      <td class="tdheader">安全浏览:</td>
      <td class="tdbody">停止</td>
    </tr>
    <tr>
      <td class="tdheader">文件交换:</td>
      <td class="tdbody"><span class="red">启动</span></td>
    </tr>
    <tr>
      <td class="tdheader">文件同步:</td>
      <td class="tdbody">停止</td>
    </tr>
    <tr>
      <td class="tdheader">FTP访问:</td>
      <td class="tdbody">        
          <input type="hidden" name="switch_name"  value="ftp"/>
      	  <{if ($ftp[0] == '1')}>
      	    <a href="#" onClick="switchService('FTP访问', 'disable')">
              <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />               
              <input type="hidden" name="action"  value="disable"/>
            </a>
          <{else}>
      	    <a href="#" onClick="switchService('FTP访问', 'enable')">
               <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16"/>               
               <input type="hidden" name="action"  value="enable"/>
            </a>
          <{/if}>   
      </td>      
    </tr>
    <tr>
      <td class="tdheader">邮件访问（SMTP）:</td>
      <td class="tdbody">停止</td>
    </tr>
    <tr>
      <td class="tdheader">邮件访问(POP3):</td>
      <td class="tdbody"><span class="red">启动</span></td>
    </tr>
    <tr>
      <td class="tdheader">数据库访问：</td>
      <td class="tdbody">停止</td>
    </tr>
    <tr>
      <td class="tdheader">安全通道：</td>
      <td class="tdbody">停止</td>
    </tr>
    <tr>
      <td class="tdheader">消息传递：</td>
      <td class="tdbody">停止</td>
    </tr>
    <tr>
      <td class="tdheader">自动域名解析服务：</td>
      <td class="tdbody">启动</td>
    </tr>
   </tbody>
</table>
</form>
<script type="text/javascript" src="Public/js/statMonitor/service/service.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();  
});
</script>

