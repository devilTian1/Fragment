<form action="Function/resConf/addrBind/msgPass_filename.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">允许的文件名:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-19个合法安符)
        </div>
         <div class="row">
                 说明:
                <div class="pl50">文件名中可以含有的通配符*与?,但不能包含以下字符% \ / : &quot; &lt; &gt; | '</div>
        </div>
          </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
						   
});
</script>