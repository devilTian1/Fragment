<table class="column_95 textMid tablesorter" id="clientTcp">
   <caption>
  	时间列表
   </caption>
   <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_30">名称</th>
      <th class="column_40">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>序号</td>
      <td>名称</td>
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
  <form action="xtcs.html" method="POST">
    <tr>
      <td class="tdheader" width="120"><span class="red">*</span>名称</td>
      <td class="tdbody">
        <input type="text" name="inputtext2" class="inputtext"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 ) 
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>一次性调度：
        <input name="radio" type="radio" id="radio3" value="radio" checked="checked" />      </td>
      <td class="tdbody">
         起始时间:  
        &nbsp;
        <input type="text" name="inputtext3"/>
      终止时间: 
      <input type="text" name="inputtext4"/><br/>
      有效时间格式 ( YYYY/MM/DD hh:mm 或 YYYY/MM/DD hh:mm:ss)</td>
    </tr>
    
    <tr>
      <td class="tdheader">周循环调度：
        <input type="radio" name="radio" id="radio2" value="radio" /></td>
      <td class="tdbody">
      
      <table class="column_95">
      <thead>
        <tr>
          <th width="80">调度日期</th>
          <th width="130">起始时间
            </th>
          <th width="130">终止时间 
		</th>
        </tr>
        </thead>
        <tr>
          <td>星期天</td>
          <td>
            <input type="text" name="inputtext5" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext12" class="inputtext"/>
         </td>
        </tr>
        <tr>
          <td>星期一</td>
          <td>
            <input type="text" name="inputtext6" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext13" class="inputtext"/>
          </td>
        </tr>
        <tr>
          <td>星期二</td>
          <td>
            <input type="text" name="inputtext7" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext14" class="inputtext"/>
          </td>
        </tr>
        <tr>
          <td>星期三</td>
          <td>
            <input type="text" name="inputtext8" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext15" class="inputtext"/>
          </td>
        </tr>
        <tr>
          <td>星期四</td>
          <td>
            <input type="text" name="inputtext9" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext16" class="inputtext"/>
          </td>
        </tr>
        <tr>
          <td>星期五</td>
          <td>
            <input type="text" name="inputtext10" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext17" class="inputtext"/>
          </td>
        </tr>
        <tr>
          <td>星期六</td>
          <td>
            <input type="text" name="inputtext11" class="inputtext"/>
          </td>
          <td>
            <input type="text" name="inputtext18" class="inputtext"/>
         </td>
        </tr>
      </table>
      
      </td>
    </tr>
    <tr>
      <td class="tdheader">备注:</td>
      <td class="tdbody">
        <input name="inputtext" type="text" class="inputtext" size="50"/>
     </td>
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
		width   : 800,
		height  : 480
	};
	dialog.setOptions(dialogParams);
	$('#editRedunHtml').show();
	var htmlText=$('#editRedunHtml');
	dialog.setContent(htmlText);
	dialog.open();
}
</script>
