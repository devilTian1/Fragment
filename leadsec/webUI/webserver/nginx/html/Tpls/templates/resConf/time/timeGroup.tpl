<table class="column_95 textMid tablesorter" id="clientTcp">
    <caption>
  	  时间组
   </caption>
   <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20">名称</th>
      <th class="column_20">时间组成员</th>
      <th class="column_30">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>序号</td>
      <td>名称</td>
      <td>时间组成员</td>
      <td>备注</td>
      <td>
         <a href="#" class="edit" onclick="editRedundance()">编辑</a>
         <a href="#" class="delete" onclick="delRedundance()">删除</a> 
      </td>
     </tr>
   </tbody>
  </table>
 <input type="button" name="button" id="addValue" value="添加" class="inputbtn" onclick="addRedun()" />
 
<div id="editRedunHtml" style="display:none">
 <table class="column_100">
 <tbody>
  <form action="xtcs.html" method="POST" enctype="multipart/form-data">
    <tr>
      <td class="tdheader" width="80"><span class="red">*</span>名称</td>
      <td>
        <input type="text" name="inputtext2" class="inputtext"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 ) 
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <table class="column_95">
          <tr>
            <td width="46%" align="right">时间列表成员<br/>
            <select name="select" size="10" id="select" class="w200">
            </select></td>
            <td width="6%" align="center"><p>
              <input type="button" name="button" id="button" value="&gt;&gt;" class="inputbtn" />
              </p>
              <p><br />
                <input type="button" name="button2" id="button2" value="&lt;&lt;" class="inputbtn" />
              </p></td>
            <td width="48%" align="left">
            时间组成员 <br/>
            <select name="select2" size="10" id="select2" class="w200">
            </select></td>
          </tr>
        </table>
        </td>
      </tr>
    <tr>
      <td class="tdheader">备注: </td>
      <td>
        <input type="text" name="inputtext2"  class="inputtext" size="40"/>
        </td>
    </tr>
    </form>
   </tbody>
</table>
</div>
<script type="text/javascript"> 
$(document).ready(function() {
   $(".inputbtn").button();
});
function addRedun(){
	var dialog = StandardUiFactory.createDialog('编辑');
	var buttons = {};
	buttons['确定'] = function() {
		location.href = "index.php";
	};
	var dialogParams = {
		buttons : buttons,
		width   : 660,
		height  : 400
	};
	dialog.setOptions(dialogParams);
	$('#editRedunHtml').show();
	var htmlText=$('#editRedunHtml');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>
