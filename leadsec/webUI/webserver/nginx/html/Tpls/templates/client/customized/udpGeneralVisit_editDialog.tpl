<form action="Function/client/customized/udpGeneralVisit.php" method="POST"
    id="editUdpCommClientAclForm" onSubmit="return false;">
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
            <label for="sa">源地址:</label>
            <{html_options class="select" name="sa"
                options=$addrOptions selected=$data.sa|default: 'any'}>
        </div>
        
         <div class="row">
            <label for="lip">本机地址:</label>
            <{html_options class="select" name="lip"
                options=$ifList selected=$data.lip|default: 'empty'}>
        </div>
        
        <div class="row">
            <label for="lport">本机端口:<em class="required">*</em></label>
            <input class="auto" type="text" name="lportReq" value="<{$data.lport}>" size="5" maxlength="5"/>
        </div>
        
        <div class="row">
            <label>流病毒扫描:</label>
            <{html_radios class="radio" name=killVirus label_ids=true values=array('Y', 'N')
                output=array('开', '关') selected=$data.killvirus|default: 'N'
            }>
        </div>
        
        <div class="row">
            <label for="usergrp">认证用户组:</label>
            <{html_options class="select" name="usergrp" options=$roleList
                selected=$data.usergrp|default: 'empty'}>
        </div>
        
        <div class="row">
            <label for="destip">生效时段:</label>
            <{html_options class="select" name="time" options=$timeList
                selected=$data.time|default: 'empty'}>
            </select>
        </div>
        
        <div class="row">
            <label for="active">是否启动:</label>
            <{html_radios class="radio" name=active label_ids=true values=array('Y', 'N')
                output=array('开', '关') selected=$data.active|default: 'N'}>
        </div>

        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$data.comment}></textarea>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editUdpCommClientAclForm"));
        $('label[for^="killVirus_"], label[for^="active_"]').addClass('radioLabel');
    });
</script>
