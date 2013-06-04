<form action="Function/client/mail/mailfilter.php" method="POST"  id="editFilterForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<input type="hidden" name="id" value="<{$editFilter.id}>">
	<fieldset>
    	<legend>过滤选项集配置</legend>
    	<div class="row">
    		<label>名称:<em class="required">*</em></label>
    		<input class="width10em" type="text" name="MfilterName" value="<{$editFilter.name}>" size="15" maxlength="15"
    		<{if $type === 'edit'}>disabled="disabled"<{/if}>/>
    		<{if $type === 'edit'}><input type="hidden" name="MfilterName" value="<{$editFilter.name}>"><{/if}>
    	</div>
    	
    	<div class="row">
    		<label>协议类型:<em class="required">*</em></label>
    		<{html_radios class="radio" name=filterProtocol label_ids=true values=array('smtp', 'pop3')
              output=array('smtp', 'pop3') selected=$editFilter.protocol|default: 'smtp'
            }>  		
    	</div>
    	
    	<div class="row">
    		<label>允许最大附件(MB):</label>
    		<input class="id" type="text" name="attachmax" value="<{$editFilter.attachmaxsize|default: 100}>"
                size="15" maxlength="30"/>
    	</div>
    	
    	<div class="row">
    		<label>允许附件扩展名组:</label>
    		<{html_options class="filterSelect" name="allowextList"
                options=$allowextList selected=$editFilter.allowext}>   		 		
    	</div>
    	
    	<div class="row">
    		<label>发件人地址组:</label>
    		<{html_options class="filterSelect" name="senderList"
                options=$senderList selected=$editFilter.allowsender}>   
    	</div>
    	
    	<div class="row">
    		<label>发件人过滤类别:</label>
    		<{html_radios class="radio" name=sendfilter label_ids=true values=array('white', 'black')
              output=array('白名单', '黑名单') selected=$editFilter.sflag|default: 'white'
            }>  		
    	</div>
    	
    	<div class="row">
    		<label>收件人地址组:</label>
    		<{html_options class="filterSelect select" name="recvList"
                options=$recvList selected=$editFilter.allowrecv}> 
    	</div>
    	
    	<div class="row">
    		<label>收件人过滤类别:</label>
    		<{html_radios class="radio" name=recvfilter label_ids=true values=array('white', 'black')
              output=array('白名单', '黑名单') selected=$editFilter.rflag|default: 'white'
            }>      		 		
    	</div>
    	
    	<div class="row">
    		<label>主题关键字黑名单:</label>
    		<{html_options class="filterSelect select" name="skeywordList"
                options=$skeywordList selected=$editFilter.skeyword}>
    	</div>
    	
    	<div class="row">
    		<label>正文关键字黑名单:</label>
    		<{html_options class="filterSelect select" name="ckeywordList"
                options=$ckeywordList selected=$editFilter.ckeyword}>  		 		
    	</div>
    	
    	<div class="row">
    		<label>病毒扫描:<em class="required">*</em></label>
    		<{html_radios class="radio" name=fileav label_ids=true values=array('on', 'off')
              output=array('开', '关') selected=$editFilter.fileav|default: 'on'
            }>
    	</div>
    
        <div class="row">
        	<label>备注:</label>        	
        	<input class="width10em comment" name="comment" id="comment" value="<{$editFilter.comment|escape}>"/>       
        </div>
        
        <div class="row">      	
        	<span class="tip">注意:发件人地址组、收件人地址组选择“无”表示该过滤项的白名单和黑名单无效</span>
        </div>
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	renderStandardUi();
	validateForm($("#editFilterForm"));	
    $('label[for^="fileav_"], label[for^="recvfilter_"], label[for^="sendfilter_"], label[for^="filterProtocol_"]').addClass('radioLabel');
});
</script>
