<style type="text/css">
	.floatLeft input[type="radio"]{ width:10px;}
</style>
<form action="Function/resConf/addrBind/emailVisit_options.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">名称:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-15 字母、数字、减号、下划线、点的组合)
        </div>
        
         <div class="row">
            <label>协议类型:<em class="required">*</em></label>
            <div class="floatLeft">
               <input name="radio" type="radio" id="radio" value="radio" checked="checked" />smtp
            </div>
            <div class="floatLeft">
               <input type="radio" name="radio" id="radio2" value="radio" />pop3
            </div>
        </div>
        
        <div class="row">
          <label for="destip">允许最大附件:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />(单位M,默认为100M)
        </div>
        
        <div class="row">
          <label for="destip">允许最大附件:</label>
          <select name="select2" class="w200" id="select2">
          </select>
         （附件扩展名组名称)
        </div>
        
        <div class="row">
          <label for="destip">发件人地此组:</label>
          <select name="select2" class="w200" id="select2">
          </select>
         （来源邮件地此组名称)
        </div>
        
         <div class="row">
            <label>发件人过滤类别:</label>
            <div class="floatLeft">
               <input name="radio1" type="radio" id="radio3" value="radio" checked="checked" />黑名单
            </div>
            <div class="floatLeft">
               <input type="radio" name="radio1" id="radio4" value="radio" />白名单
            </div>
        </div>
        
        <div class="row">
          <label for="destip">收件人地此组:</label>
          <select name="select2" class="w200" id="select2">
          </select>
         （来源邮件地此组名称)
        </div>
        
        <div class="row">
            <label>收件人过滤类别:</label>
            <div class="floatLeft">
                <input name="radio2" type="radio" id="radio5" value="radio" checked="checked" />黑名单
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio2" id="radio6" value="radio" />白名单
            </div>
        </div>
        
        <div class="row">
          <label for="destip">主题关键字黑名单:</label>
          <select name="select2" class="w200" id="select2">
          </select>
         （来源于内容关键字名称)
        </div>
        
        <div class="row">
          <label for="destip">正文关键字黑名单:</label>
          <select name="select2" class="w200" id="select2">
          </select>
         （来源于内容关键字名称)
        </div>
        
        <div class="row">
            <label>病毒扫描:</label>
            <div class="floatLeft">
                <input name="radio2" type="radio" id="radio5" value="radio" checked="checked" />黑名单
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio2" id="radio6" value="radio" />白名单
            </div>
        </div>
        
        <div class="row">
          <label for="destip">备注:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />
        </div>
     </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
						   
});
</script>