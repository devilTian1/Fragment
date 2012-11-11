<table class="column_95">
    <tr>
      <td class="tdbody" width="150">
      <label>
        <input type="checkbox" name="checkbox" id="checkbox" />启动文件名控制
      </label>
      </td>
      <td class="tdbody">
      <label>
        <input type="checkbox" name="checkbox2" id="checkbox2" />允许二进制文件
      </label>
      </td>
    </tr>
</table>
<table class="column_95 textMid tablesorter" id="clientTcp">
    <caption>
      文件名控制
   </caption>
   <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_70">允许以下扩展名</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>序号</td>
      <td></td>
      <td>
      	<a href="#" class="edit" onclick="edituser()">编辑</a>
        <a href="#" class="delete" onclick="deluser()">删除</a>
      </td>
    </tr>
    </tbody>
  </table>
    <button class="floatLeft button" type="submit" onClick="openMPFilenameDialog()" id="add">添加</button>
<script type="text/javascript">
$(document).ready(function() {
    $("#add, .inputbtn").button();
});
</script>