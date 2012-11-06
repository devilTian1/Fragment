<table class="column_95 textMid tablesorter" id="clientTcp">
    <caption>
  	  地址组
   </caption>
   <thead>
    <tr>
      <td class="column_10">序号</td>
      <td class="column_10">名称</td>
      <td class="column_40">成员</td>
      <td class="column_20">备注</td>
      <td class="column_20">操作</td>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>序号</td>
      <td>名称</td>
      <td>成员</td>
      <td>备注</td>
      <td>
      	 <a href="#" class="edit" onclick="editRedundance()">编辑</a>
         <a href="#" class="delete" onclick="delRedundance()">删除</a> 
      </td>
    </tr>
    </tbody>
    <tr>
      <td>&nbsp;</td>
      <td  class="tdbody">
         <input type="button" name="button" id="addValue" value="添加" class="inputbtn" onclick="addRedun()" />
      </td>
    </tr>
     <tr>
      <td>
      </td>
    </tr>
  </table>
<div id="editRedunHtml" style="display:none">
 <table class="column_100">
  <tbody>
    <form action="xtcs.html" method="POST" enctype="multipart/form-data">
    <tr>
      <td class="tdheader" width="80"><span class="red">*</span>名称</td>
      <td width="74%">
        <input type="text" name="inputtext2" class="inputtext"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 ) 
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <table border="0" align="center" cellpadding="0" cellspacing="0" class="column_100">
          <tr>
            <td class="column_45" align="right">地址列表<br/>
            <select name="select" size="10" id="select" class="w200">
            </select></td>
            <td class="column_5" align="center"><p>
              <input type="button" name="button" id="button" value="&gt;&gt;"  class="inputbtn" />
              </p>
              <p><br />
                <input type="button" name="button2" id="button2" value="&lt;&lt;"  class="inputbtn" />
              </p></td>
            <td class="column_50" align="left">
            地址组成员 <br/>
            <select name="select2" size="10" id="select2" class="w200">
            </select></td>
          </tr>
        </table></td>
      </tr>
    <tr>
      <td class="tdheader">备注: </td>
      <td class="tdbody">
        <input type="text" name="inputtext2"  class="inputtext" size="40"/>
       </td>
    </tr>
    </form>
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
		width   : 700,
		height  : 400
	};
	dialog.setOptions(dialogParams);
	$('#editRedunHtml').show();
	var htmlText=$('#editRedunHtml');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>
