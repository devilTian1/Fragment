<form action="Function/client/db/optionsFilter.php" method="POST" id="optionFilterEditForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label >名称:<em class="required">*</em></label>
          <input class="w150" type="text" name="optionName" value="<{$res.name}>" 
          	<{if $type ==='edit'}>disabled="disabled"<{/if}>/>
          <{if $type ==='edit'}>
             <input type="hidden" name="optionName" value="<{$res.name}>"/>
          <{/if}>
        </div>        
        <div class="row">
          <label>用户名过滤组:</label>
          <{html_options  class="select time" name="userNameList" 
                    output=$userList values=$userList
                    selected=$res.usergrp|default: 'empty'}>
        </div>  

        <div class="row">
          <label>SQL语句过滤组:</label>
          <{html_options  class="select time" name="sqlNameList" 
                    output=$sqlList values=$sqlList
                    selected=$res.sqlgrp|default: 'empty'}>
        </div>       
        <div class="row">
          <label>备注:</label>        
          <input class="comment" name="comment" id="comment" value="<{$res.comment|escape}>"/>
        </div>
   </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function(){
    renderStandardUi();
    validateForm($("#optionFilterEditForm"));
});
</script>