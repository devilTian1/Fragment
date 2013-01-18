<form action="Function/server/fileSync/fileSync.php" method="POST"
    id="editFileSyncServerAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加服务端文件同步</legend>
        <div class="row">
            <label for="fsId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="fsId" value="<{$data.id}>"
                <{if $type === 'edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type === 'edit'}>
            <input type="hidden" name="fsId" value="<{$data.id}>"/>
            <{/if}>
        </div>
        
        <div class="row">
            <label for="serverIp">服务器地址:<em class="required">*</em></label>
            <input type="text" name="serverIp" id="serverIp"
                value="<{$data.serverip}>"/>
        </div>
        
        <div class="row">
            <label for="lport">服务器端口:<em class="required">*</em></label>
            <input class="port" type="text" name="sportReq" value="<{$data.sport}>" size="5" maxlength="5"/>
        </div>

        <div class="row">
            <label>本地备份:</label>
            <{html_radios class="radio" name=mode label_ids=true values=array('B', 'Q')
                output=array('是', '否') selected=$data.mode|default: 'Q'
                disabled="disabled"
            }>
        </div>

        <div class="row">
            <label>身份认证及传输加密:</label>
            <{html_radios class="radio" name=ssl label_ids=true
                values=array('Y', 'N') onClick="toggleCNameDiv()"
                output=array('是', '否') selected=$data.ssl|default: 'Y'
            }>
        </div>
        
        <div class="row cNameDiv">
            <label>客户端证书公共名:<em class="required">*</em></label>
            <input type="text" name="commname" value="<{$data.commname}>"/>
        </div>
        <!--
        <div class="row">
            <label for="time">加密级别:</label>
            <{html_options class="select seclevel" name="seclevel"
                values=array(0, 1, 2, 3, 4, 5)
                output=array('不提取密集', '公开', '内部', '秘密', '机密', '绝密')
                selected=$data.seclevel|default: 1}>
            </select>
        </div>
        -->
        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$data.comment}></textarea>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        toggleCNameDiv();
        validateForm($("#editFileSyncServerAclForm"));
        $('label[for^="mode_"], label[for^="ssl_"]').addClass('radioLabel');
    });
</script>
