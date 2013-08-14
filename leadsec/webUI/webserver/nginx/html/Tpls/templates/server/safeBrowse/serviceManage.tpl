<form action="Function/server/safeBrowse/serviceManage.php" method="POST" id="setServiceManageForm"
    onSubmit="return false;">
    <table class="column_95">
    	<input type="hidden" <{if $httpStatus eq 1}> value="disable" <{else}> value="enable" <{/if}> name="stopService" id="stopService"\>
        <caption>服务端管理</caption>
        <tbody>
        <tr>
            <td class="tdheader" width="250">当前服务端状态:</td>
            <td class="tdbody"><span id="status">
               <{if $httpStatus eq 1}>
               		开启
               <{else}>
               		停止
               <{/if}></span>
            </td>
        </tr>

        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" name="buttonOn" class="inputbtn standard" onclick="setServiceForm()"
                	<{if $httpStatus eq 1}> disabled="disabled"<{/if}>>开启服务端</button>
                <button type="button" name="buttonOff" class="inputbtn standard" onclick="setServiceForm()"
                	<{if $httpStatus eq 0}> disabled="disabled"<{/if}>>停止服务端</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script type="text/javascript" src="Public/js/server/safeBrowse/serviceManage.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
});
</script>