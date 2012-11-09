<table class="column_95 textMid tablesorter" id="hostTable">
    <caption>管理主机</caption>
    <thead>
        <tr>
            <th class="column_10">序号</th>
            <th class="column_20">管理主机IP</th>
            <th class="column_20">子网掩码</th>
            <th class="column_50">说明</th>
        </tr>
    </thead>
    <{foreach $hosts as $value }>
        <tr>
            <td><{$value['account']}></td>
	    <td>
	    <{if ($value.super == '1')}>
	        <span class="red">超级管理员</span>&nbsp;
	    <{/if}>
	    <{if ($value.manager == '1')}>
	        配置管理员&nbsp;
	    <{/if}>
	    <{if ($value.policyer == '1')}>
	        策略管理员&nbsp;
	    <{/if}>
	    <{if ($value.auditor == '1')}>
	        审计管理员
	    <{/if}>
	    </td>
        <td>
	        <a href="#" class="edit" onclick="openEditUserDialog('<{$value["account"]}>')">编辑</a>
		<{if ($value.super === '0')}>
		    &nbsp;&nbsp;&nbsp;
		    <a href="#" class="delete" onclick="openDelUserDialog('<{$value["account"]}>')">删除</a>
		<{/if}>
	    </td>
        </tr>
    <{foreachelse}>
        <tr><td colspan='4'>No Host</td></tr>
    <{/foreach}>
</table>
<button class="floatLeft button" type="submit" onClick="openNewHostDialog()" id="add">添加</button>
<button class="floatLeft button" type="submit" id="add">集中管理主机</button>

<script type="text/javascript">
   	$(document).ready(function(){

    });
</script>
