<style type="text/css">
	.sectionDiv hr{ color:#09F;}
	.sectionDiv label{ width:120px; float:left; display:block;}
	.sectionDiv label input[type="checkbox"],.row input[type="checkbox"]{ width:12px;}
	.floatLeft input[type="radio"]{ width:10px;}
	span.floatLeft{ padding-left:10px; font-weight:bold}
</style>
<form action="Function/resConf/filterConf/dataVisit_sql.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label >名称:<em class="required">*</em></label>
          <input type="text" name="name" value="<{$res.name}>" 
          	<{if $type ==='edit'}>disabled="disabled"<{/if}> />        
          (1-19个合法安符)
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
                <{html_checkboxes class="radio" name=cmdInfo label_ids=true
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
           <textarea rows="5" cols="30" name="comment"><{$res.comment}></textarea>( 0-253字符. )
       </div>
   </fieldset>
</form>
<script type="text/javascript">

</script>