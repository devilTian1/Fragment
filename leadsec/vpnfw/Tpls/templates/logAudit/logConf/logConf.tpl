<form action="index.php?R=logAudit/logConf/logConf/setLogConf" method="POST"
    id="setLogConfForm" onSubmit="return false;">
    <table class="column_95">
        <caption>日志设置</caption>
        <tbody>
        <tr>
            <td class="tdheader" width="250">日志满操作方式:</td>
            <td class="tdbody">
            	<label><input name="overstop" type="radio" value="1" <{if $initData.overwrite eq 'on'}> checked="checked"<{/if}> />覆盖</label>
                <label><input name="overstop" type="radio" value="0"  <{if $initData.stopwrite eq 'on'}> checked="checked"<{/if}>  />暂停</label>
            </td>
        </tr>
        <tr>
            <td class="tdheader">日志满邮件提示:</td>
            <td class="tdbody">
            	<label><input name="sendemail" type="checkbox" value="1" <{if $initData.sendemail eq 'on'}> checked="checked"<{/if}> />开启日志满邮件提醒</label>
            </td>
        </tr>
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" class="inputbtn standard" onclick="setLogConf()">提交</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script type="text/javascript" src="Public/js/logAudit/logConf/logConf.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
});
</script>
