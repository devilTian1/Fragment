<form action="Function/resConf/addrBind/msgPass_blacklist.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">禁止的内容:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-19个合法安符)
        </div>
         <div class="row">
                 说明:
                <div class="pl50">*代表任意字符，包括空格</div>
                <div class="pl50">？代表任意单个字符</div>
                <div class="pl50">\\代表单个\</div>
                <div class="pl50">\*代表单个*</div>
                <div class="pl50">\?代表单个?</div>
        </div>
     </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
						   
});
</script>