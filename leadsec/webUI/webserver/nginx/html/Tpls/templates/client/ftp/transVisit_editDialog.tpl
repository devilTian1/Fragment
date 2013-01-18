<form action="Function/client/ftp/transVisit.php" method="POST"
    id="editFtpTransClientAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <legend>FTP客户端透明访问</legend>
        <div class="row">
            <label for="ftpId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="ftpId" value="<{$data.id}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type ==='edit'}>
            <input type="hidden" name="ftpId" value="<{$data.id}>"/>
            <{/if}>
        </div>

        <div class="row">
            <label for="sa">源地址:</label>
            <{html_options class="select sa" name="sa"
                options=$addrOptions selected=$data.sa|default: 'any'}>
        </div>

        <div class="row">
            <label for="sa">目的地址:</label>
            <{html_options class="select da" name="da"
                options=$addrOptions selected=$data.da|default: 'any'}>
        </div>

        <div class="row">
            <label for="dportReq">目的端口:<em class="required">*</em></label>
            <input class="port" type="text" name="dportReq"
                value="<{$data.dport|default: 21}>" size="5" maxlength="5"/>
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
        filterRes();
        validateForm($("#editFtpTransClientAclForm"));
        $('label[for^="ipType_"], label[for^="active_"]').addClass('radioLabel');
    });
</script>
