<form action="Function/systemManagement/maintain/license.php" method="POST" id="licenseForm" 
    onSubmit="return false">
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
            <button class="inputbtn standard" name="licenseFile" onclick="importLicense()">
                导入许可证
            </button>
        </td>
    </tr>
    </table>
</form>
  
<table class="column_95 textMid tablesorter">
    <caption> License启用信息</caption>
    <thead>
        <tr>
            <td class="column_10">序号</td>
            <td class="column_30">模块名</td>
            <td class="column_40">截止时间</td>
            <td class="column_20">状态</td>
        </tr>
    </thead>
    <{foreach $licenseInformation   as $k => $val }>
        <tr>
            <td><{$val.id}></td>
            <td><{$val.application}></td>
            <td><{$val.stop_time}></td>
            <td><{$val.type}></td>
        </tr>
    <{foreachelse}>   
        <tr><td colspan='4'>No Data</td></tr>
    <{/foreach}>

</table>
<script type="text/javascript" src="Public/js/systemManagement/maintain/license.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#licenseForm"));
});
</script>
