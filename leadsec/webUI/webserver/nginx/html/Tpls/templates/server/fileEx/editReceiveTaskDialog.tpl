<form action="Function/server/fileEx/receiveTask.php" method="POST"
    id="editReceiveTaskForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>发送任务</legend>
        <div class="row">
            <label for="receiveTaskId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="receiveTaskId" value="<{$data.task_id}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>/>
            <{if $type ==='edit'}>
                <input type="hidden" name="receiveTaskId"
                    value="<{$data.task_id}>"/>
            <{/if}>
        </div>

        <div class="row">
            <label for="sip">服务器地址:<em class="required">*</em></label>
            <input type="text" name="sip" id="sip" value="<{$data.ip}>"/>
        </div>

        <div class="row">
            <label for="shareName">服务器共享名:<em class="required">*</em></label>
            <input type="text" name="shareName" id="shareName"
                value="<{$data.share_name}>"/>
        </div>

        <div class="row">
            <label for="fs">文件系统:</label>
            <{html_radios class="radio" name=fs label_ids=true
                output=array('NFS', 'SMBFS') values=array('nfs', 'smbfs')
                selected=$data.fs|default: 'nfs' onClick="switchFs()"}>
        </div>

		<div class="row">
            <label for="portReq">端口:<em class="required">*</em></label>
            <input class="port" type="text" name="portReq"
                value="<{$data.port|default: 445}>" size="5" maxlength="5"/>
        </div>

        <div class="row smbDiv">
            <label for="smbUser">用户名:</label>
            <input type="text" name="smbUser" id="smbUser"
                value="<{$data.user}>"/>
        </div>

        <div class="row smbDiv">
            <label for="smbPwd">密码:</label>
            <input type="password" name="smbPwd" id="smbPwd"
                value="<{$data.password}>"/>
        </div>

        <div class="row">
            <label for="active">是否启动:</label>
            <{html_radios class="radio" name=active label_ids=true
                output=array('启动', '停止')
                values=array('Y', 'N')
                selected=$data.active|default: 'Y'}>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        switchFs();
        filterRes();
        renderStandardUi();
        validateForm($("#editReceiveTaskForm"));
        $('label[for^="fs_"], label[for^="active_"]').addClass('radioLabel');
    });
</script>
