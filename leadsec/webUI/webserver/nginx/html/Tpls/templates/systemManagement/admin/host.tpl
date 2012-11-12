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
    <{foreach $hosts as $host }>
        <tr>
            <td><{$host.id}></td>
            <td><{$host.ip}></td>
            <td><{$host.netmask}></td>
            <td><{$host.comment}></td>
            <td>
	        <a href="#" class="edit" onclick="openEditHostDialog('<{$host.id}>')">编辑</a>
		    &nbsp;&nbsp;&nbsp;
		    <a href="#" class="delete" onclick="openDelHostDialog('<{$host.ip}>', '<{$host.netmask}>')">删除</a>
	    </td>
        </tr>
    <{foreachelse}>
        <tr><td colspan='4'>No Host</td></tr>
    <{/foreach}>
</table>
<button class="floatLeft standard" type="button" onClick="openNewHostDialog()" id="add">添加</button>
<button class="floatLeft standard" type="button" onClick="openSnmpDialog()" id="add">集中管理主机</button>

<script type="text/javascript" src="Public/js/systemManagement/admin/host.js"></script>
<script type="text/javascript">
   	$(document).ready(function(){
        renderStandardUi();
    });
</script>
