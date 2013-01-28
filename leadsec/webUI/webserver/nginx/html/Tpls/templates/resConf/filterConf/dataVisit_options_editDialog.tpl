<form action="Function/resConf/filterConf/dataVisit_options.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label >名称:<em class="required">*</em></label>
          <input type="text" name="name" value="<{$res.name}>" 
          	<{if $type ==='edit'}>disabled="disabled"<{/if}>/>
          (1-19个合法安符)
        </div>        
        <div class="row">
          <label>用户名过滤组:</label>
          <{html_options  class="w200" name="userName" 
                    output=$userList values=$userList
                    selected=$res.usergrp|default: 'empty'}>
        </div>  

        <div class="row">
          <label>SQL语句过滤组:</label>
          <{html_options  class="w200" name="sqlName" 
                    output=$sqlList values=$sqlList
                    selected=$res.sqlgrp|default: 'empty'}>
        </div>       
        <div class="row">
          <label>备注:</label>
         <textarea rows="5" cols="30" name="comment"><{$res.comment}></textarea>( 0-253字符. )
        </div>
   </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function(){
    renderStandardUi();
    validateForm($("#editForm"));
});
</script>