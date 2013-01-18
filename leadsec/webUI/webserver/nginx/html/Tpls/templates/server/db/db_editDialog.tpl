<form action="Function/server/db/db.php" method="POST" id="serverEditForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label>任务号:<em class="required">*</em></label>
          <input type="text" name="clientId" value="<{$res.id}>" 
              <{if $type ==='edit'}>disabled="disabled"<{/if}>
              size="4" maxlength="4"/>
          (同一端的任务号必须唯一)
         <{if $type ==='edit'}>
             <input type="hidden" name="clientId" value="<{$res.id}>"/>
         <{/if}>
        </div>       
        <div class="row">
          <label>数据库类型:<em class="required">*</em></label>
          <{html_options  class="w200" name="dbType" id="dbType"
                    output=array('oracle','sqlserver2005','sqlserver2008') 
                    values=array('oracle','sqlserver2005','sqlserver2008')
                    selected=$res.dbtype|default: 'oracle'}>
        </div>
             
         <div class="row">
          <label>服务器地址:<em class="required">*</em></label>
          <input type="text" name="ip" value="<{$res.serverip}>" />
        </div>
        
         <div class="row">
          <label>服务器端口:<em class="required">*</em></label>
          <input type="text" name="serverPort" value="<{$res.sport}>" />(1-65535)(输入形如:1200或2000：3000)
        </div>        
        
         <div class="row">
            <label>是否启动:<em class="required">*</em></label>
            <{html_radios class="radio" name=active label_ids=true values=array('Y', 'N')
                output=array('开', '关') selected=$res.active|default: 'Y'}>
        </div>       
        
        <div class="row">
          <label>备注:</label>
          <textarea rows="10" cols="30" name="comment" id="comment"><{$res.comment}></textarea>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#serverEditForm"));
});
</script>