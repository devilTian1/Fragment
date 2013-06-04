<form action="Function/client/mail/smtpTransVisit.php" method="POST"
    id="editSmtpTransClientAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <legend>SMTP客户端透明访问</legend>
        <div class="row">
            <label for="smtpTransId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="smtpTransId" id="smtpTransId" value="<{$data.id}>" 
                <{if $type ==='edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type ==='edit'}>
            <input type="hidden" name="smtpTransId" id="smtpTransId" value="<{$data.id}>"/>
            <{/if}>
        </div>

        <div class="row">
            <label for="sa">源地址:</label>
            <{html_options class="select sa" name="sa"
                options=$saddrOptions selected=$data.sa|default: 'any'}>
        </div>

        <div class="row">
            <label for="sa">目的地址:</label>
            <{html_options class="select da" name="da"
                options=$daddrOptions selected=$data.da|default: 'any'}>
        </div>

        <div class="row">
            <label for="smtpTranslportReq">目的端口:<em class="required">*</em></label>
            <input class="port" type="text" name="smtpTranslportReq" id="smtpTranslportReq"
                value="<{$data.dport|default: 25}>" size="5" maxlength="5"/>
        </div>
        
        <div class="row">
            <label for="filter">过滤选项:</label>
            <{html_options class="select filter" name="filter" id="filter"
                options=$filterOptions selected=$data.filter|default: '无'}>&nbsp;&nbsp;
            <button style="position: static"
                onclick="openNewFilterDialog('smtp')">添加
            </button>&nbsp;&nbsp;
            <button style="position: static"
                onclick="openEditFilterDialog($('#filter').val(),'smtp')">修改
            </button>
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
            <label for="active">是否启动:</label>
            <{html_radios class="radio" name=active label_ids=true values=array('ok', 'erro')
                output=array('开', '关') selected=$data.active|default: 'ok'}>
        </div>
		
		<div class="row">
            <label for="killvirus">病毒扫描:</label>
            <{html_radios class="radio" name=killVirus label_ids=true values=array('Y', 'N')
              output=array('开', '关') selected=$data.killvirus|default: 'N'
            }>
        </div>
		
        <div class="row">
            <label for="comment">备注:</label>
            <input class="width10em comment" name="comment" id="comment" value="<{$data.comment|escape}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript" src="Public/js/client/mail/mailfilter.js"></script>
<script type="text/javascript" src="Public/js/client/mail/smtpTransVisit.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        filterRes();
        validateForm($("#editSmtpTransClientAclForm"));
        $('label[for^="ipType_"], label[for^="active_"], label[for^="killVirus_"]').addClass('radioLabel');
    });
</script>
