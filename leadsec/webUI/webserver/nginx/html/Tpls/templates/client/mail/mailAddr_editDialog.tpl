<form action="Function/client/mail/mailAddr.php" method="POST"  id="editMailAddrForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<input type="hidden" name="id" value="<{$editMail.id}>">
	<fieldset>
    	<legend>管理邮件地址过滤</legend>
    	<div class="row">
    		<label>名称:<em class="required">*</em></label>
    		<input type="text" name="mailName" value="<{$editMail.name}>" size="15" maxlength="15"
    		<{if $type === 'edit'}>disabled="disabled"<{/if}>/>
    		<{if $type === 'edit'}><input type="hidden" name="mailName" value="<{$editMail.name}>"><{/if}>
    	</div>
    	
    	<div class="row">
    		<label>邮件地址:</label>
    		<input type="text" name="mailAddr_txt" id="mailAddr_txt" value="" size="30" maxlength="30"/>    		
    	</div>
    	
    	<div class="row">
    		<label><em class="required">*</em></label>
    		<div class="column column_10"><button type="button" class="inputbtn standard" name="button" id="addmail" >&gt;&gt;</button>
    			<br/>
				<br/>
        		<button type="button" class="inputbtn standard" name="button" id="delmail" >&lt;&lt;</button>
        	</div>        	
        	<select name="mailList[]" size="6" multiple="multiple" id="mailList" style="width:160px" >
				<{foreach $mailList as $Array}>
					<option value='<{$Array}>'><{$Array}></option>
				<{/foreach}>
        	</select>    		 		
    	</div>
    	
    	<div class="row">
    		<label>类别:<em class="required">*</em></label>
    		<{html_radios class="radio" name=mailType label_ids=true values=array('recv', 'send')
              output=array('收件人', '发件人')
              selected=$mailType|default: 'recv'
            }>
    	</div>
    
        <div class="row">
        	<label>备注:</label>
        	<textarea name="comment" id="comment"><{$editMail.comment}></textarea>
        </div>
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	renderStandardUi();
	validateForm($("#editMailAddrForm"));
    $('label[for^="mailType_"]').addClass('radioLabel');
	$("#addmail").click(function(){
		if($("#editMailAddrForm").validate().element("#mailAddr_txt")) {
			var mail=$("#mailAddr_txt").val(),
			flag=0;
			$("#mailList option").each(function(){
				if($(this).val()==mail){
					flag=1;
				}
			});	
			if($("#mailList option").length >= 16)
			{
				flag=1;
			}
			if(flag==0&&mail!=''){
				var option = "<option value='"+mail+"'>"+mail+"</option>";                   
	        	$("#mailList").append(option);  
			}
		}
	});
	$("#mailList").dblclick(function(){  
		$("#mailList option:selected").each(function(){ 
			$(this).remove();  
		});  
     });
	$("#delmail").click(function(){
		$("#mailList option:selected").each(function(){
			$(this).remove();  
		});					   
	});	
});
</script>
