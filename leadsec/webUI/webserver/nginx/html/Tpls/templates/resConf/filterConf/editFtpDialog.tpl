<form action="Function/resConf/filterConf/ftp.php" method="POST"
    id="editFtpFilterOptionForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <{if $type === 'edit'}>
        <input type="hidden" name="id" value="<{$data.id}>"/>
    <{/if}>
    <fieldset>
        <legend>常规配置</legend>
		<div class="row">
            <label for="name">名称:<em class="required">*</em></label>
            <input type="text" name="ftpFilterOptName" size="15" maxLength="15"
                value="<{$data.name}>"/>
        </div>
        <div class="row">
            <label for="banner">Banner保护:</label>
            <input class="banner" type="text" name="banner"
                value="<{$data.banner}>"/>
        </div>
        <div class="row">
            <label for="comment">备注:</label>
            <input class="filterOptComment" type="text" name="comment"
                value="<{$data.comment}>" />
        </div>
    </fieldset>
     
    <fieldset>
     	<legend>用户控制</legend>
        <div class="row">
            <label>控制动作:</label>
            <{html_radios class="radio" name=userAct label_ids=true
                        output=array('允许', '禁止') values=array('0', '1')
                        selected=$data.user_act|default: '1'}>
        </div>
        <div class="row">
            <label for="userInfo">用户:</label>
        	<input type="text" name="userInfo" value="<{$data.user_info}>"/>
            多个用户用,隔开
        </div>
    </fieldset>
     
    <fieldset>
        <legend>命令控制</legend>
        <div class="row">
            <label>控制动作:</label>
            <{html_radios class="radio" name=cmdAct label_ids=true
                output=array('允许', '禁止') values=array('0', '1')
                selected=$data.cmd_act|default: '1'}>
        </div>
        
        <div class="row">
            <label>命令行列表:</label>
            <div class="column column_70">
                <{html_checkboxes class="radio" name=cmdInfo label_ids=true
                    output=array('dir', 'delete', 'ls', 'cd', 'get', 'put', 'pwd', 'quit', 'mkdir', 'rename', 'rmdir', 'append')
                    values=array('LIST', 'DELE', 'NLST', 'CWD', 'RETR', 'STOR', 'XPWD', 'QUIT', 'XMKD', 'RNFR', 'XRMD', 'APPE')
                    checked=$data.cmd_info}>
            </div>
        </div>
    </fieldset>
     
    <fieldset>
     	<legend>上传控制</legend>
        <div class="row">
            <label>控制动作:</label>
            <{html_radios class="radio" name=uploadAct label_ids=true
            output=array('允许文件上传', '禁止文件上传') values=array('0', '1')
            selected=$data.upload_act|default: '1'}>
        </div>
        <div class="row">
            <label for="uploadInfo">上传文件类型:</label>
        	<input type="text" name="uploadInfo" value="<{$data.upload_info}>"/>
        </div>
    </fieldset>
     
    <fieldset>
     	<legend>下载控制</legend>
        <div class="row">
            <label>控制动作:</label>
            <{html_radios class="radio" name=downAct label_ids=true
            output=array('允许文件下载', '禁止文件下载') values=array('0', '1')
            selected=$data.down_act|default: '1'}>
        </div>
        <div class="row">
            <label for="downInfo">下载文件类型:</label>
        	<input type="text" name="downInfo" value="<{$data.down_info}>"/>
        </div>
     </fieldset>
     
     <fieldset>
     	<legend>病毒扫描控制</legend>
        <div class="row">
            <label for="fileSize">文件扫描大小:</label>
            <input type="text" name="fileSize" value="<{$data.file_size}>"/>
            KB
        </div>
        <div class="row">
            <label>文件病毒扫描:</label>
            <{html_radios class="radio" name=virus label_ids=true
            output=array('开启', '关闭') values=array('Y', 'N')
            selected=$data.virus|default: 'N'}>
        </div>
     </fieldset>  
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editFtpFilterOptionForm"));
        $('label[for^="userAct_"], label[for^="cmdAct_"], label[for^="virus_"]').addClass('radioLabel');
        $('label[for^="cmdInfo_"]').addClass('cmdInfoLabel');
    });
</script>