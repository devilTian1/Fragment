<form action="Function/server/msgTrans/msgTrans.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label>任务号:<em class="required">*</em></label>
          <input class="id" type="text" name="msgTransId" id="msgTransId" value="<{$res.id}>" 
              <{if $type ==='edit'}>disabled="disabled"<{/if}>
              size="4" maxlength="4"/>
          (同一端的任务号必须唯一)
         <{if $type ==='edit'}>
             <input type="hidden" name="msgTransId" value="<{$res.id}>"/>
         <{/if}>
        </div>       
             
         <div class="row">
          <label>服务器地址:<em class="required">*</em></label>
          <input class="w150" type="text" name="ip" value="<{$res.serip}>" />
        </div>
        
         <div class="row">
          <label>服务器端口:<em class="required">*</em></label>
          <input class="port" type="text" name="serverPortReq" value="<{$res.serport}>" size="5" maxlength="5"/>
        </div>        
         <div class="row">
            <label>身份认证及传输加密:</label>
            <{html_radios class="radio" name=ssl label_ids=true values=array('Y', 'N')
                output=array('是', '否') selected=$res.ssl|default: 'N'}>
       </div>      
        
       <div class="row">
            <label>本机备份:</label>
            <{html_radios class="radio" name=backup label_ids=true values=array('Y', 'N')
                output=array('是', '否') selected=$res.backup|default: 'N'  
                disabled="disabled"}>
       </div>
      <div class="row">
            <label>是否启动:</label>
            <{html_radios class="radio" name=active label_ids=true values=array('ok', 'erro')
                output=array('是', '否') selected=$res.active|default: 'ok'}>
       </div>
        
        <div class="row">
          <label>备注:</label>         
          <input class="comment" name="comment" id="comment" value="<{$res.comment|escape}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function(){
    renderStandardUi();
    validateForm($("#editForm"));
});
</script>