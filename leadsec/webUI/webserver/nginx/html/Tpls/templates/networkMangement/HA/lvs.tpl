<table class="column_95 textMid tablesorter" id="clientTcp">
    <caption>
         负载均衡
    </caption>
   <thead><tr>
      <th class="column_10">序号</th>
      <th class="column_20">虚拟地址</th>
      <th class="column_10">端口</th>
      <th class="column_10">真实地址1</th>
      <th class="column_10">真实端口1</th>
      <th class="column_10">真实地址2</th>
      <th class="column_10">真实端口2</th>
      <th class="column_20">操作</th>
    </tr></thead>
    <tbody>
    <tr>
      <td>序号</td>
      <td>虚拟地址</td>
      <td>端口</td>
      <td>真实地址1</td>
      <td>真实端口1</td>
      <td>真实地址2</td>
      <td>真实端口2</td>
      <td><a href="#" class="edit" onclick="edituser()">编辑</a>&nbsp;&nbsp;&nbsp;<a href="#" class="delete" onclick="deluser()">删除</a></td>
    </tr>
    </tbody>
  </table>
 <button class="floatLeft button" type="submit" onClick="showLvsDialog()" id="add">添加</button>
<div class="hide" id="dialogForm">
    <table class="column_95">
    <form action="xtcs.html" method="POST">
    <thead>
    <tr>
      <th class="tdheader"><span class="red">*</span> 虚拟地址:</th>
      <th class="tbody">
          <select name="select" id="select">
            <option>fs2</option>
            </select>
      </th>
      <th class="tdheader"><span class="red">*</span>虚拟端口:</th>
      <th class="tdbody"><input type="text" name="textfield" id="textfield" size="6" /></th>
      <th colspan="4">&nbsp;</th>
    </tr>
    </thead>
    <tdbody>
    <tr>
      <td class="tdheader" width="120"><span class="red">*</span> 真实地址1:</td>
      <td class="tdbody"><input name="textfield3" type="text" id="textfield3" size="10" /></td>
      <td class="tdheader" width="100"><span class="red">*</span> 端口1:</td>
      <td class="tdbody"><input type="text" name="textfield2" id="textfield2"  size="6" /></td>
      <td class="tdheader" width="120"><span class="red">*</span> 真实地址2:</td>
      <td class="tdbody"><input name="textfield4" type="text" id="textfield4" size="10" /></td>
      <td class="tdheader" width="80"><span class="red">*</span> 端口2:</td>
      <td class="tdbody"><input type="text" name="textfield5" id="textfield5"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader">真实地址3:</td>
      <td class="tdbody"><input name="textfield6" type="text" id="textfield6" size="10" /></td>
      <td class="tdheader">端口3:</td>
      <td class="tdbody"><input type="text" name="textfield6" id="textfield7"  size="6" /></td>
      <td class="tdheader">真实地址4:</td>
      <td class="tdbody"><input name="textfield6" type="text" id="textfield8" size="10" /></td>
      <td class="tdheader">端口4:</td>
      <td class="tdbody"><input type="text" name="textfield6" id="textfield9"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>真实地址5:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield21" size="10" /></td>
      <td class="tdheader">端口5:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield22"  size="6" /></td>
      <td class="tdheader">真实地址6:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield23" size="10" /></td>
      <td class="tdheader">端口6:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield24"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader">真实地址7:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield25" size="10" /></td>
      <td class="tdheader">端口7:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield26"  size="6" /></td>
      <td class="tdheader">真实地址8:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield27" size="10" /></td>
      <td class="tdheader">端口8:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield28"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>真实地址9:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield29" size="10" /></td>
      <td class="tdheader">端口9:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield30"  size="6" /></td>
      <td class="tdheader">真实地址10:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield31" size="10" /></td>
      <td class="tdheader">端口10:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield32"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>真实地址11:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield33" size="10" /></td>
      <td class="tdheader">端口11:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield34"  size="6" /></td>
      <td class="tdheader">真实地址12:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield35" size="10" /></td>
      <td class="tdheader">端口12:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield36"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>真实地址13:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield37" size="10" /></td>
      <td class="tdheader">端口13:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield38"  size="6" /></td>
      <td class="tdheader">真实地址14:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield39" size="10" /></td>
      <td class="tdheader">端口14:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield40"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>真实地址15:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield17" size="10" /></td>
      <td class="tdheader">端口15:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield18"  size="6" /></td>
      <td class="tdheader">真实地址16:</td>
      <td class="tdbody"><input name="textfield7" type="text" id="textfield19" size="10" /></td>
      <td class="tdheader">端口16:</td>
      <td class="tdbody"><input type="text" name="textfield7" id="textfield20"  size="6" /></td>
    </tr>
    </tbody>
  </form>
  </table>
</div>
<script type="text/javascript">
$(document).ready(function() {
    $("#add, .inputbtn").button();
});
function showLvsDialog(){
	var dialog = StandardUiFactory.createDialog('添加');
	var buttons = {};
	buttons['确定'] = function() {
		location.href = "index.php";
	};
	var dialogParams = {
		buttons : buttons,
		width   : 820,
		height  : 420
	};
	dialog.setOptions(dialogParams);
	$('#dialogForm').show();
	var htmlText=$('#dialogForm');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>