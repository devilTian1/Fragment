<form action="Function/server/db/db.php" method="POST" id="serverEditForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label>任务号:<em class="required">*</em></label>
          <input class="id" type="text" name="clientId" id="clientId" value="<{$res.id}>" 
              <{if $type ==='edit'}>disabled="disabled"<{/if}>
              size="4" maxlength="4"/>
          (同一端的任务号必须唯一)
         <{if $type ==='edit'}>
             <input type="hidden" name="clientId" value="<{$res.id}>"/>
         <{/if}>
        </div>       
         <div class="row">
         	<label >数据库类型:<em class="required">*</em></label>
         	<{if $type === 'add'}>
          		<{html_options  class="w150" name="dbType" id="dbType"
                    output=array('oracle','mysql','DB2','sybase','sqlserver2000','sqlserver2005','sqlserver2008','sqlserver2012') 
                    values=array('oracle','mysql','DB2','sybase','sqlserver2000','sqlserver2005','sqlserver2008','sqlserver2012')
                    selected=$res.dbtype|default: 'oracle'  }>
        	<{else}>
        		<input type="text"  value="<{$res.dbtype}>" 
                	<{if $type ==='edit'}>disabled="disabled"<{/if}> />
                <{if $type ==='edit'}>
             		<input type="hidden" name="dbType" value="<{$res.dbtype}>"/>
         		<{/if}>              
        	<{/if}>
        </div>
             
         <div class="row">
          <label>服务器地址:<em class="required">*</em></label>
          <input  class="select sa" type="text" name="ip" value="<{$res.serverip}>" />
        </div>
        
         <div class="row">
          <label>服务器端口:<em class="required">*</em></label>
          <input class="port" type="text" name="sportReq" value="<{$res.sport}>" size="5" maxlength="5"/>
        </div>        
        
         <div class="row">
            <label>是否启动:<em class="required">*</em></label>
            <{html_radios class="radio" name=active label_ids=true values=array('Y', 'N')
                output=array('开', '关') selected=$res.active|default: 'Y'}>
        </div>       
        
        <div class="row">
          <label>备注:</label>          
          <input class="comment" name="comment" id="comment" value="<{$res.comment|escape}>"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#serverEditForm"));
});
</script>