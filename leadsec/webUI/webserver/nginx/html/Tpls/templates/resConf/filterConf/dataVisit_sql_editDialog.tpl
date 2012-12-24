<style type="text/css">
	.sectionDiv hr{ color:#09F;}
	.sectionDiv label{ width:120px; float:left; display:block;}
	.sectionDiv label input[type="checkbox"],.row input[type="checkbox"]{ width:10px;}
	.floatLeft input[type="radio"]{ width:10px;}
	span.floatLeft{ padding-left:10px; font-weight:bold}
</style>
<form action="Function/resConf/addrBind/dataVisit_sql.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">名称:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-19个合法安符)
        </div>
        
        <div class="row">
            <label>过滤模式:</label>
            <div class="floatLeft">
               <input name="http" type="radio" value="all" checked="checked"/>允许
            </div>
            <div class="floatLeft">
               <input type="radio" name="http" value="part"/>阻止
            </div>
        </div>
        
        <div class="row">
            <label>SQL语句列表:<em class="required">*</em></label>
        </div>
        <div class="row">
         <div class="sectionDiv">
             <hr />
              <label><input type="checkbox" name="checkbox" id="checkbox" />CREATE</label>
         	 <label> <input type="checkbox" name="checkbox2" id="checkbox2" />DELETE</label>
              <label><input type="checkbox" name="checkbox3" id="checkbox3" />INTERT</label>
         	 <label><input type="checkbox" name="checkbox4" id="checkbox4" />UPDATE </label>
          	 <label><input type="checkbox" name="checkbox5" id="checkbox5" />ALTER</label>
          	<label><input type="checkbox" name="checkbox6" id="checkbox6" />DROP </label>
         	 <label><input type="checkbox" name="checkbox7" id="checkbox7" />SELECT</label>
             <br class="clearFloat"/>
             <hr />
         </div>
       </div>
       
       <div class="row">
                 说明:
                <div class="pl50"><span class="red">注：禁用SELECT命令会造成数据库连接不成功</span></div>
       </div>
       
        <div class="row">
          <label for="destip">备注:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />( 0-253字符. )
        </div>
   </fieldset>
</form>
<script type="text/javascript">

</script>