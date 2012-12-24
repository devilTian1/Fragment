<style type="text/css">
	.floatLeft input[type="radio"]{ width:10px;}
	span.floatLeft{ padding-left:10px; font-weight:bold}
</style>
<form action="Function/client/msgTrans/msgTrans.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">任务号:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(同一端的任务号必须唯一)
        </div>
        
         <div class="row">
          <label for="destip">源地此:</label>
          <select name="select" class="w200" id="select">
          </select>
        </div>
        
        <div class="row">
          <label for="destip">本机地此:<em class="required">*</em></label>
          <select name="select" class="w200" id="select">
          </select>
        </div>
        
  		<div class="row">
          <label for="destip">本机端口:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-65535)
        </div>
        
         <div class="row">
            <label>HTTP身份认证及传输加密:</label>
            <div class="floatLeft">
               <input name="radio" type="radio" id="radio" value="radio" checked="checked" />是
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio" id="radio2" value="radio" />否
            </div>
        </div>
        
        <div class="row">
            <label>病毒扫描:</label>
            <div class="floatLeft">
               <input name="radio1" type="radio" id="radio" value="radio" checked="checked" />是
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio1" id="radio2" value="radio" />否
            </div>
        </div>
        
        <div class="row">
            <label>本机备份:</label>
            <div class="floatLeft">
               <input name="radio1" type="radio" id="radio" value="radio" checked="checked" />是
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio1" id="radio2" value="radio" />否
            </div>
        </div>
        
        <div class="row">
            <label>是否启动:</label>
            <div class="floatLeft">
               <input name="radio1" type="radio" id="radio" value="radio" checked="checked" />启动
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio1" id="radio2" value="radio" />停止
            </div>
        </div>
        
        <div class="row">
          <label for="destip">生效时段:</label>
          <select name="select" class="w200" id="select">
          </select>
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