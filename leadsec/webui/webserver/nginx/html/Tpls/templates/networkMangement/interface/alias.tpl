  <table class="column_95 textMid tablesorter" id="clientTcp">
    <caption>
  	 别名设备
   </caption>
   <thead>
    <tr>
      <th class="column_10">设备名称</th>
      <th class="column_30">地址/掩码</th>
      <th class="column_20">绑定设备</th>
      <th class="column_10">别名ID</th>
      <th class="column_10">是否启用</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
     <tr>
      <td>设备名称</td>
      <td>地址/掩码</td>
      <td>绑定设备</td>
      <td>别名ID</td>
      <td><a href="#"><img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" /></a></td>
      <td>
  			<a href="#" class="edit" onclick="editAlias()">编辑</a>
            <a href="#" class="delete" onclick="delAlias()">删除</a>    
      </td>
    </tr>
    </tbody>
    <tr>
      <td>&nbsp;</td>
      <td class="tdbody"><input type="button" name="button" id="addValue" value="添加" class="inputbtn" onclick="addAlias()" /></td>
    </tr>
  </table>
  
<div id="editAliasHtml" style="display:none">
  <table class="column_95">
    <form action="xtcs.html" method="POST">
       <tbody>
      <tr>
        <td class="tdheader"><span class="red">*</span>选择绑定设备:</td>
        <td class="tdbody">
            <select name="select" id="select">
            </select>
        </td>
      </tr>
      <tr>
        <td class="tdheader"><span class="red">*</span>选择别名ID:</td>
        <td class="tdbody">
          <select name="select2" id="select2">
          </select>
        </td>
      </tr>
      <tr>
        <td class="tdheader"><span class="red">*</span>地址:</td>
        <td class="tdbody">
          <input type="text" name="inputtext"/>
        </td>
      </tr>
      <tr>
        <td class="tdheader"><span class="red">*</span>掩码: </td>
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
        <td class="tdheader">用于管理:</td>
        <td class="tdbody">
          <input type="checkbox" name="checkbox" id="checkbox" />
        </td>
      </tr>
      <tr>
        <td class="tdheader">允许 PING:</td>
        <td class="tdbody">
          <input type="checkbox" name="checkbox2" id="checkbox2" />
        </td>
      </tr>
      <tr>
        <td class="tdheader">允许 Traceroute:</td>
        <td class="tdbody">
          <input type="checkbox" name="checkbox3" id="checkbox3" />
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
	})
function addAlias(){
	var dialog = StandardUiFactory.createDialog('编辑');
	var buttons = {};
	buttons['确定'] = function() {
		location.href = "index.php";
	};
	var dialogParams = {
		buttons : buttons,
		width   : 500,
		height  : 400
	};
	dialog.setOptions(dialogParams);
	$('#editAliasHtml').show();
	var htmlText=$('#editAliasHtml');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>