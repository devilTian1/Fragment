<style type="text/css">
	.floatLeft input[type="radio"]{ width:10px;}
	.floatLeft span{ float:left;}
</style>
<form action="Function/client/safePass/safePass.php" method="POST" id="editForm" onSubmit="return false;">
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
          <label for="destip">本机地此:</label>
          <select name="select" class="w200" id="select">
          </select>
        </div>
        
        <div class="row">
          <label for="destip">本机端口:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-65535)(输入形如:1200或2000：3000)
        </div>
        
        <div class="row">
            <label>身份认证及加密传输:</label>
            <div class="floatLeft">
               <input name="radio" type="radio" id="radio" value="radio" checked="checked" />是
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio" id="radio2" value="radio" />否
            </div>
        </div>
        
        <div class="row">
          <label for="destip">客户端证书公共名:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(0-3650 天，0表示不限制)
        </div>
        
        <div class="row">
            <label>病毒扫描:</label>
            <div class="floatLeft">
               <input name="radio" type="radio" id="radio" value="radio" checked="checked" />否
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio" id="radio2" value="radio" />二进制文件扫描
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio" id="radio2" value="radio" />全扫描
            </div>
        </div>
        
        <div class="row">
            <label>是否启动:</label>
            <div class="floatLeft">
               <input name="radio" type="radio" id="radio" value="radio" checked="checked" />启动
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio" id="radio2" value="radio" />停止
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