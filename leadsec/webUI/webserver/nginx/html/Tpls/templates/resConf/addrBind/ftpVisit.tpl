<table class="column_95 textMid tablesorter" id="clientTcp">
 <caption>
    FTP过滤选项
 </caption>
	<thead> 
        <tr>
          <th class="column_10">序号</th>
          <th class="column_20">用户控制</th>
          <th class="column_20">命令控制</th>
          <th class="column_20">文件病毒扫描</th>
          <th class="column_10">备注</th>
          <th class="column_20">操作</th>
        </tr>
    </thead>
	<tbody>
     <tr>
          <td>序号</td>
          <td>用户控制</td>
          <td>命令控制</td>
          <td>文件病毒扫描</td>
          <td>备注</td>
          <td>
          		<a href="#" class="edit" onclick="edituser()">编辑</a>
       			<a href="#" class="delete" onclick="deluser()">删除</a>
          </td>
       </tr>
      </tbody>
  </table>
<button class="floatLeft button" type="submit" onClick="openNewDialog()" id="add">添加</button>
<script type="text/javascript">
$(document).ready(function() {
    $("#add, .inputbtn").button();
});
</script>
<script type="text/javascript" src="Public/js/resConf/addrBind/ftpVisit.js"></script>