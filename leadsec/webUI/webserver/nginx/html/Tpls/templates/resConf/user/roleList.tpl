<{include file='layout/search.tpl' colNames='role_id,role_name,create_by,create_time,time,comment'}>
<table class="column_95 textMid tablesorter" id="roleListTable">
    <caption>角色列表</caption>
    <thead>
        <tr>
            <th class="column_5"><input type="checkbox" onClick="checkAllRole()" title="全选" id="checkAllRole"/></th>
            <th class="column_10" name="role_id">序号</th>
            <th class="column_15" name="role_name">角色名称</th>
            <th class="column_15" name="create_by">创建者</th>
            <th class="column_15" name="create_time">创建日期</th>
            <th class="column_15" name="time">分配时间(单位:分钟)</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
  	    <tr>
            <td colspan='7'>Loading ... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewRoleListDialog()"
    id="addRoleListBtn">新建
</button>
<button class="standard floatLeft" style="position: static"
    onclick="openDelAllRoleListDialog()"
    id="DelAllRoleListBtn">删除所有角色
</button>
<button class="standard floatLeft" style="position: static"
    onclick="openBatchDelSpecRoleDialog()"
    id="DelSpecRoleListBtn">删除已选角色
</button>
<div class="pager floatRight" id="rolePagerDiv">
    <{include file='layout/pagination.tpl' func='Function/resConf/user/roleList.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/user/roleList.js"></script> 
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/user/roleList.php', $('#roleListTable'),
            'ORDER BY role_id ASC LIMIT 10');
        sortTableInit($('#roleListTable'),
            {0: {sorter: false}, 6: {sorter: false}},[[1,0]]);
    });
</script>
