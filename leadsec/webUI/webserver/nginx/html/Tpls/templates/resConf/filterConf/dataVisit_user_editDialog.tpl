<form action="Function/resConf/filterConf/dataVisit_user.php" method="POST" id="editUserFilterForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label >名称:<em class="required">*</em></label>
          <input type="text" name="name" value="<{$res.name}>" 
          	<{if $type ==='edit'}>disabled="disabled"<{/if}>/>
          (1-19个合法安符)
        </div>        
        <div class="row">
            <label>过滤模式:</label>
            <{html_radios class="radio" name=filterMold  values=array('A', 'F')
              output=array('允许', '阻止')
              selected=$res.allow|default: 'F' }>            
        </div>
        <div class="row">
          <label >用户名列表:<em class="required">*</em></label>
          <textarea rows="5" cols="30" name="userNameList"><{$res.usrnamelist}></textarea>( 1-1024字符. )
        </div>
        
        <div class="row">
                 说明:
                <div class="pl50">1.该用户名针对数据库访问用户;</div>
                <div class="pl50">2.多个用户名之间用（",")隔开</div>
        </div>
        <div class="row">
          <label>备注:</label>
         <textarea rows="5" cols="30" name="comment"><{$res.comment}></textarea>( 0-253字符. )
        </div>
   </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function(){
        renderStandardUi();
        validateForm($("#editUserFilterForm"));
    });
</script>