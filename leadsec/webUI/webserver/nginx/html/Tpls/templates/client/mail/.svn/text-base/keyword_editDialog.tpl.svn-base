<form action="Function/client/mail/keyword.php" method="POST"  id="editKeywordForm" onSubmit="return false;">
	<input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
	<input type="hidden" name="id" value="<{$editKeyword.id}>">
	<fieldset>
    	<legend>关键字设置</legend>
    	<div class="row">
    		<label>名称:<em class="required">*</em></label>
    		<input type="text" name="keywordName" value="<{$editKeyword.name}>" size="15" maxlength="15"
    		<{if $type === 'edit'}>disabled="disabled"<{/if}>/>
    		<{if $type === 'edit'}><input type="hidden" name="keywordName" value="<{$editKeyword.name}>"><{/if}>
    	</div>
    	
    	<div class="row">
    		<label>关键字:</label>
    		<input type="text" name="keyword_txt" id="keyword_txt" value="" size="30" maxlength="30"/>    		
    	</div>
    	<div class="row paraminfo">
            <ul>
                <li>               
                                                      关键字最大长度30
                </li>
            </ul>
        </div>
    	<div class="row">
    		<label><em class="required">*</em></label>
    		<div class="column column_10"><button type="button" class="inputbtn standard" name="button" id="addkeyword" >&gt;&gt;</button>
    			<br/>
				<br/>
        		<button type="button" class="inputbtn standard" name="button" id="delkeyword" >&lt;&lt;</button>
        	</div>        	
        	<select name="keywordList[]" size="6" multiple="multiple" id="keywordList" style="width:160px" >
				<{foreach $keywordList as $Array}>
					<option value='<{$Array}>'><{$Array}></option>
				<{/foreach}>
        	</select>    		 		
    	</div>
    	
    	<div class="row">
    		<label>类别:<em class="required">*</em></label>
    		<{html_radios class="radio" name=keywordType label_ids=true values=array('subject', 'context')
              output=array('主题', '正文')
              selected=$keywordType|default: 'subject'
            }>
    	</div>
    
        <div class="row">
        	<label>备注:</label>
        	<input class="comment" name="comment" id="comment" value="<{$editKeyword.comment|escape}>"/>        	
        </div>
	</fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	renderStandardUi();
	validateForm($("#editKeywordForm"));
    $('label[for^="keywordType_"]').addClass('radioLabel');
	$("#addkeyword").click(function(){
		if($("#editKeywordForm").validate().element("#keyword_txt")) {
			var keyword=$("#keyword_txt").val(),
			flag=0;
			$("#keywordList option").each(function(){
				if($(this).val()==keyword){
					flag=1;
				}
			});	
			if($("#keywordList option").length >= 16)
			{
				flag=1;
			}
			if(flag==0&&keyword!=''){
				var option = "<option value='"+keyword+"'>"+keyword+"</option>";                   
	        	$("#keywordList").append(option);  
			}
		}
	});
	$("#keywordList").dblclick(function(){  
		$("#keywordList option:selected").each(function(){ 
			$(this).remove();  
		});  
     });
	$("#delkeyword").click(function(){
		$("#keywordList option:selected").each(function(){
			$(this).remove();  
		});					   
	});	
});
</script>
