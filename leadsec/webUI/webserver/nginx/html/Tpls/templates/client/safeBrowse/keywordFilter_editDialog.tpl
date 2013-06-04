<form action="Function/client/safeBrowse/keywordFilter.php" method="POST"  id="editKeywordFilterForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<input type="hidden" name="id" value="<{$editKey.id}>">
	<fieldset>
    	<legend>管理关键字过滤</legend>
    	<div class="row">
    		<label>名称:<em class="required">*</em></label>
    		<input type="text" name="keyName" value="<{$editKey.name}>" size="15" maxlength="15"  class="width132"
    		<{if $type === 'edit'}>disabled="disabled"<{/if}>/>
    		<{if $type === 'edit'}><input type="hidden" name="keyName" value="<{$editKey.name}>"><{/if}>
    	</div>
    	
    	<div class="row">
    		<label>禁止的内容:</label>
    		<input type="text" name="context_txt" id="context_txt" value="" size="30" maxlength="30"/>(最大长度:30)    		
    	</div>
    	
    	<div class="row">
    		<label><em class="required">*</em></label>
    		<div class="column column_10"><button type="button" class="inputbtn standard" name="button" id="addContext" >&gt;&gt;</button>
    			<br/>
				<br/>
        		<button type="button" class="inputbtn standard" name="button" id="delContext" >&lt;&lt;</button>
        	</div>        	
        	<select name="contextList[]" size="6" multiple="multiple" id="contextList" style="width:160px" >
				<{foreach $contextList as $Array}>
					<option value='<{$Array}>' title='<{$Array}>'><{$Array}></option>
				<{/foreach}>
        	</select>    		 		
    	</div>
    
        <div class="row">
        	<label>备注:</label>        	
        	<input class="comment" name="comment" id="comment" value="<{$editKey.comment|escape}>"/>
        </div>
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	renderStandardUi();
	validateForm($("#editKeywordFilterForm"));
	$("#addContext").click(function(){
		var context=$("#context_txt").val(),
		flag=0;
		$("#contextList option").each(function(){
			if($(this).val()==context){
				flag=1;
			}
		});	
		if($("#contextList option").length >= 16)
		{
			flag=1;
		}
		if(flag==0&&context!=''){
			var option = "<option value='"+context+"' title='"+context+"'>"+context+"</option>";                   
        	$("#contextList").append(option);  
		}
	});
	$("#contextList").dblclick(function(){  
		$("#contextList option:selected").each(function(){ 
			$(this).remove();  
		});  
     });
	$("#delContext").click(function(){
		$("#contextList option:selected").each(function(){
			$(this).remove();  
		});					   
	});	
});
</script>