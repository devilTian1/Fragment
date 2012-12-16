<style type="text/css">
	.sectionDiv hr{ color:#09F;}
	.sectionDiv label{ width:120px; float:left; display:block;}
	.sectionDiv label input[type="checkbox"],.row input[type="checkbox"]{ width:10px;}
	.floatLeft input[type="radio"]{ width:10px;}
	span.floatLeft{ padding-left:10px; font-weight:bold}
</style>
<form action="Function/resConf/addrBind/safeBrowse_options.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">名称:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(过滤选项集的名称，被安全浏览任务引用)
        </div>
        
        <div class="row">
            <label>HTTP请求方法:</label>
            <div class="floatLeft">
               <input type="radio" name="http" value="all"/>允许
            </div>
            <div class="floatLeft">
               <input type="radio" name="http" value="part"/>阻止
            </div>
        </div>
        <div class="row">
         <div class="sectionDiv">
             <hr />
             <label><input type="checkbox" name="checkbox5" id="checkbox5" />GET</label>
          	 <label><input type="checkbox" name="checkbox6" id="checkbox6" />POST</label>
          	 <label><input type="checkbox" name="checkbox7" id="checkbox7" />PUT </label>
         	 <label><input type="checkbox" name="checkbox8" id="checkbox8" />HEAD</label>
         	 <label><input type="checkbox" name="checkbox9" id="checkbox9" />COMMONT</label>
             <br class="clearFloat"/>
             <hr />
         </div>
       </div>
       
       <div class="row">
            <label>URL过滤:</label>
            <div class="floatLeft">
               <input type="radio" name="http" value="all"/>允许
            </div>
            <div class="floatLeft">
               <input type="radio" name="http" value="part"/>阻止
            </div>
            <div class="floatLeft">
               <span class="floatLeft">选项：</span>
               <select name="select" class="w200">
               </select>
            </div>
      </div>
      
      <div class="row">
            <label>MIME类型过滤：</label>
            <div class="floatLeft">
               <input type="radio" name="http" value="all"/>允许
            </div>
            <div class="floatLeft">
               <input type="radio" name="http" value="part"/>阻止
            </div>
            <div class="floatLeft">
               <span class="floatLeft">选项：</span>
                <select name="select" class="w200">
                </select>
            </div>
      </div>
      
      <div class="row">
            <label>文件扩展名:</label>
            <div class="floatLeft">
               <input type="radio" name="http" value="all"/>允许
            </div>
            <div class="floatLeft">
               <input type="radio" name="http" value="part"/>阻止
            </div>
            <div class="floatLeft">
               <span class="floatLeft">选项：</span>
               <select name="select" class="w200">
               </select>
            </div>
      </div>
      
      <div class="row">
            <label>病毒扫描:</label>
            <div class="floatLeft">
               <input type="checkbox" name="http" value="all"/>允许
            </div>
            <div class="floatLeft">
               <input type="checkbox" name="http" value="part"/>阻止
            </div>
      </div>
      
      <div class="row">
          <label for="destip">缓存文件上限:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />兆字节(M) 针对文件扫描时，文件大小上限
      </div>
      
      <div class="row">
          <label for="destip">HTTP协议头部协议上限:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />字节(Bytes) 请求首部上限，最大为10240字节
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