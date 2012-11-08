<table class="column_95">
    <tbody>
    <tr>
      <td colspan="7">
      自动域名解析服务:
        <input type="button" name="button" id="button" value="启动" class="inputbtn" />&nbsp;
      </td>
      </tr>
    </tbody>
</table>
  
<table class="column_95 textMid tablesorter" id="clientTcp">
 <caption>
  	 域名地址
  </caption> 
 <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_10">名称</th>
      <th class="column_10">域名</th>
      <th class="column_15">DNS服务器</th>
      <th class="column_20">静态IP列表</th>
      <th class="column_20">动态IP列表</th>
      <th class="column_15">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>序号</td>
      <td>名称</td>
      <td>域名</td>
      <td>DNS服务器</td>
      <td>静态IP列表</td>
      <td>动态IP列表</td>
      <td>
   	    <a href="#" class="edit" onclick="openEditRealmAddrDialog()">编辑</a>
        <a href="#" class="delete" onclick="openDelRealmAddrDialog()">删除</a> 
         <a href="#" class="reflesh" onclick="delRedundance()">刷新</a>
      </td>
    </tr>
    </tbody>
  </table>
  <input type="button" name="button" id="addValue" value="添加" class="inputbtn" onclick="openAddRealmAddrDialog()" />
<script type="text/javascript" src="Public/js/resConf/addr/realmAddr.js"></script>
<script type="text/javascript"> 
$(document).ready(function() {
     $('.inputbtn').button();
});
function addRedun(){
	var dialog = StandardUiFactory.createDialog('编辑');
	var buttons = {};
	buttons['确定'] = function() {
		location.href = "index.php";
	};
	var dialogParams = {
		buttons : buttons,
		width   : 700,
		height  : 600
	};
	dialog.setOptions(dialogParams);
	$('#editRedunHtml').show();
	var htmlText=$('#editRedunHtml');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>
