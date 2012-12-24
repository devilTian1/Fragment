<form action="Function/resConf/addrBind/safeBrowse_extend.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
    <fieldset>
        <!--<legend></legend>-->
		<div class="row">
          <label for="destip">名称:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />( 1-19合法字符，9个中文汉字)
        </div>
        
        <div class="row">
          <label for="destip">文件扩展名列表:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" class="w200" />
        </div>
        <div class="row">
                <div>说明：</div>
            	<p>多个扩展名用,隔开，如，doc,exe</p>
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