<style type="text/css">
	.floatLeft input[type="radio"]{ width:10px;}
	.floatLeft span{ float:left;}
</style>
<form action="Function/server/dbSync/dbSync.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <div class="row">
            <label for="serverDbId">任务号:<em class="required">*</em></label>
            <input class="id" type="text" name="serverDbId" value="<{$data.id}>"
                <{if $type === 'edit'}>disabled="disabled"<{/if}>
                size="4" maxlength="4"/>
            (同一端的任务号必须唯一)
            <{if $type === 'edit'}>
            <input type="hidden" name="serverDbId" value="<{$data.id}>"/>
            <{/if}>
        </div>
   
        <div class="row">
            <label for="lip">服务器地址:<em class="required">*</em></label>
			<input class="id" type="text" name="serverip" value="<{$data.serverip}>"
        </div>
        
        <div class="row">
            <label for="fslportReq">服务器端口:<em class="required">*</em></label>
            <input class="port" type="text" name="sport" value="<{$data.sport}>" size="5" maxlength="5"/>
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
       
        <div class="row">
            <label>是否启动:</label>
            <{html_radios class="radio" name=active  values=array('Y', 'N')
                output=array('启动', '停止') selected=$data.active|default: 'Y'
            }>
        </div>
        
        <div class="row">
            <label for="comment">备注:</label>           
            <input class="comment" name="comment" id="comment" value="<{$data.comment}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
	$(document).ready(function() {
		toggleCNameDiv();
		validateForm($("#editForm"));					   
	});
</script>