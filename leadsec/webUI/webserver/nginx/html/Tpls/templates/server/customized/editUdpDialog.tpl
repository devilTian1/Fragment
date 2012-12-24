<form action="Function/server/customized/udp.php" method="POST"
    id="editUdpCommServerAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加UDP普通访问</legend>
        <div class="row">
            <label for="customId">任务号:<em class="required">*</em></label>
            <input class="auto" type="text" name="customId" value="<{$data.id}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type ==='edit'}>
            <input type="hidden" name="customId" value="<{$data.id}>"/>
            <{/if}>
        </div>
        
        <div class="row">
            <label for="serverIp">服务器地址:<em class="required">*</em></label>
            <input type="text" name="serverIp" id="serverIp"
                value="<{$data.serverip}>"/>
        </div>
        
        <div class="row">
            <label for="lport">服务器端口:<em class="required">*</em></label>
            <input class="auto" type="text" name="sportReq" value="<{$data.sport}>" size="5" maxlength="5"/>
        </div>

        <div class="row">
            <label for="active">是否启动:</label>
            <{html_radios class="radio" name=active label_ids=true values=array('Y', 'N')
                output=array('开', '关') selected=$data.active|default: 'Y'}>
        </div>

        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$data.comment}></textarea>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editUdpCommServerAclForm"));
        $('label[for^="active_"]').addClass('radioLabel');
    });
</script>
