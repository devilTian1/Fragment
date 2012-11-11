<table class="column_95 textMid tablesorter" id="clientTcp">
 <caption>
   邮件地址
 </caption>
<thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20">名称</th>
      <th class="column_20">允许通过的邮件地此</th>
      <th class="column_10">类别</th>
      <th class="column_20">备注</th>
      <th class="column_20">操作</th>
    </tr>
</thead>
<tbody>
    <tr>
      <td>序号</td>
      <td>名称</td>
      <td>url列表</td>
      <td>备注</td>
      <td>&nbsp;</td>
      <td>
      	<a href="#" class="edit" onclick="edituser()">编辑</a>
        <a href="#" class="delete" onclick="deluser()">删除</a>
      </td>
    </tr>
</tbody>
</table>
<button class="floatLeft button" type="submit" onClick="openNewEVAddrDialog()" id="add">添加</button>
<script type="text/javascript">
$(document).ready(function() {
    $("#add, .inputbtn").button();
});
</script>