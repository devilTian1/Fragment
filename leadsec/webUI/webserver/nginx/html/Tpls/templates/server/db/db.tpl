<table class="column_95 textMid tablesorter" id="clientTcp">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_10">任务号</th>
      <th class="column_10">数据库类型</th>
      <th class="column_10">服务器地此</th>
      <th class="column_10">服务器端口</th>
      <th class="column_10">是否启动</th>
      <th class="column_30">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tr>
     <tr>
      <td>序号</td>
      <td>名称</td>
      <td>名称</td>
      <td>URL过滤</td>
      <td>流病毒扫描</td>
      <td>备注</td>
      <td>
      		<a href="#" class="edit" onclick="edituser()">编辑</a>
            <a href="#" class="delete" onclick="deluser()">删除</a>
      </td>
    </tr>
  </table>
<button class="floatLeft button" type="submit" onClick="openDbDialog()" id="add">添加</button>
<script type="text/javascript" src="Public/js/server/db/db.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#add, .inputbtn").button();
});
</script>