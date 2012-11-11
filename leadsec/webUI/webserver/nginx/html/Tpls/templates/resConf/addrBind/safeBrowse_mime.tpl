<table class="column_95 textMid tablesorter" id="clientTcp">
    <caption>
        MIME过滤
    </caption>
    <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20">名称</th>
      <th class="column_10">应用程序类</th>
      <th class="column_10">视频类</th>
      <th class="column_10">音频类</th>
      <th class="column_10">图像类</th>
      <th class="column_10">文本类</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>序号</td>
      <td>名称</td>
      <td>应用程序类</td>
      <td>视频类</td>
      <td>音频类</td>
      <td>图像类</td>
      <td>文本类</td>
      <td>
      		<a href="#" class="edit" onclick="edituser()">编辑</a>
            <a href="#" class="delete" onclick="deluser()">删除</a>
      </td>
    </tr>
    </tbody>
  </table>
<button class="floatLeft button" type="submit" onClick="openNewSFMimeDialog()" id="add">添加</button>
<script type="text/javascript">
$(document).ready(function() {
   $("#add, .inputbtn").button();
});
</script>