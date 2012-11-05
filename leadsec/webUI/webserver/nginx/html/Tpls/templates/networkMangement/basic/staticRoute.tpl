<table class="column_95 textMid tablesorter" id="clientTcp">
	<caption>
       静态路由
    </caption>
    <thead>
    <tr>
      <th class="column_30">目的地址</th>
      <th class="column_20">下一跳</th>
      <th class="column_20">网络接口</th>
      <th class="column_10">是否启用</th>
      <th class="column_20">操作</th>
    </tr></thead>
    <tbody>
        <td>目的地址</td>
        <td>下一跳</td>
        <td>网络接口</td>
        <td>是否启用</td>
        <td><a href="#" class="edit" onclick="edituser()">编辑</a>&nbsp;&nbsp;&nbsp;<a href="#" class="delete" onclick="deluser()">删除</a></td>
    </tbody>
  </table>
<button class="floatLeft button" type="submit" onClick="showRouteDialog()" id="add">添加</button>

<div class="hide" id="dialogForm">
  <table class="column_95">
    <form action="xtcs.html" method="POST">
    <tr>
      <td class="tdheader" width="100"><span class="red">*</span>目的地此:</td>
      <td class="tdbody">
        <input type="text" name="inputtext2"/>
      </td>
    </tr>
    <tr>
      <td class="tdheader">掩码:</td>
      <td class="tdbody">
        <label>
          <select name="select" id="select">
            <option>255.255.255.0</option>
              <option>255.255.255.0</option>
           <option>255.255.255.0</option>
                  <option>255.255.255.0</option>
            </select>
        </label>
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>下一跳地此:</td>
      <td class="tdbody">
        <input type="text" name="inputtext2"/>
      </td>
    </tr>

    <tr>
      <td class="tdheader"><span class="red">*</span>网络接口:</td>
      <td class="tdbody">
        <select name="select2" id="select2">
          <option>fel</option>
        </select>
      </td>
      </tr>
  </form>
  </table>
</div>
<script type="text/javascript">
$(document).ready(function() {
    $("#add, .inputbtn").button();
	
});
function showRouteDialog(){
	var dialog = StandardUiFactory.createDialog('编辑');
	var buttons = {};
	buttons['确定'] = function() {
		location.href = "index.php";
	};
	var dialogParams = {
		buttons : buttons,
		width   : 400,
		height  : 260
	};
	dialog.setOptions(dialogParams);
	$('#dialogForm').show();
	var htmlText=$('#dialogForm');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>