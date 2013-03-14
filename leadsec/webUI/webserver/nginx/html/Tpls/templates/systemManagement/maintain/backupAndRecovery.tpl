<table  class="column_95">
    <caption>
        <{$smarty.const.PRODUCT_NAME}>名称
    </caption>
    <tr>
        <td  width="250" class="tdheader">
        </td>
        <td class="tdbody">
            <form action="Function/systemManagement/maintain/backupAndRecovery.php" 
                method="POST" id="backupAndRecoveryForm">
                <input type="hidden" name="switch" id="switch" value="off"/>
                <label class="red" for="encryption">
                    导出成加密格式
                </label>
                <input type="checkbox" name="encryption" id="encryption"
                    onClick="switchEncrypt()"/>
				<button class="inputbtn standard" type="Submit">
                导出配置
                </button>
            </form>
        </td>
    </tr>
    <tr>
        <td class="tdheader">配置文件:</td>
        <td class="tdbody">
            <form action="Function/systemManagement/maintain/backupAndRecovery.php" 
                method="POST" id="importFileForm" onSubmit="return false">
                    <input class="uploadFile" name="importFile" id="importFile" type="file">&nbsp;
                    <button class="inputbtn standard" type="button" id="importBtn"
                        onclick="importConfigFile()">
                        导入配置
                    </button>
            </form>
        </td>
    </tr>
    <tr>
        <td class="tdheader"></td>
        <td class="tdbody">
            <form class="inline" action="Function/systemManagement/maintain/backupAndRecovery.php?restore=1"
                method="GET" id="restoreForm" onSubmit="return false">
                <button type="button" class="inputbtn standard" onclick="restore()">
                恢复出厂配置
                </button>
            </form>
            <form class="inline" action="Function/systemManagement/maintain/backupAndRecovery.php?save=1"
                method="GET" id="saveForm" onSubmit="return false">
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
    validateForm($("#importFileForm"));
});
</script>
