<form action="Function/client/customized/tcpGeneralVisit.php" method="POST"
    id="editTcpCommClientAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加TCP普通访问</legend>
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
            <label for="active">ip地址类型:</label>
            <{html_radios class="radio" name=ipType label_ids=true
                output=array('ipv4', 'ipv6')
                values=array('ipv4', 'ipv6')
                selected=$data.ip_ver|default: 'ipv4'
                onClick="filterIp()"}>
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
                output=array('开', '关') selected=$data.active|default: 'Y'}>
        </div>

        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$data.comment}></textarea>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    function filterIp() {
        var type    = $('input:radio[name="ipType"]:checked').val();
        var saOpts  = $('select[name="sa"]>option');
        var lipOpts = $('select[name="lip"]>option');
        saOpts.show(); 
        lipOpts.show(); 
        if (type === 'ipv4') {
            saOpts.filter('[value$="_ipv6"]').hide();
            lipOpts.filter('[value*=":"]').hide();
        } else if (type === 'ipv6') {
            saOpts.filter('[value$="_ipv4"]').hide();
            lipOpts.filter('[value*="."]').hide();
        } else {
        }
        saOpts.filter(':visible:eq(0)').attr('selected','selected');
        lipOpts.filter(':visible:eq(0)').attr('selected','selected');
    }
    $(document).ready(function() {
        filterIp()
        validateForm($("#editTcpCommClientAclForm"));
        $('label[for^="ipType_"], label[for^="killVirus_"], label[for^="active_"]').addClass('radioLabel');
    });
</script>
