<style type="text/css">
	.floatLeft input[type="radio"]{ width:10px;}
	span.floatLeft{ padding-left:10px; font-weight:bold}
</style>
<form action="Function/client/customized/tcpTransVisit.php" method="POST" id="editForm" onSubmit="return false;">
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
          <label for="destip">目的地此:</label>
          <select name="select" class="w200" id="select">
          </select>
        </div>
        
        <div class="row">
          <label for="destip">目的端口:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />
        </div>
        
         <div class="row">
            <label>流病毒扫描:</label>
            <div class="floatLeft">
               <input name="radio" type="radio" id="radio" value="radio" checked="checked" />开
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio" id="radio2" value="radio" />关
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
          <label for="destip">认证用户组:</label>
          <select name="select" class="w200" id="select">
          </select>
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