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
      <th class="column_10">DNS服务器</th>
      <th class="column_20">静态IP列表</th>
      <th class="column_20">动态IP列表</th>
      <th class="column_20">操作</th>
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
   	    <a href="#" class="edit" onclick="editRedundance()">编辑</a>
        <a href="#" class="delete" onclick="delRedundance()">删除</a> 
         <a href="#" class="reflesh" onclick="delRedundance()">刷新</a>
      </td>
    </tr>
    </tbody>
  </table>
  <input type="button" name="button" id="addValue" value="添加" class="inputbtn" onclick="addRedun()" />
<div id="editRedunHtml" style="display:none">
 <table class="column_100">
  <tbody>
  <form action="xtcs.html" method="POST">
    <tr>
      <td class="tdheader" width="140"><span class="red">*</span>名称</td>
      <td class="tdbody">
        <input type="text" name="inputtext2"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 ) 
      </td>
    </tr>
    <tr>
      <td class="tdheader">域名</td>
      <td class="tdbody">
        <input type="text" name="inputtext"/>
       </td>
    </tr>
    <tr>
      <td class="tdheader">静态IP列表</td>
      <td class="tdbody">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="27%" rowspan="2"><select name="select" size="5" id="select" class="w200">
            </select></td>
            <td width="73%" valign="middle">
              <input name="input2" type="button" value="删除" />
           </td>
          </tr>
          <tr>
            <td valign="middle">
              <input name="input" type="button" value="清空" />
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="tdheader">静态IP地址</td>
      <td class="tdbody">
        <input type="text" name="inputtext"/>
        &nbsp;&nbsp;<input name="" type="button" value="添加" /></td>
    </tr>
    <tr>
      <td class="tdheader">自动解析</td>
      <td class="tdbody">
          <input type="checkbox" name="checkbox" id="checkbox" />
      </td>
    </tr>
    <tr>
      <td class="tdheader">解析记录</td>
      <td class="tdbody">
        <input type="checkbox" name="checkbox2" id="checkbox2" />
        A 
        <input type="checkbox" name="checkbox3" id="checkbox3" />
        MX
       </td>
    </tr>
    <tr>
      <td class="tdheader">最大记录数</td>
      <td class="tdbody">
        <input name="inputtext3" type="text" value="64"/>
      </td>
    </tr>
    <tr>
      <td class="tdheader">自动解析间隔</td>
      <td class="tdbody">
        <input name="inputtext3" type="text" value="30"/>
        &nbsp;&nbsp;分钟</td>
    </tr>
    <tr>
      <td class="tdheader">自动解析记录失效间隔</td>
      <td class="tdbody">
        <input name="inputtext3" type="text" value="2"/>
        &nbsp;&nbsp;（是自动解析间隔的多少倍）</td>
    </tr>
    <tr>
      <td class="tdheader">主DNS服务器</td>
      <td class="tdbody">
        <input type="text" name="inputtext3"/>
        </td>
    </tr>
    <tr>
      <td class="tdheader">次DNS服务器</td>
      <td class="tdbody">
        <input type="text" name="inputtext3"/>
        </td>
    </tr>
    <tr>
      <td class="tdheader">动态IP列表</td>
      <td class="tdbody">
          <select name="select3" size="5" id="select3" class="w200">
          </select>
       </td>
    </tr>
    <tr>
      <td class="tdheader">备注</td>
      <td class="tdbody">
        <input type="text" name="inputtext2"/>
        </td>
    </tr>
    </form>
    </tbody>
  </table>
</div>
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
