<form action="Function/appS/virusProtection/engineManage.php" method="POST" id="setEngineManageForm"
    onSubmit="return false;">
    <table class="column_95">
    	<input type="hidden" <{if $serviceStatus eq 1}> value="disable" <{else}> value="enable" <{/if}> name="stopService" id="stopService"\>
        <caption>启停管理</caption>
        <tbody>
        <tr>
            <td class="tdheader" width="250">当前服务状态:</td>
            <td class="tdbody"><span id="status">
               <{if $serviceStatus eq 1}>
               		启动
               <{else}>
               		停止
               <{/if}></span>
            </td>
        </tr>

        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" name="buttonOn" class="inputbtn standard" onclick="setServiceForm()"
                	<{if $serviceStatus eq 1}> disabled="disabled"<{/if}>>启动服务</button>
                <button type="button" name="buttonOff" class="inputbtn standard" onclick="setServiceForm()"
                	<{if $serviceStatus eq 0}> disabled="disabled"<{/if}>>停止服务</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script type="text/javascript" src="Public/js/appS/virusProtection/engineManage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
});
</script>