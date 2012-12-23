<style type="text/css">
	.sectionDiv hr{ color:#09F;}
	.sectionDiv label{ width:120px; float:left; display:block;}
	.sectionDiv label input[type="checkbox"],.row input[type="checkbox"]{ width:10px;}
	.floatLeft input[type="radio"]{ width:10px;}
	span.floatLeft{ padding-left:10px; font-weight:bold}
</style>
<form action="Function/resConf/addrBind/ftpVisit.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <legend>常规配置</legend>
		<div class="row">
          <label for="destip">名称:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />
        </div>
        <div class="row">
          <label for="destip">Banner保护：</label>
          <input type="text" name="destip" value="<{$res.destip}>" />
        </div>
        <div class="row">
          <label for="destip">备注:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />
        </div>
     </fieldset>
     
     <fieldset>
     	<legend>用户控制</legend>
        <div class="row">
          <label for="destip">禁止用户:</label>
          	<input name="radio" type="radio" id="radio" value="radio" checked="checked" />
        	<input type="text" name="inputtext3" />多个用户用,隔开
        </div>
        <div class="row">
          <label for="destip">允许用户:</label>
          	<input name="radio" type="radio" id="radio" value="radio" checked="checked" />
        	<input type="text" name="inputtext3" />多个用户用,隔开
        </div>
     </fieldset>
     
     <fieldset>
     	<legend>命令控制</legend>
       <div class="row">
            <label>控制动作:</label>
            <div class="floatLeft">
               <input name="http" type="radio" value="all" checked="checked"/>禁止命令
            </div>
            <div class="floatLeft">
               <input type="radio" name="http" value="part"/>允许命令
            </div>
        </div>
        
        <div class="row">
            <label>命令行列表:</label>
        </div>
        <div class="row">
         <div class="sectionDiv">
             <hr />
             <label><input type="checkbox" name="checkbox4" id="checkbox4" />dir </label>
     		 <label><input type="checkbox" name="checkbox5" id="checkbox5" />delete</label>
     		 <label><input type="checkbox" name="checkbox6" id="checkbox6" />ls</label>
      		 <label><input type="checkbox" name="checkbox7" id="checkbox7" />cd</label> 
      		 <label><input type="checkbox" name="checkbox8" id="checkbox8" />get </label>
      		 <label><input type="checkbox" name="checkbox9" id="checkbox9" />put</label>
      		 <label><input type="checkbox" name="checkbox10" id="checkbox10" />pwd</label>
       		 <label><input type="checkbox" name="checkbox11" id="checkbox11" />quit</label>
      		 <label><input type="checkbox" name="checkbox12" id="checkbox12" />mkdir</label>
     		 <label><input type="checkbox" name="checkbox13" id="checkbox13" />rename</label>
      		 <label><input type="checkbox" name="checkbox14" id="checkbox14" />radir</label>
      		 <label><input type="checkbox" name="checkbox15" id="checkbox15" /> append</label>
             <br class="clearFloat"/>
             <hr />
         </div>
       </div>
     </fieldset>
     
     <fieldset>
     	<legend>上传控制</legend>
        <div class="row">
                 说明:
                <div class="pl50 red">多个文件类型用,分开，单个.表示没有后缀的文件，如.exe,.txt</div>
        </div>
        <div class="row">
          <label for="destip">禁止上传文件类型:</label>
          	<input name="radio" type="radio" id="radio" value="radio" checked="checked" />
        	<input type="text" name="inputtext3" />
        </div>
        <div class="row">
          <label for="destip">允许下载文件类型:</label>
          	<input name="radio" type="radio" id="radio" value="radio" checked="checked" />
        	<input type="text" name="inputtext3" />
        </div>
        
     </fieldset>
     
      <fieldset>
     	<legend>下载控制</legend>
        <div class="row">
                 说明:
                <div class="pl50 red">多个文件类型用,分开，单个.表示没有后缀的文件，如.exe,.txt</div>
        </div>
        <div class="row">
          <label for="destip">禁止下载文件类型:</label>
          	<input name="radio" type="radio" id="radio" value="radio" checked="checked" />
        	<input type="text" name="inputtext3" />
        </div>
        <div class="row">
          <label for="destip">允许上传文件类型:</label>
          	<input name="radio" type="radio" id="radio" value="radio" checked="checked" />
        	<input type="text" name="inputtext3" />
        </div>
        
     </fieldset>
     
     <fieldset>
     	<legend>缓存控制</legend>
        <div class="row">
          <label for="destip">文件大小上限:</label>
        	<input type="text" name="inputtext3" />兆(M)(针对缓存文件过滤时，文件大小上限)
        </div>
        <div class="row">
            <label>文件病毒扫描:</label>
            <div class="floatLeft">
               <input name="http" type="radio" value="all" checked="checked"/>开启
            </div>
            <div class="floatLeft">
               <input type="radio" name="http" value="part"/>关闭
            </div>
        </div>
       <div class="row">
          <label for="destip">边收边发机制:</label>
        	 <input type="checkbox" name="checkbox16" id="checkbox16" />(可保持活连接，减少延迟)
        </div>
     </fieldset>  
</form>
<script type="text/javascript">
$(document).ready(function() {
						   
});
</script>