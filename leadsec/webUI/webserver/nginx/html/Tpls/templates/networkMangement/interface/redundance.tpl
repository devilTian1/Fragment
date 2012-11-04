<table class="column_95 textMid tablesorter" id="clientTcp">
 <caption>
  	  冗余设备  
   </caption>
   <thead><tr>
      <th class="column_10">设备名称</th>
      <th class="column_20">IP地址/掩码</th>
      <th class="column_10">工作模式</th>
      <th class="column_15">IP地址获取</th>
      <th class="column_15">绑定设备列表</th>
      <th class="column_10">是否启用</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>fe1</td>
      <td>10.0.0.1/255.255.255.0</td>
      <td>管理接口</td>
      <td>静态指定</td>
      <td>&nbsp;</td>
      <td><a href="#"><img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" /></a></td>
      <td>
      	  <a href="#" class="edit" onclick="editRedundance()">编辑</a>
          <a href="#" class="delete" onclick="delRedundance()">删除</a> 
      </td>
    </tr>
    </tbody>
    <tr>
      <td>&nbsp;</td>
      <td class="tdbody">
        <input type="button" name="button" id="addValue" value="添加" class="inputbtn" onclick="addRedun()" />
      </td>
    </tr>
  </table>
  
<div id="editRedunHtml" style="display:none">
  <table class="column_100">
  <tbody>
    <tr>
      <td class="tdheader" width="180"><span class="red">*</span>选择设备名称:</td>
      <td class="tdbody">
        <input type="text" name="inputtext2" class="inputtext"/>
      </td>
    </tr>
      <tr>
        <td class="tdheader"><span class="red">*</span>工作模式:</td>
        <td class="tdbody">
            <select name="select" id="select" class="inputselect">
            </select>
		</td>
      </tr>
      <tr>
        <td class="tdheader">IP地址获取: </td>
        <td class="tdbody">
          <select name="select2" id="select2" class="inputselect">
          </select>
        </td>
      </tr>
      <tr>
        <td class="tdheader">开启IPMAC地址绑定:</td>
        <td class="tdbody">
          <input type="checkbox" name="checkbox" id="checkbox" />
        </td>
      </tr>
      <tr>
        <td class="tdheader">允许未绑定的IPMAC地址通过: <br /></td>
        <td class="tdbody">
          <input type="checkbox" name="checkbox2" id="checkbox2" />
        </td>
      </tr>
      <tr>
        <td class="tdheader">开启IP地址欺骗检查: <br /></td>
        <td class="tdbody">
          <input type="checkbox" name="checkbox3" id="checkbox3" />
        </td>
      </tr>
      <tr>
        <td class="tdheader">绑定设备选择:</td>
        <td class="tdbody">
        <table class="column_95">
          <tr>
            <td width="25%" align="right">
            可选绑定设备列表<br/>
              <select name="select3" size="5" id="select3" class="w200">
              </select>
            </td>
            <td width="15%" align="center" valign="middle">
            <br />
              <input type="button" name="button" id="button" value="&gt;&gt;" />
              <br />
              <br />
              <input type="button" name="button2" id="button2" value="&lt;&lt;" />
            </td>
            <td width="60%">
            绑定设备列表<br/>
            <select name="select4" size="5" id="select4" class="w200">
            </select></td>
          </tr>
        </table>
        
        </td>
      </tr>
      <tr>
        <td class="tdheader">允许 PING:</td>
        <td class="tdbody">
          <input type="checkbox" name="checkbox4" id="checkbox5" />
        </td>
      </tr>
      <tr>
        <td class="tdheader">允许 Traceroute:</td>
        <td class="tdbody">
          <input type="checkbox" name="checkbox4" id="checkbox6" />
        </td>
      </tr>
      <tr>
        <td class="tdheader">是否启用:</td>
        <td class="tdbody">
          <input type="checkbox" name="checkbox4" id="checkbox8" />
        </td>
      </tr>
      </tbody>
  </table>
</div>
<script type="text/javascript"> 
$(document).ready(function() {
   
});
function addRedun(){
	var dialog = StandardUiFactory.createDialog('编辑');
	var buttons = {};
	buttons['确定'] = function() {
		location.href = "index.php";
	};
	var dialogParams = {
		buttons : buttons,
		width   : 850,
		height  : 520
	};
	dialog.setOptions(dialogParams);
	$('#editRedunHtml').show();
	var htmlText=$('#editRedunHtml');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>
