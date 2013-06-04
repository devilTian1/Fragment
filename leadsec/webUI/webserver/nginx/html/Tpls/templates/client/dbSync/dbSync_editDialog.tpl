<style type="text/css">
	.floatLeft input[type="radio"]{ width:10px;}
	.floatLeft span{ float:left;}
</style>
<form action="Function/client/dbSync/dbSync.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <div class="row">
            <label for="clientDbSyncTaskId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="clientDbSyncTaskId" id="clientDbSyncTaskId" value="<{$data.id}>"
                <{if $type === 'edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type === 'edit'}>
            <input type="hidden" name="clientDbId" value="<{$data.id}>"/>
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
            <label for="clientDbSyncLip">本机地址:</label>
            <{html_options class="select lip" name="clientDbSyncLip" id="clientDbSyncLip"
                options=$ifList selected=$data.lip|default: '无'}>
        </div>
        
        <div class="row">
            <label for="clientDbSyncLport">本地端口:<em class="required">*</em></label>
            <input class="port" type="text" name="clientDbSyncLport" id="clientDbSyncLport"
			value="<{$data.lport}>" size="5" maxlength="5"/>
        </div>
        
        <div class="row">
            <label>身份认证及传输加密:</label>
            <{html_radios class="radio" name=ssl label_ids=true
                values=array('Y', 'N') output=array('是', '否') 
				selected=$data.ssl|default: 'Y' onClick="toggleCNameDiv()"
            }>
        </div>
        
         <div class="row cNameDiv">
            <label>客户端证书公共名:<em class="required">*</em></label>
            <input type="text" class="width132" name="commname" value="<{$data.commname}>"/>
        </div>
       

		<div class="row">
            <label>病毒扫描:</label>
            <{html_radios class="radio" name=killVirus label_ids=true values=array('2', '0','1')
                output=array('全扫描', '否','二进制扫描') selected=$data.killvirus|default: '2'
            }>
        </div>

        
        <div class="row">
            <label>是否启动:</label>
            <{html_radios class="radio" name=active  values=array('Y','N')
                output=array('启动', '停止') selected=$data.active|default: 'Y'
            }>
        </div>
        
        <div class="row">
            <label for="time">生效时间:</label>
            <{html_options class="select time" name="time" options=$timeList
                selected=$data.time|default: '无'}>
            </select>
        </div>
        
        <div class="row">
            <label for="comment">备注:</label>           
            <input class="comment" class="width132" name="comment" id="comment" value="<{$data.comment}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
	$(document).ready(function() {
		filterRes();
		toggleCNameDiv();
		validateForm($("#editForm"));	
		/*
		$('select[name="clientDbSyncLip"]').click(function() {
            $('#clientDbSyncLport').rules('remove', 'remote');
            $(this).rules('add', {remote: validRules.clientDbSyncLip.remote});
        });
    
        $('#clientDbSyncLport').keypress(function() {
            $('select[name="clientDbSyncLip"]').rules('remove', 'remote');
            $(this).rules('add', {remote : validRules.clientDbSyncLport.remote});
        });*/
	});

</script>