<{include file='layout/search.tpl' colNames='name,filename,blacklist,whitelist'}>
<table class="column_95 textMid tablesorter" id="filterTable">
    <caption>基本服务</caption>
    <thead>
        <tr>
       		<th class="column_10" name="checkall"><input name="checkall" id="checkall" type="checkbox" value="" /></th>
            <th class="column_10" name="id">序号</th>
            <th class="column_20" name="name">服务名</th>
            <th class="column_20" name="filename">协议</th>
            <th class="column_30" name="blacklist">备注</th>
            <th class="column_10">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="6">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<button class="standard floatLeft" style="position: static"
    onclick="openDelDialog()">删除
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl'
        func='index.php?R=firewall/service/basic/showTable'}>
</div>
<script type="text/javascript" src="Public/js/firewall/service/basic.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        //renderStandardUi();
		var url = 'index.php?R=firewall/service/basic/showTable';
		freshTable(url,$("#filterTable"));
		
		$("#checkall").click(function(){
			var flag=$(this).attr("checked");
			if(flag=="checked"){
				$("#filterTable tbody input[name='checkflag']").each(function(){
					$(this).attr("checked","checked");
				});	
			}else{
				$("#filterTable tbody input[name='checkflag']").each(function(){
					$(this).attr("checked",false);
				});	
			}
		});
    });
</script>
