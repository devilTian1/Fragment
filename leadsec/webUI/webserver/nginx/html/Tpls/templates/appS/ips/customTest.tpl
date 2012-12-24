<table class="column_95 textMid tablesorter" id="addrTable">
    <caption>
  	自定义检测
    </caption>
    <thead>
        <tr>
            <th class="column_10">序号</th>
            <th class="column_15">源地址</th>
            <th class="column_10">端口</th>
            <th class="column_15">目的地址 </th>
            <th class="column_10">端口</th>
            <th class="column_10">协议类型</th>
            <th class="column_10">事件主题</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>
            	<a href="#" class="status" onclick="editRedundance()">状态</a>
            	<a href="#" class="edit" onclick="editRedundance()">编辑</a>
        		<a href="#" class="delete" onclick="delRedundance()">删除</a> 
            </td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewAddrListDialog()"
    id="addAddr">添加
</button>
<script type="text/javascript"> 
    $(document).ready(function() {
      $("#addAddr").button();
    });
</script>
