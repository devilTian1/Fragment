<form action="Function/client/ftp/ftp.php" method="POST"
    id="editFtpFilterOptionForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <{if $type === 'edit'}>
        <input type="hidden" name="id" value="<{$data.id}>"/>
    <{/if}>
    <fieldset>
        <legend>常规配置</legend>
		<div class="row">
            <label for="name">名称:<em class="required">*</em></label>
            <input class="width150" type="text" name="ftpFilterOptName" size="15" maxLength="15"
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
                value="<{$data.comment|escape}>" />
        </div>
    </fieldset>
     
    <fieldset>
     	<legend>用户控制</legend>
        <div class="row">
            <label>控制动作:</label>
            <{html_radios class="radio" name=userAct label_ids=true
                        output=array('允许', '禁止') values=array('1', '0')
                        selected=$data.user_act|default: '1'}>
        </div>
        <div class="row">
            <label for="userInfo">用户:</label>
        	<input type="text" name="userInfo" id="userInfo" value="<{$data.user_info}>"/>
            多个用户用(,)隔开, 不填写表示所有用户.
        </div>
    </fieldset>
     
    <fieldset>
        <legend>命令控制</legend>
        <div class="row">
            <label>控制动作:</label>
            <{html_radios class="radio" name=cmdAct label_ids=true
                output=array('允许', '禁止') values=array('1', '0')
                selected=$data.cmd_act|default: '1'}>
        </div>
        
        <div class="row">
            <label>命令行列表:</label>
            <div class="column column_70">
                <{html_checkboxes class="radio" name=cmdInfo label_ids=true
                    output=$cmdInfoOut values=$cmdInfoVal 
                    checked=$data.cmd_info}>
            </div>
        </div>
    </fieldset>
     
    <fieldset>
     	<legend>上传控制</legend>
        <div class="row">
            <label>后缀动作:</label>
            <{html_radios class="radio" name=uploadAct label_ids=true
            output=array('允许文件上传', '禁止文件上传') values=array('1', '0')
            selected=$data.upload_act|default: '1'}>
        </div>
        <div class="row">
            <label for="uploadInfo">上传文件特征:</label>
        	<input type="text" name="uploadInfo" value="<{$data.upload_info}>"/>
            多个特征用(,)隔开, 不填表示所有文件特征.
        </div>
         <div class="row">
            <label>过滤动作:</label>
            <{html_radios class="radio" name=cmdAct_upload label_ids=true
                output=array('允许', '禁止') values=array('1', '0')
                selected=$data.upload_str_act|default: '1'}>
        </div>
        
        <div class="row">
            <label>过滤列表:</label>
            <div class="column column_70">
                <{html_checkboxes class="radio" name=cmdInfo_upload
                    label_ids=true
                    output=array('exe', 'pdf', 'jpg', 'rar', 'zip', 'bmp', 'avi', 'mp3', 'rm', 'mpg', 'mso', 'elf')
                    values=array('exe', 'pdf', 'jpg', 'rar', 'zip', 'bmp', 'avi', 'mp3', 'rm', 'mpg', 'mso', 'elf')
                    checked=$data.cmd_info_upload}>
            </div>
        </div>
    </fieldset>
     
    <fieldset>
     	<legend>下载控制</legend>
        <div class="row">
            <label>后缀动作:</label>
            <{html_radios class="radio" name=downAct label_ids=true
            output=array('允许文件下载', '禁止文件下载') values=array('1', '0')
            selected=$data.down_act|default: '1'}>
        </div>
        <div class="row">
            <label for="downInfo">下载文件特征:</label>
        	<input type="text" name="downInfo" value="<{$data.down_info}>"/>
                多个特征用(,)隔开, 不填表示所有文件特征.
        </div>
         <div class="row">
            <label>过滤动作:</label>
            <{html_radios class="radio" name=cmdAct_download label_ids=true
                output=array('允许', '禁止') values=array('1', '0')
                selected=$data.down_str_act|default: '1'}>
        </div>
        
        <div class="row">
            <label>过滤列表:</label>
            <div class="column column_70">
                <{html_checkboxes class="radio" name=cmdInfo_download label_ids=true
                    output=array('exe', 'pdf', 'jpg', 'rar', 'zip', 'bmp', 'avi', 'mp3', 'rm', 'mpg', 'mso', 'elf')
                    values=array('exe', 'pdf', 'jpg', 'rar', 'zip', 'bmp', 'avi', 'mp3', 'rm', 'mpg', 'mso', 'elf')
                    checked=$data.cmd_info_download}>
            </div>
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
