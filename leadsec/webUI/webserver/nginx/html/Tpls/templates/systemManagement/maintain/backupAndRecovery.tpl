<table  class="column_95">
    <caption>
        <{$smarty.const.PRODUCT_NAME}>名称
    </caption>
        <tr>
            <td  width="250" class="tdheader">
	        </td>
	        <td class="tdbody">
		    <form action="Function/systemManagement/maintain/backupAndRecovery_d.php" 
                method="POST" id="backupAndRecoveryForm">
		        <input type="hidden" name="action" id="action" value=""/>
                <label class="red">导出成加密格式
                <input type="checkbox" name="encryption" id="encryption" onClick="switchEncrypt()"/>
		        <input type="hidden" name="switch" id="switch" value=""/>
                </label>
        	    <button type="submit" class="inputbtn standard" id="export"onclick="exportConfigFile()">
                导出配置
                </button>
		    </form>
            </td>
        </tr>
        <tr>
            <td class="tdheader">配置文件:</td>
            <td class="tdbody">
            <form action="Function/systemManagement/maintain/backupAndRecovery.php" 
                method="POST" id="importFileForm">
      		    <input name="importFile" id="importFile" type="file">&nbsp;
                <button class="inputbtn standard" id="import" onclick="importConfigFile()" type="button">
                导入配置
                </button>
            </form>
            </td>
        </tr>
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
            <form class="inline" action="Function/systemManagement/maintain/backupAndRecovery.php?rest=11" method="GET"
                id="restForm" onSubmit="return false">
                    <button type="button" class="inputbtn standard" onclick="rest()">
                    恢复出厂配置
                    </button>
            </form>
            <form class="inline" action="Function/systemManagement/maintain/backupAndRecovery.php?save=11" method="GET"
                id="saveForm" onSubmit="return false">
                    <button type="button" class="inputbtn standard" onclick="save()">
                    保存配置
                    </button>
            </form>
            </td>
        </tr>
    </table>
<script type="text/javascript" src="Public/js/systemManagement/maintain/backupAndRecovery.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    switchEncrypt();
    validateForm($("#importFileForm"));

});
</script>
