<table class="column_95 textMid tablesorter" id="clientTcp">
  <caption>
  	  用户组
  </caption>
   <thead>
    <tr>
      <td class="column_10">序号</td>
      <td class="column_20">用户组</td>
      <td class="column_20">组成员列表</td>
      <td class="column_10">分配时间</td>
      <td class="column_20">分配流量</td>
      <td class="column_20">操作</td>
    </tr>
  </thead>
  <tbody>
  	<tr>
      <td>序号</td>
      <td>用户组</td>
      <td>组成员列表</td>
      <td>分配时间</td>
      <td>分配流量</td>
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
      <td class="tdheader" width="100"><span class="red">*</span>名称</td>
      <td>
        <input type="text" name="inputtext2" class="inputtext"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 ) 
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>分配流量</td>
      <td>
        <input type="text" name="inputtext4" class="inputtext"/>
        &nbsp; ( M 字节 范围: 0-1024000，0表示不限制 ) </td>
    </tr>
    <tr>
      <td class="tdheader">分配时间</td>
      <td>
        <input type="text" name="inputtext4" class="inputtext"/>
( 分钟 范围: 0-525600，0表示不限制 ) </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>进程检查</td>
      <td>
          <input type="checkbox" name="checkbox4" id="checkbox4" />
( 是否启用进程检查 )</td>
    </tr>
    <tr>
      <td class="tdheader">进程策略</td>
      <td>
        <input type="checkbox" name="checkbox5" id="checkbox5" />
        &nbsp;&nbsp; ( 进程检查失败后，是否允许客户端登陆 )</td>
    </tr>
    <tr>
      <td class="tdheader">本组用户</td>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="34%" align="right">所有用户<br/>
              <select name="select" size="10" id="select" class="w200">
              </select></td>
            <td width="18%" align="center"><p>
              <input type="button" name="button" id="button" value="&gt;&gt;" class="inputbtn" />
            </p>
              <p><br />
                <input type="button" name="button2" id="button2" value="&lt;&lt;" class="inputbtn" />
              </p></td>
            <td width="48%" align="left">本组用户<br/>
              <select name="select2" size="10" id="select2" class="w200">
              </select></td>
          </tr>
        </table>
        
      </td>
    </tr>
    <tr>
      <td class="tdheader">进程管理</td>
      <td>
        <input type="button" name="button3" id="lookjc" value="查看进程" class="inputbtn" onclick="addProcess()" />
      </td>
    </tr>
    </form>
   </tbody>
</table>
</div>

<div id="showProcess" style="display:none">
<table class="column_100">
 <caption>
  	进程添加（URL只支持http、https、ftp三种协议，并且不能够有分号、逗号和加号）
  </caption>
    <thead>
    <tr>
      <td class="column_20">软件名</td>
      <td class="column_20">进程名</td>
      <td class="column_20">提示信息</td>
      <td class="column_20">URL</td>
      <td class="column_20">操作</td>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>软件名</td>
      <td>软件名</td>
      <td>提示信息</td>
      <td>URL</td>
      <td>
         <a href="#" class="delete" onclick="delRedundance()">删除</a> 
      </td>
    </tr>
    </tbody>
    <tr>
      <td colspan="5">
      <table class="column_100">
        <tr>
          <td class="tdheader" width="70">软件名：</td>
          <td class="tdbody">
            <input type="text" name="textfield" id="textfield" />
          （最多30个字符）</td>
          <td class="tdheader" width="70">进程名：</td>
          <td class="tdbody"><input type="text" name="textfield3" id="textfield3" />
            （最多30个字符）</td>
        </tr>
        <tr>
          <td class="tdheader">提示信息：</td>
          <td class="tdbody"><input type="text" name="textfield2" id="textfield2" />
            （最多50个字符）</td>
          <td class="tdheader">进程URL:</td>
          <td class="tdbody"><input type="text" name="textfield4" id="textfield4" />
            （最多100个字符）</td>
        </tr>
      </table></td>
    </tr>
  </table>
  <input type="submit" name="button" id="button" value="进程添加" class="inputbtn" />
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
		width   : 800,
		height  : 540
	};
	dialog.setOptions(dialogParams);
	$('#editRedunHtml').show();
	var htmlText=$('#editRedunHtml');
	dialog.setContent(htmlText);
	dialog.open();
}

function addProcess(){
	var dialog = StandardUiFactory.createDialog('进程管理');
	var buttons = {};
	buttons['确定'] = function() {
		location.href = "index.php";
	};
	var dialogParams = {
		buttons : buttons,
		width   : 840,
		height  : 400
	};
	dialog.setOptions(dialogParams);
	$('#showProcess').show();
	var htmlText=$('#showProcess');
	dialog.setContent(htmlText);
	dialog.open();
}

</script>
