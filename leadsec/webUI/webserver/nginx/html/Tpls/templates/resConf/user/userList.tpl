<table class="column_95 textMid tablesorter" id="clientTcp">
   <caption>
  	用户地址
   </caption>
   <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_10">用户名</th>
      <th class="column_20">是否允许登录</th>
      <th class="column_10">创建时间</th>
      <th class="column_10">生存时间</th>
      <th class="column_20">用户认证配置导出</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>序号</td>
      <td>用户名</td>
      <td>是否允许登录</td>
      <td>创建时间</td>
      <td>生存时间</td>
      <td>用户认证配置导出</td>
      <td>
      		<a href="#" class="edit" onclick="editRedundance()">编辑</a>
        	<a href="#" class="delete" onclick="delRedundance()">删除</a> 
            <a href="#" class="reflesh" onclick="delRedundance()">刷新</a>
      </td>
    </tr>
    </tbody>
</table>
   <input type="button" name="button" id="addValue" value="添加" class="inputbtn" onclick="addRedun()" />
   <input name="input" type="button" value="删除所有用户" class="inputbtn" id="delUser" />
   
<div id="editRedunHtml" style="display:none">
 <table class="column_100">
  <form action="xtcs.html" method="POST">
    <tr>
      <td class="tdheader" width="140"><span class="red">*</span> 用户名: <br /></td>
      <td class="tdbody">
        <input type="text" name="inputtext2" class="inputtext"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 ) 
       </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>  口令: <br /></td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
        &nbsp;( 6-16位。必须包含字母、数字以及第二排键盘上端的非字母字符‘!’与‘$’除外)</td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>确认口令: <br /></td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span> 生存时间: <br /></td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
        &nbsp;( 0-3650 天，0表示不限制 )</td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span> 密码存留期: <br /></td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
        ( 0-3650 天，0表示不限制 )</td>
    </tr>
    <tr>
      <td class="tdheader">是否允许登录:<br /></td>
      <td class="tdbody">
          <input type="checkbox" name="checkbox" id="checkbox" />
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>是否绑定IP: <br /></td>
      <td class="tdbody">
        <input type="checkbox" name="checkbox2" id="checkbox2" />
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>绑定IP：<br /></td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
      </td>
    </tr>
    <tr>
      <td class="tdheader">掩码:<br /></td>
      <td class="tdbody">
          <select name="select" id="select" class="inputselect">
            <option>255.255.255.0</option>
            <option>255.255.0.0</option>
         </select>
      </td>
    </tr>
    <tr>
      <td class="tdheader">是否检查客户端版本: </td>
      <td class="tdbody">
        <input type="checkbox" name="checkbox3" id="checkbox3" />
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>客户端版本：<br /></td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
        &nbsp;( 只能够输入数字和. )</td>
    </tr>
    </form>
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
		width   : 820,
		height  : 480
	};
	dialog.setOptions(dialogParams);
	$('#editRedunHtml').show();
	var htmlText=$('#editRedunHtml');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>
