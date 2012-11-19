<table class="column_95 textMid tablesorter" id="clientTcp">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
      <th class="column_5">任务号</th>
      <th class="column_10">源地此</th>
      <th class="column_10">本机地此</th>
      <th class="column_10">本地端口</th>
      <th class="column_10">认证/加密</th>
      <th class="column_10">本机备份</th>
      <th class="column_10">病毒扫描</th>
      <th class="column_10">是否启动</th>
      <th class="column_10">生效时间</th>
      <th class="column_5">备注</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tr>
     <tr>
      <td>序号</td>
      <td>名称</td>
      <td>URL过滤</td>
      <td>备注</td>
      <td></td>
      <td>流病毒扫描</td>
      <td>备注</td>
      <td></td>
      <td>流病毒扫描</td>
      <td>备注</td>
      <td>
      		<a href="#" class="edit" onclick="edituser()">编辑</a>
            <a href="#" class="delete" onclick="deluser()">删除</a>
      </td>
    </tr>
  </table>
<button class="floatLeft button" type="submit" onClick="openMsgTransDialog()" id="add">添加</button>
<script type="text/javascript" src="Public/js/client/msgTrans/msgTrans.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#add, .inputbtn").button();
});
</script>