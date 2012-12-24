<{include file='layout/search.tpl' tableId='addrTable'}>
<table class="column_95 textMid tablesorter" id="addrTable">
    <caption>
  	地址列表
    </caption>
    <thead>
        <tr>
            <th>序号</th>
            <th>用户名</th>
            <th>客户端IP </th>
            <th>已用时间（分钟）</th>
            <th>已用流量（Mb）</th>
            <th>组ID</th>
            <th>组名称</th>
            <th>创建时间</th>
            <th>有效时间</th>
            <th>强制断开</th>
            <th>发起连接<br/>详细列表</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Loadin</td>
            <td>Loadin</td>
            <td>Loadin</td>
            <td>Loadin</td>
            <td>Loadin</td>
            <td>Loadin</td>
            <td>Loadin</td>
            <td>Loadin</td>
            <td>Loadin</td>
            <td>Loadin</td>
            <td>Loadin</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewAddrListDialog()"
    id="addAddr">导出所有用户状态
</button>
<script type="text/javascript"> 
    $(document).ready(function() {
       $("#addAddr").button();
    });
</script>
