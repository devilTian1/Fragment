<form action="Function/client/db/userFilter.php" method="POST" id="editUserFilterForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label >名称:<em class="required">*</em></label>
          <input class="w150" type="text" name="userName" value="<{$res.name}>" 
          	<{if $type ==='edit'}>disabled="disabled"<{/if}>/>
        	<{if $type ==='edit'}>
             	<input type="hidden" name="userName" value="<{$res.name}>"/>
         	<{/if}>
        </div>        
        <div class="row">
            <label>过滤模式:</label>
            <{html_radios class="radio" name=filterMold  values=array('A', 'F')
              output=array('允许', '阻止')
              selected=$res.allow|default: 'A' }>            
        </div>
        <div class="row">
          <label >用户名列表:<em class="required">*</em></label>
          <textarea rows="5" cols="30" name="userFilterNameList" id="userFilterNameList"  maxlength="1025"><{$res.usrnamelist|escape}></textarea>
        </div>
        
        <div class="row">
                 说明:
                <div class="pl50">1.该用户名针对数据库访问用户;</div>
                <div class="pl50">2.多个用户名之间用（",")隔开</div>
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
        validateForm($("#editUserFilterForm"));
    });
</script>