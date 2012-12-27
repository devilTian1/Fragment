<table class="column_95 textMid tablesorter" id="clientTcp">
  <caption>
  	  用户组
  </caption>
   <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20">用户组</th>
      <th class="column_20">组成员列表</th>
      <th class="column_10">分配时间</th>
      <th class="column_20">分配流量</th>
      <th class="column_20">操作</th>
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
<button class="standard floatLeft" style="position: static"
    onclick="addUserGroup()"
    id="addUserListBtn">添加
</button>
<script type="text/javascript" src="Public/js/resConf/user/userGroup.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
    });
</script>

