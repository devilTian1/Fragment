<style type="text/css">
	#filetypeLable label{ display:block; float:left; width:60px;}
	.sectionDiv hr{ color:#09F;}
	.sectionDiv label{ width:120px; float:left; display:block;}
	.sectionDiv label input[type="checkbox"]{ width:10px;}
	.floatLeft input[type="radio"]{ width:10px;}
</style>
<form action="Function/resConf/addrBind/fileExchange_options.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
         <div class="row">
          <label for="destip">名称:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-15 字母、数字、减号、下划线、点的组合)
        </div>
        
        <div class="row">
          <label for="destip">允许文件组名:</label>
          <select name="select" class="w200" id="select3">
          </select>
        </div>
        
        <div class="row">
          <label for="destip">内容黑名单:</label>
          <select name="select" class="w200" id="select3">
          </select>
        </div>
        
        <div class="row">
          <label for="destip">内容白名单:</label>
          <select name="select" class="w200" id="select3">
          </select>
        </div>
        <div class="row">
          <label for="">文件类型:</label>
        </div>
        <div class="row">
         <div class="sectionDiv">
              <hr />
             <label><input name="EXE" type="checkbox" value="EXE" />EXE</label>
            <label><input name="PDF" type="checkbox" value="PDF" />PDF</label>
            <label><input name="RAR" type="checkbox" value="RAR" />RAR</label>
            <label><input name="ZIP" type="checkbox" value="ZIP" />ZIP</label>
            <label><input name="MSO" type="checkbox" value="MSO" />MSO</label>
            <label><input name="ELF" type="checkbox" value="ELF" />ELF</label>
            <label><input name="JPG" type="checkbox" value="JPG" />JPG</label>
            <label><input name="TGZ" type="checkbox" value="TGZ" />TGZ</label>
            <br class="clearFloat"/>
            <span class="red"> 所有微软office文件都属于MSO类型</span> 
             <hr />
         </div>
       </div>
       
       <div class="row">
            <label>类型过滤操作:</label>
            <div class="floatLeft">
               <input name="radio1" type="radio" id="radio11" value="radio" checked="checked" />允许
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio1" id="radio12" value="radio" />禁止
            </div>
      </div>
      
      <div class="row">
            <label>文件大小:</label>
            <span class="floatLeft">下限</span><input type="text" name="inputtext2"  class="inputtext"/>
        	<span class="floatLeft">上限</span><input type="text" name="inputtext4"  class="inputtext"/>K
      </div>
      
      <div class="row">
            <label>文件修改时间:</label>
            <span class="floatLeft">下限</span><input type="text" name="inputtext2"  class="inputtext"/>
        	<span class="floatLeft">上限</span><input type="text" name="inputtext4"  class="inputtext"/>
           
      </div>
        <div class="row">
                <div>说明：有效时间格式(YYYY/MM/DD-hh:mm:ss)</div>
                <hr/>
        </div>
       <div class="row">
          <label for="destip">备注:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />
       </div>
  </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
						   
});
</script>