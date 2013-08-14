<form action="Function/client/fileSync/fileSync.php" method="POST"
    id="editFileSyncClientAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加客户端文件同步</legend>
        <div class="row">
            <label for="clientFileSyncTaskId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="clientFileSyncTaskId" id="clientFileSyncTaskId" value="<{$data.id}>"
                <{if $type === 'edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type === 'edit'}>
            <input type="hidden" name="fsId" value="<{$data.id}>"/>
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
            <label for="clientFileSyncLip">本机地址:</label>
            <{html_options class="select lip" name="clientFileSyncLip" 
                id="clientFileSyncLip" options=$ifList 
				selected=$data.lip|default: '无'}>
        </div>
        
        <div class="row">
            <label for="clientFileSyncLport">端口:<em class="required">*</em></label>
            <input class="port" type="text" name="clientFileSyncLport" id="clientFileSyncLport"
			value="<{$data.lport}>" size="5" maxlength="5"/>
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
            <input type="text" class="width132" name="commname" value="<{$data.commname}>"/>
        </div>
        
		<div <{if $killVirusIsUsed eq 'off'}> class="hide"<{/if}> >
			<div class="row">
				<label>流病毒扫描:</label>
				<{html_radios class="radio" name=killVirus label_ids=true values=array('Y', 'N')
					output=array('是', '否') selected=$data.killvirus|default: 'N'
				}>
			</div>
		</div>

        <div class="row">
            <label for="time">生效时段:</label>
            <{html_options class="select time" name="time" options=$timeList
                selected=$data.time|default: '无'}>
            </select>
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
            <input class="width132" class="comment" name="comment" id="comment" value="<{$data.comment}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        filterRes();
        toggleCNameDiv();
        validateForm($("#editFileSyncClientAclForm"));
        $('label[for^="mode_"], label[for^="ssl_"], label[for^="ipType_"], label[for^="killVirus_"]').addClass('radioLabel');
        $('select[name="fslip"]').click(function() {
            $('input[name="fslportReq"]').rules('remove', 'remote');
            $(this).rules('add', {remote: validRules.fslip.remote});
        });
    
        $('input[name="fslportReq"]').keypress(function() {
            $('select[name="fslip"]').rules('remove', 'remote');
            $(this).rules('add', {remote : validRules.fslportReq.remote});
        });
    });
</script>
