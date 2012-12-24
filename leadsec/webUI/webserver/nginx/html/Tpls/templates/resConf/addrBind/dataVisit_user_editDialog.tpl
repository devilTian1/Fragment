<style type="text/css">
	.floatLeft input[type="radio"]{ width:10px;}
</style>
<form action="Function/resConf/addrBind/dataVisit_user.php" method="POST" id="editForm" onSubmit="return false;">
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
          <label for="destip">用户名列表:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-1024个字符)
        </div>
        
        <div class="row">
                 说明:
                <div class="pl50">1.该用户名针对数据库访问用户;</div>
                <div class="pl50">2.多个用户名之间用（",")隔开</div>
        </div>
        <div class="row">
          <label for="destip">备注:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />( 0-253字符. )
        </div>
   </fieldset>
</form>
<script type="text/javascript">

</script>