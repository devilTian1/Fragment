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
            <label>访问类型:</label>
            <div class="floatLeft">
               <input name="radio" type="radio" id="radio" value="radio" checked="checked" />普通访问
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio" id="radio2" value="radio" />透明访问
            </div>
        </div>
        
        <div class="row">
          <label for="destip">源地此:</label>
          <select name="select" class="w200" id="select">
          </select>
        </div>
        
         <div class="row">
          <label for="destip">源端口:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-65535)(输入形如:1200或2000：3000)
        </div>
        
        <div class="row">
          <label for="destip">目的地此:</label>
          <select name="select" class="w200" id="select">
          </select>
        </div>
        
        <div class="row">
          <label for="destip">目的端口:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-65535)(输入形如:1200或2000：3000)
        </div>
        
        <div class="row">
          <label for="destip">服务类型:</label>
          <select name="select" class="w200" id="select">
          </select>
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
            <label>开启日志:</label>
            <div class="floatLeft">
               <input name="radio" type="radio" id="radio" value="radio" checked="checked" />是
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio" id="radio2" value="radio" />否
            </div>
        </div>
        <hr class="clearFloat"/>
        
        <div class="row">
            <label>抗攻击:</label><br/>
              	<div class="floatLeft"><span><input name="" type="checkbox" value="" />抗SYN Flood</span><input name="" type="text" />个/秒</div>
            	<div class="floatLeft"><span><input name="" type="checkbox" value="" />抗UDP Flood</span><input name="" type="text" />个/秒</div>
            	<div class="floatLeft"><span><input name="" type="checkbox" value="" />抗ICMP Flood</span><input name="" type="text" />个/秒</div>
            	<div class="floatLeft"><input name="" type="checkbox" value="" />抗Ping of Death</div>
        </div>
		<hr class="clearFloat"/>
        
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