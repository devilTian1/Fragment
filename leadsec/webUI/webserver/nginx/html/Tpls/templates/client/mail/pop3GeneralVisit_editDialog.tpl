<form action="Function/client/mail/pop3GeneralVisit.php" method="POST"
    id="editPop3CommClientAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <legend>POP3客户端普通访问</legend>
        <div class="row">
            <label for="pop3Id">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="pop3Id"
                value="<{$data.id}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type ==='edit'}>
            <input type="hidden" name="pop3Id" value="<{$data.id}>"/>
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
            <{html_options class="select lip" name="pop3lip"
                options=$ifList selected=$data.lip}>
        </div>

        <div class="row">
            <label for="lport">本机端口:<em class="required">*</em></label>
            <input class="port" type="text" name="pop3lportReq" id="pop3lportReq"
                value="<{$data.lport|default: 110}>" size="5" maxlength="5"/>
        </div>
        
        <div class="row">
            <label for="filter">过滤选项:</label>
            <{html_options class="select filter" name="filter"
                options=$filterOptions selected=$data.filter|default: '无'}>
        </div>

        <div class="row">
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
        
		<div class="row">
    		<label>病毒扫描</label>
    		<{html_radios class="radio" name=fileav label_ids=true values=array('on', 'off')
              output=array('开', '关') selected=$editFilter.fileav|default: 'on'
            }>
    	</div>

        <div class="row">
            <label for="active">是否启动:</label>
            <{html_radios class="radio" name=active label_ids=true values=array('ok', 'erro')
                output=array('开', '关') selected=$data.active|default: 'ok'}>
        </div>

        <div class="row">
            <label for="comment">备注:</label>
            <input class="comment" name="comment" id="comment" value="<{$data.comment}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        filterRes();
        validateForm($("#editPop3CommClientAclForm"));
        $('label[for^="ipType_"], label[for^="active_"]').addClass('radioLabel');

        $('select[name="pop3lip"]').click(function() {
            $('#pop3lportReq').rules('remove', 'remote');
            $(this).rules('add', {remote: validRules.pop3lip.remote});
        });
    
        $('#pop3lportReq').keypress(function() {
            $('select[name="pop3lip"]').rules('remove', 'remote');
            $(this).rules('add', {remote : validRules.pop3lportReq.remote});
        });
    });
</script>
