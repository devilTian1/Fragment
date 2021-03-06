<form action="Function/server/mail/pop3.php" method="POST"
    id="editPop3CommServerAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加POP3普通访问</legend>
        <div class="row">
            <label for="pop3GeneralId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="pop3GeneralId" id="pop3GeneralId" value="<{$data.id}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type ==='edit'}>
            <input type="hidden" name="pop3GeneralId" value="<{$data.id}>"/>
            <{/if}>
        </div>

        <div class="row">
            <label for="serverIp">服务器地址:<em class="required">*</em></label>
            <input class="width10em" type="text" name="serverIp" id="serverIp"
                value="<{$data.serverip}>"/>
        </div>
        
        <div class="row">
            <label for="pop3GeneralSport">服务器端口:<em class="required">*</em></label>
            <input class="port" type="text" name="pop3GeneralSport" id="pop3GeneralSport" value="<{$data.sport|default: 110}>" size="5" maxlength="5"/>
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
        validateForm($("#editPop3CommServerAclForm"));
        $('label[for^="active_"]').addClass('radioLabel');
    });
</script>
