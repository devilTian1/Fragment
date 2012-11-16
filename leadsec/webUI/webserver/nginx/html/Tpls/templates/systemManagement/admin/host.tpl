<table class="column_95 textMid tablesorter" id="hostTable">
    <caption>管理主机</caption>
    <thead>
        <tr>
            <th class="column_10">序号</th>
            <th class="column_20">管理主机IP</th>
            <th class="column_20">子网掩码</th>
            <th class="column_30">说明</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr><td colspan='5'>Loading ...</td></tr>
    </tbody>
</table>
<button class="floatLeft standard" type="button" onClick="openNewHostDialog()" id="add">添加</button>
<button class="floatLeft standard" type="button" onClick="openSnmpDialog()" id="add">集中管理主机</button>

<script type="text/javascript" src="Public/js/systemManagement/admin/host.js"></script>
<script type="text/javascript">
   	$(document).ready(function(){
        renderStandardUi();
        freshHostList();
    });
</script>
