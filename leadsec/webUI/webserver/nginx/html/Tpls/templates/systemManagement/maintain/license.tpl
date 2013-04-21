<form action="Function/systemManagement/maintain/license.php" method="POST" 
id="licenseForm" onSubmit="return false">
    <table class="column_95">
        <caption>
            <{$smarty.const.PRODUCT_NAME}>名称
        </caption>
    <tr>
        <td width="250" class="tdheader">产品许可证:</td>
        <td class="tdbody">
            <input name="licenseFile" type="file" id="file" />
        </td>
    </tr>
    <tr>
        <td></td>
        <td>
            <button class="inputbtn standard" type="button" id="licenseFile" 
			onclick="importLicense()">
                导入许可证
            </button>
        </td>
    </tr>
    </table>
</form>
  
<table class="column_95 textMid tablesorter" id="licenseTable">
    <caption> License启用信息</caption>
    <thead>
        <tr>
            <th class="column_10">序号</th>
            <th class="column_30">模块名</th>
            <th class="column_40">截止时间</th>
            <th class="column_20">状态</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan='6'>Loading ... ...</td>
        </tr>
    </tbody>
</table>

<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/systemManagement/maintain/license.php'}>
</div>

<script type="text/javascript" src="Public/js/systemManagement/maintain/
license.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#licenseForm"));
    freshTable('Function/systemManagement/maintain/license.php',$('#licenseTable'));
});
</script>
