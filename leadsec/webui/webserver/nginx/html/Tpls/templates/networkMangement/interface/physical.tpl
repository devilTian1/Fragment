<table class="column_95 textMid tablesorter" id="clientTcp">
 <caption>
      物理设备
 </caption>
   <thead><tr>
      <th class="column_10">设备名称</th>
      <th class="column_20">地址/掩码</th>
      <th class="column_20">设备属性</th>
      <th class="column_20">地址获取</th>
      <th class="column_10">是否启用</th>
      <th class="column_20">操作</th>
    </tr></thead>
    <tbody>
    <tr>
      <td>fe1</td>
      <td>10.0.0.1/255.255.255.0</td>
      <td>管理接口</td>
      <td>静态指定</td>
      <td><a href="#"><img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" /></a></td>
      <td><a href="#" class="edit" onclick="editPhysical()">编辑</a></td>
    </tr>
    </tbody>
 </table>

<div id="editPhysicalHtml" style="display:none">
  <table class="column_95">
    <form action="xtcs.html" method="POST">
    <tbody>
    <tr>
      <td class="tdheader">名称:</td>
      <td class="tdbody">
        <input type="text" name="inputtext2" value="fe2" readonly="readonly"/>
        &nbsp;&nbsp;&nbsp;( 不能修改 )</td>
    </tr>
    <tr>
      <td class="tdheader">MAC 地址: </td>
      <td class="tdbody">
        <input type="text" name="inputtext2"/>
      </td>
    </tr>
    <tr>
      <td class="tdheader">链路工作模式:</td>
      <td class="tdbody">
        <label>
          <select name="select" id="select">
            </select>
        </label>
        &nbsp;</td>
    </tr>
    <tr>
      <td class="tdheader">链路速度:</td>
      <td class="tdbody">
        <select name="select2" id="select2">
        </select>
      </td>
    </tr>
    <tr>
      <td class="tdheader">MTU:</td>
      <td class="tdbody">
        <input type="text" name="inputtext3"/>
      </td>
    </tr>
    <tr>
      <td class="tdheader">工作模式: </td>
      <td class="tdbody">
        <select name="select3" id="select3">
        </select>
      </td>
    </tr>
    <tr>
      <td class="tdheader">IP地址获取:</td>
      <td class="tdbody">
        <select name="select4" id="select4">
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
      <td class="tdheader">允许未绑定的IPMAC地址通过:</td>
      <td class="tdbody">
        <input type="checkbox" name="checkbox2" id="checkbox2" />
      </td>
    </tr>
    <tr>
      <td class="tdheader">开启IP地址欺骗检查:</td>
      <td class="tdbody">
        <input type="checkbox" name="checkbox3" id="checkbox3" />
     </td>
    </tr>
    <tr>
      <td class="tdheader">用于管理:</td>
      <td class="tdbody">
        <input type="checkbox" name="checkbox4" id="checkbox4" />
      </td>
    </tr>
    <tr>
      <td class="tdheader">允许 PING:</td>
      <td class="tdbody">
        <input type="checkbox" name="checkbox5" id="checkbox5" />
      </td>
    </tr>
    <tr>
      <td class="tdheader">允许 Traceroute:</td>
      <td class="tdbody">
        <input type="checkbox" name="checkbox6" id="checkbox6" />
      </td>
    </tr>
    <tr>
      <td class="tdheader">是否启用:</td>
      <td class="tdbody">
        <input type="checkbox" name="checkbox7" id="checkbox7" />
      </td>
    </tr>
    </tbody>
    </form>
  </table>
</div>

<script type="text/javascript">
$(document).ready(function() {
  
});
function editPhysical(){
	var dialog = StandardUiFactory.createDialog('编辑');
	var buttons = {};
	buttons['确定'] = function() {
		location.href = "index.php";
	};
	var dialogParams = {
		buttons : buttons,
		width   : 600,
		height  : 550
	};
	dialog.setOptions(dialogParams);
	$('#editPhysicalHtml').show();
	var htmlText=$('#editPhysicalHtml');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>
