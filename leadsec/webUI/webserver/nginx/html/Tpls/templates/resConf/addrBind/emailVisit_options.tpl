<table class="column_95 textMid tablesorter" id="clientTcp">
    <caption>
           过滤选项集
    </caption>
    <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_10">名称</th>
      <th class="column_10">协议</th>
      <th class="column_10">主题关键字</th>
      <th class="column_10">正文关键字</th>
      <th class="column_20">文件病毒扫描</th>
      <th class="column_10">流病毒扫描</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tr>
     <tr>
      <td>序号</td>
      <td>名称</td>
      <td>URL过滤</td>
      <td>备注</td>
      <td>文件病毒扫描</td>
      <td>流病毒扫描</td>
      <td>备注</td>
      <td>
      		<a href="#" class="edit" onclick="edituser()">编辑</a>
            <a href="#" class="delete" onclick="deluser()">删除</a>
      </td>
    </tr>
  </table>
<button class="floatLeft button" type="submit" onClick="openEVOptionsDialog()" id="add">添加</button>
<script type="text/javascript">
$(document).ready(function() {
    $("#add, .inputbtn").button();
});
</script>