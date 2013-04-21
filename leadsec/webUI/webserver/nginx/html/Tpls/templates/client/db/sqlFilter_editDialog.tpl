<style type="text/css">
	.sectionDiv hr{ color:#09F;}
	.sectionDiv label{ width:120px; float:left; display:block;}
	.sectionDiv label input[type="checkbox"],.row input[type="checkbox"]{ width:12px;}
	.floatLeft input[type="radio"]{ width:10px;}
	span.floatLeft{ padding-left:10px; font-weight:bold}
</style>
<form action="Function/client/db/sqlFilter.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label >名称:<em class="required">*</em></label>
          <input class="w150" type="text" id="sqlName" name="sqlName" value="<{$res.name}>" 
          	<{if $type ==='edit'}>disabled="disabled" <{/if}> />    
          <{if $type ==='edit'}>
             <input type="hidden" name="sqlName" value="<{$res.name}>"/>
          <{/if}>	    
        </div>
        
        <div class="row">
            <label>过滤模式:</label>
            <{html_radios class="radio" name=filterMold  values=array('A', 'F')
              output=array('允许', '阻止')
              selected=$res.allow|default: 'F' }>            
        </div>
      
       <div class="row">
           <hr /> 
           <label>SQL语句列表:<em class="required">*</em></label>
           <div class="column column_70">
                <{html_checkboxes class="radio" name=sqlCmdInfo label_ids=true
                    output=array('CREATE', 'DELETE', 'INSERT', 'UPDATE', 'ALTER', 'DROP', 'SELECT')
                    values=array('CREATE', 'DELETE', 'INSERT', 'UPDATE', 'ALTER', 'DROP', 'SELECT')
                    checked=$res.sqllist}>
           </div>
       </div>       
       <div class="row">
                 说明:
           <div class="pl50"><span class="red">注：禁用SELECT命令会造成数据库连接不成功</span></div>
       </div>
       <hr />
       <div class="row">
          <label>备注:</label>         
          <input class="comment" name="comment" id="comment" value="<{$res.comment|escape}>"/>
       </div>
   </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function(){
    renderStandardUi();
    validateForm($("#editForm"));
});
</script>