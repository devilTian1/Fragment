<form action="Function/resConf/addrBind/dataVisit_options.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">名称:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-19个合法安符)
        </div>
        
        <div class="row">
          <label for="destip">用户名过滤组:</label>
           <select name="select" class="w200" id="select"></select>
        </div>
        
        <div class="row">
          <label for="destip">SQL语句过滤组:</label>
           <select name="select" class="w200" id="select"></select>
        </div>
        
        <div class="row">
          <label for="destip">流病毒扫描:</label>
          <input type="checkbox" name="checkbox" id="checkbox" />
        </div>
        
         <div class="row">
          <label for="destip">备注:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />( 0-253字符. )
        </div>
   </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
						   
});
</script>