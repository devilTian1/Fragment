<form action="Function/client/fileEx/sendTask.php" method="POST"
    id="editSendTaskForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>发送任务</legend>
        <div class="row">
            <label for="sendTaskId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="sendTaskId" id="sendTaskId" value="<{$data.task_id}>"
                <{if $type ==='edit'}>disabled="disabled"<{/if}>/>(同一端的任务号必须唯一)
            <{if $type ==='edit'}>
                <input type="hidden" name="sendTaskId"
                    value="<{$data.task_id}>"/>
            <{/if}>
        </div>

        <div class="row">
            <label for="sip">服务器地址:<em class="required">*</em></label>
            <input class="width10em" type="text" name="sip" id="sip" value="<{$data.ip}>"/>
        </div>

        <div class="row">
            <label for="shareName">服务器共享名:<em class="required">*</em></label>
            <input class="width10em" type="text" name="shareName" id="shareName"
                value="<{$data.share_name}>"/>
        </div>

        <div class="row">
            <label for="fs">文件系统:</label>
            <{html_radios class="radio" name=fs label_ids=true
                output=array('NFS', 'SMBFS') values=array('nfs', 'smbfs')
                selected=$data.fs|default: 'nfs' onClick="switchFs()"}>
        </div>

		<div class="row">
            <label for="sendTaskPort">端口:<em class="required">*</em></label>
            <input class="port" type="text" name="sendTaskPort" id="sendTaskPort" 
                value="<{$data.port|default: 445}>" size="5" maxlength="5"/>
        </div>

        <div class="row smbDiv">
            <label for="smbUser">用户名:</label>
            <input class="width10em" type="text" name="smbUser" id="smbUser"
                value="<{$data.user}>"/>
        </div>

        <div class="row smbDiv">
            <label for="smbPwd">密码:</label>
            <input class="width10em" type="password" name="smbPwd" id="smbPwd"
                value="<{$data.password}>"/>
        </div>

        <div class="row">
            <label for="sendMethod">传输方式:</label>
            <{html_radios class="radio" name=sendMethod label_ids=true
                output=array('改名传输', '增量传输', '发送后删除')
                values=array('C', 'S', 'R')
                selected=$data.method|default: 'C'
                onClick="switchSendMethod()"}>
        </div>

        <div class="row changenameDiv">
            <label for="readyString">源名标识:<em class="required">*</em></label>
            <input class="width10em" type="text" name="readyString" id="readyString"
                value="<{$data.ready_string}>"/>
        </div>

        <div class="row changenameDiv">
            <label for="completeString">完成后标识:<em class="required">*</em></label>
            <input class="width10em" type="text" name="completeString" id="completeString"
                value="<{$data.complete_string}>"/>
        </div>

        <div class="row">
            <label for="subdir">包含子目录:</label>
            <{html_radios class="radio" name=subdir label_ids=true
                output=array('是', '否')
                values=array('Y', 'N')
                selected=$data.subdir|default: 'Y'}>
        </div>
       <div <{if $killVirusIsUsed eq 'off'}> class="hide"<{/if}>>
        <div class="row">
            <label for="killvirus">文件病毒扫描:</label>
            <{html_radios class="radio" name=killvirus label_ids=true
                title="需要开启病毒防护模块" output=array('是', '否')
                values=array('Y', 'N') selected=$data.killvirus|default: 'Y'}>
        </div>
       </div>
        <div class="row">
            <label for="internal">同步间隔(单位:秒):<em class="required">*</em></label>
            <input class="width10em" type="text" name="interval" id="interval"
                value="<{$data.interval}>"/>
        </div>
    
        <div class="row">
            <label for="time">生效时段:</label>
            <{html_options class="select time" name="time" options=$timeList
                selected=$data.time|default: '无'}>
        </div>

        <div class="row">
            <label for="filter">过滤选项:</label>
            <{html_options class="select filter" name="FEfilterOpt" id="FEfilterOpt"
                options=$filters selected=$data.filter|default: '无'}>&nbsp;&nbsp;
            <button style="position: static"
                onclick="openNewFilterDialog('plug')">添加
            </button>&nbsp;&nbsp;
            <{if $type === 'edit'}>
            <button style="position: static"
                onclick="editFilterDialog($('#FEfilterOpt').val(),'plug')">修改
            </button>
            <{/if}>
        </div>

        <div class="row">
            <label for="active">是否启动:</label>
            <{html_radios class="radio" name=active label_ids=true
                output=array('启动', '停止')
                values=array('Y', 'N')
                selected=$data.active|default: 'Y'}>
        </div>
        
        <div class="row">
            <span>注：服务器共享名下的文件名长度不能超过512字节</span>
        </div>
    </fieldset>
</form>
<script type="text/javascript" src="Public/js/client/fileEx/filter.js"></script>
<script type="text/javascript" src="Public/js/client/fileEx/sendTask.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        switchFs(<{$data.port}>);
        switchSendMethod();
        filterRes();
        validateForm($("#editSendTaskForm"));
        $('label[for^="fs_"], label[for^="sendMethod_"], label[for^="subdir_"],label[for^="killvirus_"], label[for^="active_"]').addClass('radioLabel');
        $("input:radio").tooltip()
    });
</script>
