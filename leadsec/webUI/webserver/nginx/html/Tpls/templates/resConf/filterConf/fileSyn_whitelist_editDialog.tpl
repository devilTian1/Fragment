<form action="Function/resConf/addrBind/fileSyn_whitelist.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">禁止的内容:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />( 1-19合法字符，9个中文汉字)
        </div>
        
        <div class="row">
                 支持的通配符:
                <div class="pl50">*代表任意字符，包括空格</div>
                <div class="pl50">？代表任意单个字符</div>
                <div class="pl50">\\代表单个\</div>
                <div class="pl50">\*代表单个*</div>
                <div class="pl50">\?代表单个?</div>
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