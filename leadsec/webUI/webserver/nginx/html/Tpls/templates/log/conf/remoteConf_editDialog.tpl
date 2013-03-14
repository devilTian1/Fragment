<form action="Function/log/conf/remoteConf.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" id ="type" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label >服务器IP:<em class="required">*</em></label>
          <input type="text"  name="remoteLogIp" value="<{$res.logsrv}>" 
              <{if $type ==='edit'}>disabled="disabled"<{/if}> />             
         <{if $type ==='edit'}>
             <input type="hidden" name="remoteLogIp" value="<{$res.logsrv}>"/>
         <{/if}>
        </div>                           
        <div class="row">
            <label for="dportReq">端口:<em class="required">*</em></label>
            <input class="port" type="text" name="logPortReq"
                value="<{$res.port|default: '514'}>" size="5" maxlength="5"/>
        </div>
        
         <div class="row">
            <label>协议:<em class="required">*</em></label>
            <{html_radios class="radio" name=protocol label_ids=true output=array('UDP', 'TCP')
                values=array('udp', 'tcp') selected=$res.protocol|default: 'udp'}>
        </div>                 
        
        <div class="row">
          <label >备注:</label>        
          <input class="comment" name="comment" id="comment" value="<{$res.comment}>"/>
        </div>
    </fieldset>
</form>

<script type="text/javascript">
$(document).ready(function(){
    renderStandardUi();
    validateForm($("#editForm"));
});
</script>