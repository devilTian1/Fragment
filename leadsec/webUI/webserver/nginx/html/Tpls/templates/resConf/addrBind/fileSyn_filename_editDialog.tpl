<form action="Function/resConf/addrBind/fileSyn_filename.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">允许的文件名:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />( 1-19合法字符，9个中文汉字)
        </div>
         <div class="row">
                 说明:
                <div class="pl50">文件名中可以含有的通配符*与?,但不能包含以下字符% \ / : &quot; &lt; &gt; | '</div>
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