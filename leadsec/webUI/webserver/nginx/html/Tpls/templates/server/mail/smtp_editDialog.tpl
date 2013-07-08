<form action="Function/server/mail/smtp.php" method="POST"
    id="editSmtpCommServerAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加SMTP普通访问</legend>
        <div class="row">
            <label for="smtpGeneralId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="smtpGeneralId" id="smtpGeneralId" value="<{$data.id}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type ==='edit'}>
            <input type="hidden" name="smtpGeneralId" value="<{$data.id}>"/>
            <{/if}>
        </div>

        <div class="row">
            <label for="serverIp">服务器地址:<em class="required">*</em></label>
            <input class="width10em" type="text" name="serverIp" id="serverIp"
                value="<{$data.serverip}>"/>
        </div>
        
        <div class="row">
            <label for="smtpGeneralSport">服务器端口:<em class="required">*</em></label>
            <input class="port" type="text" name="smtpGeneralSport" id="smtpGeneralSport" value="<{$data.sport|default: 25}>" size="5" maxlength="5"/>
        </div>

        <div class="row">
            <label for="active">是否启动:</label>
            <{html_radios class="radio" name=active label_ids=true values=array('ok', 'erro')
                output=array('开', '关') selected=$data.active|default: 'ok'}>
        </div>

        <div class="row">
            <label for="comment">备注:</label>
            <input class="width10em comment" name="comment" id="comment" value="<{$data.comment|escape}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editSmtpCommServerAclForm"));
        $('label[for^="active_"]').addClass('radioLabel');
    });
</script>
