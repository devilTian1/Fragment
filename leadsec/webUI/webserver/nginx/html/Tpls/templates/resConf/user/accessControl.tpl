<{include file='layout/search.tpl' tableId='accessControlListTable'}>
<table class="column_95 textMid tablesorter" id="accessControlListTable">
    <caption>接入控制列表</caption>
    <thead>
        <tr>
            <th class="column_5"><input type="checkbox" onClick="checkAllRole()" title="全选" id="checkAllRole"/></th>
            <th class="column_10">序号</th>
            <th class="column_15" name="rule_name">规则名称</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
  	    <tr>
            <td colspan='4'>Loading ... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewRuleListDialog()"
    id="addRuleListBtn">新建
</button>
<button class="standard floatLeft" style="position: static"
    onclick="openDelAllRuleListDialog()"
    id="DelAllRuleListBtn">删除所有规则
</button>
<button class="standard floatLeft" style="position: static"
    onclick="openBatchDelSpecRuleDialog()"
    id="DelSpecRoleListBtn">删除已选规则
</button>
<div class="pager floatRight" id="rolePagerDiv">
    <{include file='layout/pagination.tpl' func='Function/resConf/user/accessControl.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/user/accessControl.js"></script> 
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/user/accessControl.php', $('#accessControlListTable'));
        sortTableInit($('#accessControlListTable'),
            {0: {sorter: false},1:{sorter:false},3:{sorter:false}},[[2,0]]);
    });
</script>
