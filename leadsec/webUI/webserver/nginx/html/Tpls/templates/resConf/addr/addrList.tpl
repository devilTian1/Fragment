<table class="column_95 textMid tablesorter" id="clientTcp">
  <caption>
  	地址列表
   </caption>
   <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20">名称</th>
      <th class="column_30">地址</th>
      <th class="column_20">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>1</td>
      <td>any </td>
      <td>0.0.0.0/0.0.0.0</td>
      <td>全部地此</td>
      <td>
      	  <a href="#" class="edit" onclick="editRedundance()">编辑</a>
          <a href="#" class="delete" onclick="delRedundance()">删除</a> 
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td class="tdbody">
        <input type="button" name="button" id="addValue" value="添加" class="inputbtn" onclick="addRedun()" />
      </td>
    </tr>
    <tr>
      <td colspan="5" align="right">
      <div id="Pagination" class="pagination"><!-- 这里显示分页 --></div>
<div id="Searchresult">分页初始化完成后这里的内容会被替换。</div>
      </td>
    </tr>
  </table>
  
<div id="editRedunHtml" style="display:none">
<table class="column_100">
  <form action="xtcs.html" method="POST">
    <tr>
      <td class="tdheader" width="80"><span class="red">*</span>名称</td>
      <td class="tdbody">
        <input type="text" name="inputtext2"/>
        ( 1-15 字母、数字、减号、下划线、点的组合 ) 
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>地址</td>
      <td class="tdbody">
      <div class="margintop3">
          <input name="radio1" type="radio" id="radio" value="radio" checked="checked" />
          <input type="text" name="textfield" id="textfield" />/
        <select name="select" id="select">
          <option>0.0.0.0</option>
          <option>255.255.0.0</option>
          <option>255.255.255.0</option>
        </select>
      </div>
      <div class="margintop3">
            <input name="radio1" type="radio" id="radio2" value="radio" />
            ！
            <input type="text" name="textfield2" id="textfield2" />
            /
            <select name="select2" id="select2">
              <option>0.0.0.0</option>
              <option>255.255.0.0</option>
              <option>255.255.255.0</option>
            </select>
   	 </div>
  	  <div class="margintop3">
        <input name="radio1" type="radio" id="radio3" value="radio" />
        <input type="text" name="textfield3" id="textfield3" />
         -
        <input type="text" name="textfield4" id="textfield4" />
      </div>
        </td>
    </tr>
    <tr>
      <td class="tdheader">备注</td>
      <td class="tdbody">
        <input type="text" name="inputtext2"/>
       </td>
    </tr>
    </form>
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
		width   : 600,
		height  : 300
	};
	dialog.setOptions(dialogParams);
	$('#editRedunHtml').show();
	var htmlText=$('#editRedunHtml');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>
