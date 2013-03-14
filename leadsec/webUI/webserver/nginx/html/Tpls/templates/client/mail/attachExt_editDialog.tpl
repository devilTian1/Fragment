<form action="Function/client/mail/attachExt.php" method="POST"  id="editAttachExtForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<input type="hidden" name="id" value="<{$editAtt.id}>">
	<fieldset>
    	<legend>附件扩展名设置</legend>
    	<div class="row">
    		<label>名称:<em class="required">*</em></label>
    		<input type="text" name="attachName" value="<{$editAtt.name}>" size="15" maxlength="15"
    		<{if $type === 'edit'}>disabled="disabled"<{/if}>/>
    		<{if $type === 'edit'}><input type="hidden" name="attachName" value="<{$editAtt.name}>"><{/if}>
    	</div>
    	
    	<div class="row">
    		<label>扩展名:</label>
    		<input type="text" name="attach_txt" id="attach_txt" value="" size="30" maxlength="30"/>    		
    	</div>
    	
    	<div class="row">
    		<label><em class="required">*</em></label>
    		<div class="column column_10"><button type="button" class="inputbtn standard" name="button" id="addAtt" >&gt;&gt;</button>
    			<br/>
				<br/>
        		<button type="button" class="inputbtn standard" name="button" id="delAtt" >&lt;&lt;</button>
        	</div>        	
        	<select name="attachList[]" size="6" multiple="multiple" id="attachList" style="width:160px" >
				<{foreach $attachList as $Array}>
					<option value='<{$Array}>'><{$Array}></option>
				<{/foreach}>
        	</select>    		 		
    	</div>
    
        <div class="row">
        	<label>备注:</label>        	
        	<input class="comment" name="comment" id="comment" value="<{$editAtt.comment}>"/>        	
        </div>
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	renderStandardUi();
	validateForm($("#editAttachExtForm"));
	$("#addAtt").click(function(){
		if($("#editAttachExtForm").validate().element("#attach_txt")) {
			var attachExt=$("#attach_txt").val(),
			flag=0;
			$("#attachList option").each(function(){
				if($(this).val()==attachExt){
					flag=1;
				}
			});	
			if($("#attachList option").length >= 16)
			{
				flag=1;
			}
			if(flag==0&&attachExt!=''){
				var option = "<option value='"+attachExt+"'>"+attachExt+"</option>";                   
	        	$("#attachList").append(option);  
			}
		}
	});
	$("#attachList").dblclick(function(){  
		$("#attachList option:selected").each(function(){ 
			$(this).remove();  
		});  
     });
	$("#delAtt").click(function(){
		$("#attachList option:selected").each(function(){
			$(this).remove();  
		});					   
	});	
});
</script>