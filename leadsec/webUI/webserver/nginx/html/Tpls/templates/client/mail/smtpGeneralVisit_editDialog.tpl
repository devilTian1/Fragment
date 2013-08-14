<form action="Function/client/mail/smtpGeneralVisit.php" method="POST"
    id="editSmtpCommClientAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <legend>SMTP客户端普通访问</legend>
        <div class="row">
            <label for="smtpGeneralId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="smtpGeneralId" id="smtpGeneralId"
                value="<{$data.id}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type ==='edit'}>
            <input type="hidden" name="smtpGeneralId" id="smtpGeneralId" value="<{$data.id}>"/>
            <{/if}>
        </div>

        <div class="row">
            <label for="active">ip地址类型:</label>
            <{html_radios class="radio" name=ipType label_ids=true
                output=array('ipv4', 'ipv6')
                values=array('ipv4', 'ipv6')
                selected=$data.ip_ver|default: 'ipv4'
                onClick="filterRes()"}>
        </div>

        <div class="row">
            <label for="sa">源地址:</label>
            <{html_options class="select sa" name="sa"
                options=$addrOptions selected=$data.sa|default: 'any'}>
        </div>

        <div class="row">
            <label for="lip">本机地址:</label>
            <{html_options class="select lip" name="smtpGeneralLip" id="smtpGeneralLip"
                options=$ifList selected=$data.lip}>
        </div>

        <div class="row">
            <label for="lport">本机端口:<em class="required">*</em></label>
            <input class="port" type="text" name="smtpGeneralLport" id="smtpGeneralLport"
                value="<{$data.lport|default: 25}>" size="5" maxlength="5"/>
        </div>
        
        <div class="row">
            <label for="filter">过滤选项:</label>
            <{html_options class="select filter" name="filter" id="filter" 
                options=$filterOptions selected=$data.filter|default: '无'}>&nbsp;&nbsp;
            <button style="position: static"
                onclick="openNewFilterDialog('smtp')">添加
            </button>&nbsp;&nbsp;
            <{if $type ==='edit'}>
            <button style="position: static"
                onclick="openEditFilterDialog($('#filter').val(),'smtp')">修改
            </button>
            <{/if}>
        </div>

        <div class="row" id="authGrp">
            <label for="usergrp">认证用户组:</label>
            <{html_options class="select usergrp" name="usergrp"
                options=$roleList selected=$data.usergrp|default: 'empty'}>
        </div>
        

        <div class="row">
            <label for="destip">生效时段:</label>
            <{html_options class="select time" name="time" options=$timeList
                selected=$data.time|default: 'empty'}>
            </select>
        </div>
        <div <{if $killVirusIsUsed eq 'off'}> class="hide"<{/if}>>
		<div class="row">
    		<label>病毒扫描:</label>
    		<{html_radios class="radio" name=virus label_ids=true values=array('on', 'off')
              output=array('开', '关') selected=$data.virus|default: 'off'
            }>
    	</div>
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
<script type="text/javascript" src="Public/js/client/mail/mailfilter.js"></script>
<script type="text/javascript" src="Public/js/client/mail/smtpGeneralVisit.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        filterRes();
        validateForm($("#editSmtpCommClientAclForm"));
        $('label[for^="ipType_"], label[for^="active_"], label[for^="virus_"]').addClass('radioLabel');

        $('select[name="smtplip"]').click(function() {
            $('#smtplportReq').rules('remove', 'remote');
            $(this).rules('add', {remote: validRules.smtplip.remote});
        });
    
        $('#smtplportReq').keypress(function() {
            $('select[name="smtplip"]').rules('remove', 'remote');
            $(this).rules('add', {remote : validRules.smtplportReq.remote});
        });
    });
</script>
